//
//  VideoSynthesizer.m
//  Image&AudioConvertToVideoDemo
//
//  Created by AugustRush on 11/22/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "VideoSynthesizer.h"
#import <AVFoundation/AVFoundation.h>

NSString *const _SyntheticVideoErrorDomain = @"SyntheticVideoErrorDomain";

@implementation VideoSynthesizer {
    dispatch_queue_t _mediaInputQueue;
}

#pragma mark - init methods

+ (instancetype)shareInstance {
    static VideoSynthesizer *synthesizer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        synthesizer = [[VideoSynthesizer alloc] init];
    });
    
    return synthesizer;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

#pragma mark - private methods

- (void)setUp {
    _mediaInputQueue = dispatch_queue_create("com.augustrush.video_synthesizer.media_input_queue", DISPATCH_QUEUE_CONCURRENT);
}

- (CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef)image size:(CGSize)size {
    NSDictionary *options =[NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithBool:YES],kCVPixelBufferCGImageCompatibilityKey,
                            [NSNumber numberWithBool:YES],kCVPixelBufferCGBitmapContextCompatibilityKey,nil];
    CVPixelBufferRef pxbuffer = NULL;
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,size.width,size.height,kCVPixelFormatType_32ARGB,(__bridge CFDictionaryRef) options,&pxbuffer);
    
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer , 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace=CGColorSpaceCreateDeviceRGB();
    CGContextRef context =CGBitmapContextCreate(pxdata,size.width,size.height,8,4*size.width,rgbColorSpace,kCGImageAlphaPremultipliedFirst);
    NSParameterAssert(context);
    
    CGContextDrawImage(context,CGRectMake(0,0,size.width,size.height), image);
    
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer,0);
    
    return pxbuffer;
}

- (CMTimeRange)timeRangeWithRange:(NSRange)range timescale:(CMTimeScale)timescale {
    CMTime startTime = CMTimeMakeWithSeconds(range.location, timescale);
    CMTime length = CMTimeMakeWithSeconds(range.length, timescale);
    
    CMTimeRange timeRange = CMTimeRangeMake(startTime, length);
    return timeRange;
}

- (void)syntheticVideoWithConfiguration:(SyntheticedVideoSettings *)configuration images:(NSArray *)images completion:(void(^)(NSString *path))completion failed:(void(^)(NSError *err))failed {
    NSString *videoPath = configuration.outputPath;
    //remove target path file
    unlink([videoPath UTF8String]);
    
    __block NSError *error = nil;
    AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:videoPath] fileType:configuration.fileType error:&error];
    
    if (error) {
        failed(error);
    }
    NSParameterAssert(videoWriter);
    
    NSDictionary *videoSettings = @{AVVideoCodecKey: AVVideoCodecH264,
                                    AVVideoWidthKey: @(configuration.outputSize.width),
                                    AVVideoHeightKey: @(configuration.outputSize.height)};
    
    AVAssetWriterInput *writerInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
    
    NSDictionary *sourcePixelBufferAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kCVPixelFormatType_32ARGB],kCVPixelBufferPixelFormatTypeKey,nil];
    AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:writerInput sourcePixelBufferAttributes:sourcePixelBufferAttributesDictionary];
    NSParameterAssert(writerInput);
    NSParameterAssert([videoWriter canAddInput:writerInput]);
    [videoWriter addInput:writerInput];
    
    //start a seesion
    [videoWriter startWriting];
    [videoWriter startSessionAtSourceTime:kCMTimeZero];
    
    __block int frame = 0;
    [writerInput requestMediaDataWhenReadyOnQueue:_mediaInputQueue usingBlock:^{
        
        CFTimeInterval duration = configuration.outputDuration;
        int FPS = configuration.outputFPS;
        int allFrames = FPS * duration;
        int remainder = (allFrames % images.count);
        int multiple = allFrames / images.count;
        allFrames = remainder > 0 ? (int)images.count * multiple : allFrames;
        int imageAverageFrames = allFrames / images.count;
        
        while([writerInput isReadyForMoreMediaData])
        {
            if(frame >= allFrames)
            {
                [writerInput markAsFinished];
                [videoWriter finishWritingWithCompletionHandler:^{
                    completion(videoPath);
                }];
                break;
            }
            
            CVPixelBufferRef buffer = NULL;
            
            int idx = frame / imageAverageFrames;
            NSLog(@"idx==%d frame == %d",idx, frame);
            
            buffer = [self pixelBufferFromCGImage:[[images objectAtIndex:idx] CGImage] size:configuration.outputSize];
            
            if (buffer)
            {
                BOOL success = [adaptor appendPixelBuffer:buffer withPresentationTime:CMTimeMake(frame,FPS)];
                CFRelease(buffer);
                if(!success) {
                    error = [self errorWithCode:VideoSynthesizerErrorCodeAppendPixelBufferFailed description:@"append pixel buffer failed"];
                    failed(error);
                    break;
                }
            }
            
            ++frame;
        }
    }];
}

