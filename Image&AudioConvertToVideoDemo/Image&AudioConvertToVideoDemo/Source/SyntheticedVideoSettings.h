//
//  SyntheticedVideoSettings.h
//  Image&AudioConvertToVideoDemo
//
//  Created by AugustRush on 11/22/16.
//  Copyright © 2016 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SyntheticedVideoSettings : NSObject

@property (nonatomic, copy) NSString *outputName;
@property (nonatomic, assign) CFTimeInterval outputDuration;
@property (nonatomic, assign) CGSize outputSize;
@property (nonatomic, copy) NSString *outputRootPath;
@property (nonatomic, assign) int outputFPS;
@property (nonatomic, copy) NSString *fileType;

@property (nonatomic, copy, readonly) NSString *fileTypeName;
@property (nonatomic, copy, readonly) NSString *outputPath;

@end
