//
//  SyntheticedVideoSettings.m
//  Image&AudioConvertToVideoDemo
//
//  Created by AugustRush on 11/22/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "SyntheticedVideoSettings.h"
#import <AVFoundation/AVFoundation.h>

@implementation SyntheticedVideoSettings

- (instancetype)init {
    self = [super init];
    if (self) {
        _outputName = @"default";
        _outputDuration = 1.0;
        _outputSize = CGSizeMake(320,400);
        _outputRootPath = [self defaultVideoRootPath];
        _outputFPS = 30;
        _fileType = AVFileTypeQuickTimeMovie;
    }
    return self;
}

#pragma mark - public methods

- (NSString *)fileTypeName {
    if (_fileType == AVFileTypeQuickTimeMovie) {
        return @".mov";
    } else if (_fileType == AVFileTypeMPEG4) {
        return @".mp4";
    } else if (_fileType == AVFileTypeAppleM4V) {
        return @".m4v";
    } else if (_fileType == AVFileTypeAppleM4A) {
        return @".m4a";
    } else if (_fileType == AVFileType3GPP) {
        return @".3gp";
    } else if (_fileType == AVFileType3GPP2) {
        return @".3g2";
    } else if (_fileType == AVFileTypeCoreAudioFormat) {
        return @".caf";
    } else if (_fileType == AVFileTypeWAVE) {
        return @".wav";
    } else if (_fileType == AVFileTypeAIFF) {
        return @".aif";
    } else if (_fileType == AVFileTypeAIFC) {
        return @".aifc";
    } else if (_fileType == AVFileTypeAMR) {
        return @".amr";
    } else if (_fileType == AVFileTypeMPEGLayer3) {
        return @".mp3";
    } else if (_fileType == AVFileTypeSunAU) {
        return @".au";
    } else if (_fileType == AVFileTypeAC3) {
        return @".ac3";
    } else if (_fileType == AVFileTypeEnhancedAC3) {
        return @".eac3";
    }
    
    return nil;
}

- (NSString *)defaultVideoRootPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *moviePath = [paths objectAtIndex:0];
    return moviePath;
}

- (NSString *)outputPath {
    return [_outputRootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",_outputName,self.fileTypeName]];
}


@end