- (NSError *)errorWithCode:(VideoSynthesizerErrorCode)code description:(NSString *)description {
    return [NSError errorWithDomain:_SyntheticVideoErrorDomain code:VideoSynthesizerErrorCodeHasNoAudioTracks userInfo:@{@"Description":description}];
}

#pragma mark - public methods

- (void)syntheticVideoWithSettings:(void(^)(SyntheticedVideoSettings *configuration))settings images:(NSArray<UIImage *> *)images completion:(void(^)(NSString *path))completion failed:(void(^)(NSError *err))failed {
    SyntheticedVideoSettings *configuration = [[SyntheticedVideoSettings alloc] init];
    if (settings) {
        settings(configuration);
    }
    [self syntheticVideoWithConfiguration:configuration images:images completion:completion failed:failed];
}

#pragma mark - Audio / Images to Video

#define kGetCMTimeDuration(time) (time.value / time.timescale)

- (void)syntheticVideoWithSettings:(void (^)(SyntheticedVideoSettings * _Nonnull))settings backgroundAudioPath:(NSString *)audioPath images:(NSArray *)images completion:(void (^)(NSString * _Nonnull))completion failed:(void (^)(NSError * _Nonnull))failed {

    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    AVURLAsset *audioAsset = [AVURLAsset URLAssetWithURL:audioURL options:nil];
    NSArray *audioTracks = [audioAsset tracksWithMediaType:AVMediaTypeAudio];
    __block NSError *error = nil;
    if (audioTracks.count > 0) {
        AVAssetTrack *firstAudioTrack = [audioTracks firstObject];
        SyntheticedVideoSettings *configuration = [[SyntheticedVideoSettings alloc] init];
        configuration.outputDuration = kGetCMTimeDuration(firstAudioTrack.asset.duration);
        if (settings) {
            settings(configuration);
        }
        
        [self syntheticVideoWithConfiguration:configuration images:images completion:^(NSString *path) {
            NSURL *videoURL = [NSURL fileURLWithPath:path];
            AVURLAsset *videoAsset = [AVURLAsset assetWithURL:videoURL];

            NSArray<AVAssetTrack *> *videoTracks = [videoAsset tracksWithMediaType:AVMediaTypeVideo];
            if (videoTracks.count > 0) {
                
                AVAssetTrack *firstVideoTrack = videoTracks.firstObject;
                
                AVMutableComposition *mixCompisition = [AVMutableComposition composition];
                CMTime start = kCMTimeZero;
                CMTime duration = audioAsset.duration;
                
                CMTimeRange timeRange = CMTimeRangeMake(start, duration);
                
                AVMutableCompositionTrack *compisitionAudioTrack = [mixCompisition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
                [compisitionAudioTrack insertTimeRange:timeRange ofTrack:firstAudioTrack atTime:kCMTimeZero error:&error];
                if (error) {
                    failed(error);
                    return ;
                }
                
                AVMutableCompositionTrack *compisitionVideoTrack = [mixCompisition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
                [compisitionVideoTrack insertTimeRange:timeRange ofTrack:firstVideoTrack atTime:kCMTimeZero error:&error];
                if (error) {
                    failed(error);
                    return ;
                }
                
                //AVAssetExportSession用于合并文件，导出合并后文件，presetName文件的输出类型
                AVAssetExportSession *assetExportSession = [[AVAssetExportSession alloc] initWithAsset:mixCompisition presetName:AVAssetExportPresetPassthrough];
                
                NSString *outPutPath = configuration.outputPath;
                //混合后的视频输出路径
                NSURL *outPutUrl = [NSURL fileURLWithPath:outPutPath];
                //remove file
                unlink([outPutPath UTF8String]);
                //输出视频格式 AVFileTypeMPEG4 AVFileTypeQuickTimeMovie...
                assetExportSession.outputFileType = AVFileTypeQuickTimeMovie;
                //    NSArray *fileTypes = assetExportSession.
                
                assetExportSession.outputURL = outPutUrl;
                //输出文件是否网络优化
                assetExportSession.shouldOptimizeForNetworkUse = YES;
                
                [assetExportSession exportAsynchronouslyWithCompletionHandler:^{
                    completion(outPutPath);
                }];
                
                
            }

        } failed:failed];
        
        
    } else {
        error = [NSError errorWithDomain:_SyntheticVideoErrorDomain code:VideoSynthesizerErrorCodeHasNoAudioTracks userInfo:@{@"description":@"Audio File has no audio tracks!"}];
        failed(error);
    }
    
}

@end
