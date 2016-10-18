//
//  AsyncLabel.m
//  AsyncLabel
//
//  Created by AugustRush on 6/16/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "AsyncLabel.h"
#import <CoreText/CoreText.h>
#import "CATransaction+Perfrom.h"

@interface AsyncLabel ()

@end

@implementation AsyncLabel {
    CGSize _contentSize;
    NSMutableAttributedString *_innerText;
    CTFramesetterRef _framesetter;
    CGFloat _preferredMaxLayoutWidth;
    CGImageRef _contentImage;
    CGFloat _contentScale;
    
    struct {
        unsigned int _needUpdateFramesetter: 1;
        unsigned int _needUpdateInnerText: 1;
        unsigned int _needRedraw: 1;
    } _state;
}

#pragma mark - Life cycle methods

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (void)dealloc {
    if (_framesetter) {
        CFRelease(_framesetter);
    }
    if (_contentImage) {
        CGImageRelease(_contentImage);
    }
}

#pragma mark - private methods

- (void)_commonInit {
    _innerText = [[NSMutableAttributedString alloc] init];
    _textColor = [UIColor whiteColor];
    _font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    _contentScale = self.layer.contentsScale;
    //
    _asyncDisplay = YES;
    _state._needRedraw = YES;
    
    CFRunLoopRef runloop = CFRunLoopGetMain();
    CFRunLoopObserverRef observer;
    
    observer = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopBeforeWaiting | kCFRunLoopExit, true, 0xFFFFFF, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"acticity is %lu",activity);
        if (_state._needRedraw) {
            _preferredMaxLayoutWidth = CGRectGetWidth(self.bounds);
            [self _invalidateContentSize];
            [self setNeedsDisplay];
            _state._needRedraw = NO;
        }
    });
    CFRunLoopAddObserver(runloop, observer, kCFRunLoopCommonModes);
    CFRelease(observer);
}

#pragma mark - text methods

- (CTFramesetterRef)_framesetter {
    if (!_framesetter || _state._needUpdateFramesetter) {
        _framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)[self _innerText]);
        _state._needUpdateFramesetter = NO;
    }
    return _framesetter;
}

- (NSMutableAttributedString *)_innerText {
    if (!_innerText || _state._needUpdateInnerText) {
        
        _innerText = [[NSMutableAttributedString alloc] initWithString:_text];
        NSRange textRange = NSMakeRange(0, _innerText.length);
        // 设置行距等样式
        CGFloat lineSpace = 2; // 行距一般取决于这个值
        CGFloat lineSpaceMax = 2;
        CGFloat lineSpaceMin = 1;
        const CFIndex kNumberOfSettings = 3;
        
        // 结构体数组
        CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
            
            {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpace},
            {kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(CGFloat),&lineSpaceMax},
            {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(CGFloat),&lineSpaceMin}
            
        };
        CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
        
        [_innerText addAttribute:NSParagraphStyleAttributeName value:(__bridge id)(theParagraphRef) range:textRange];
        CFRelease(theParagraphRef);
        
        [_innerText addAttribute:NSFontAttributeName value:(id)_font range:textRange];
        [_innerText addAttribute:(id)kCTForegroundColorAttributeName value:_textColor range:textRange];
        
        _state._needUpdateInnerText = NO;
    }
    
    return _innerText;
}

- (void)_invalidateContentSize {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CTFramesetterRef framesetter = [self _framesetter];
    NSMutableAttributedString *attributedText = [self _innerText];
    _contentSize = CTFramesetterSuggestFrameSizeForAttributedStringWithConstraints(framesetter, attributedText, CGSizeMake(_preferredMaxLayoutWidth, CGFLOAT_MAX), _numberOfLines);
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [CATransaction commit];
}

#pragma mark - override methos

- (void)setText:(NSString *)text {
    if (![_text isEqualToString:text]) {
        _text = text;
        _state._needUpdateInnerText = YES;
        _state._needUpdateFramesetter = YES;
        _state._needRedraw = YES;
    }
}

