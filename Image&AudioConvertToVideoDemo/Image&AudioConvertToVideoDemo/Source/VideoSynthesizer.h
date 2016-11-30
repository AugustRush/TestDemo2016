//
//  VideoSynthesizer.h
//  Image&AudioConvertToVideoDemo
//
//  Created by AugustRush on 11/22/16.
//  Copyright © 2016 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SyntheticedVideoSettings.h"

typedef enum : NSInteger {
    VideoSynthesizerErrorCodeUndefined = - 1,
    VideoSynthesizerErrorCodeNoError = 0,
    VideoSynthesizerErrorCodeHasNoAudioTracks,
    VideoSynthesizerErrorCodeAppendPixelBufferFailed,
} VideoSynthesizerErrorCode;

NS_ASSUME_NONNULL_BEGIN
@interface VideoSynthesizer : NSObject

+ (instancetype)shareInstance;

- (void)syntheticVideoWithSettings:(void(^)(SyntheticedVideoSettings *configuration))settings images:(NSArray<UIImage *> *)images completion:(void(^)(NSString *path))completion failed:(void(^)(NSError *err))failed;

- (void)syntheticVideoWithSettings:(void(^)(SyntheticedVideoSettings *configuration))settings backgroundAudioPath:(NSString *)audioPath images:(NSArray *)images completion:(void(^)(NSString *path))completion failed:(void(^)(NSError *err))failed;

@end
NS_ASSUME_NONNULL_END