- (void)setFrame:(CGRect)frame {
    if (!CGRectEqualToRect(self.frame, frame)) {
        [super setFrame:frame];
        _preferredMaxLayoutWidth = CGRectGetWidth(frame);
        _state._needRedraw = YES;
    }
}

- (void)setBounds:(CGRect)bounds {
    if (!CGRectEqualToRect(self.bounds, bounds)) {
        [super setBounds:bounds];
        _preferredMaxLayoutWidth = CGRectGetWidth(bounds);
        _state._needRedraw = YES;
    }
}

- (CGSize)intrinsicContentSize {
    return _contentSize;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"asdasd");
        CGFloat width = CGRectGetWidth(rect);
        CGFloat height = CGRectGetHeight(rect);

        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(NULL, width*_contentScale, height*_contentScale, 8, 0, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
        
        //release color space
        CGColorSpaceRelease(colorSpace);
    
        //
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        CGContextScaleCTM(context, _contentScale, _contentScale);
        //
        
        CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor); //black color
        CGContextFillRect(context, rect);
        
        // 3.创建绘制区域，可以对path进行个性化裁剪以改变显示区域
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, rect);
        
        // 5.根据NSAttributedString生成CTFramesetterRef
        CTFramesetterRef framesetter = [self _framesetter];
        NSAttributedString *attributed = [self _innerText];
        CTFrameRef ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributed.length), path, NULL);
        
        // 6.绘制除图片以外的部分
        CTFrameDraw(ctFrame, context);
        //create image
        CGImageRef img = CGBitmapContextCreateImage(context);
        UIImage *image = [UIImage imageWithCGImage:img];
        dispatch_async(dispatch_get_main_queue(), ^{
            [CATransaction perform:^{
               self.layer.contents = (__bridge id)image.CGImage; 
            }];
        });
        // 7.内存管理，ARC不能管理CF开头的对象，需要我们自己手动释放内存
        CGContextRelease(context);
        CGImageRelease(img);
        CFRelease(path);
        CFRelease(ctFrame);
    });
}

static inline CGFLOAT_TYPE CGFloat_ceil(CGFLOAT_TYPE cgfloat) {
#if CGFLOAT_IS_DOUBLE
    return ceil(cgfloat);
#else
    return ceilf(cgfloat);
#endif
}

static inline CGSize CTFramesetterSuggestFrameSizeForAttributedStringWithConstraints(CTFramesetterRef framesetter, NSAttributedString *attributedString, CGSize size, NSUInteger numberOfLines) {
    CFRange rangeToSize = CFRangeMake(0, (CFIndex)[attributedString length]);
    CGSize constraints = CGSizeMake(size.width, CGFLOAT_MAX);
    
    if (numberOfLines == 1) {
        // If there is one line, the size that fits is the full width of the line
        constraints = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    } else if (numberOfLines > 0) {
        // If the line count of the label more than 1, limit the range to size to the number of lines that have been set
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectMake(0.0f, 0.0f, constraints.width, CGFLOAT_MAX));
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
        CFArrayRef lines = CTFrameGetLines(frame);
        
        if (CFArrayGetCount(lines) > 0) {
            NSInteger lastVisibleLineIndex = MIN((CFIndex)numberOfLines, CFArrayGetCount(lines)) - 1;
            CTLineRef lastVisibleLine = CFArrayGetValueAtIndex(lines, lastVisibleLineIndex);
            
            CFRange rangeToLayout = CTLineGetStringRange(lastVisibleLine);
            rangeToSize = CFRangeMake(0, rangeToLayout.location + rangeToLayout.length);
        }
        
        CFRelease(frame);
        CGPathRelease(path);
    }
    
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, rangeToSize, NULL, constraints, NULL);
    
    return CGSizeMake(CGFloat_ceil(suggestedSize.width), CGFloat_ceil(suggestedSize.height));
}

@end
