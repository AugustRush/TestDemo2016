//
//  BIGameBar.m
//  BaiduInputLib
//
//  Created by samuel on 12/31/15.
//
//

#import "BIGameBar.h"
#import "UIView+BIAutoLayout.h"

#define kCountDownTimeInterval 0.1

#define kGameBarLabelFontSize(width)                                           \
  ({                                                                           \
    CGFloat fontSize = 17.0;                                                   \
    CGFloat widthRatio = width / 320.0;                                        \
    fontSize *= widthRatio;                                                    \
    fontSize;                                                                  \
  })

#define kGameBarLabelTextKern 1.0

@interface BIGameBarLabel : UIImageView

@property(nonatomic, strong, readonly) UILabel *textLabel;

@end

@implementation BIGameBarLabel

- (instancetype)init {
  self = [super init];
  if (self) {
    [self setUp];
  }
  return self;
}

- (void)setUp {
  self.contentMode = UIViewContentModeScaleAspectFit;

  _textLabel = [[UILabel alloc] init];
  _textLabel.textAlignment = NSTextAlignmentRight;
  _textLabel.adjustsFontSizeToFitWidth = YES;
  [self addSubview:_textLabel];

  [_textLabel anchor:BILayoutAttributeLeft
              toView:self
          toPosition:BILayoutAttributeRight
          multiplier:0.3];
  [_textLabel makeWidthEqual:self mutiplier:0.6];
  [_textLabel anchor:BILayoutAttributeTop toSuperView:BILayoutAttributeTop];
  [_textLabel anchor:BILayoutAttributeBottom
         toSuperView:BILayoutAttributeBottom];
}

@end

@implementation BIGameBar {
  UIImageView *_backgoundImageView;
  BIGameBarLabel *_timeLabel;
  BIGameBarLabel *_moneyLabel;
  UIButton *_exitButton;
  NSTimeInterval _gameTime;
  __weak NSTimer *_timer;
  NSTimeInterval _countDownNumber;
}

@synthesize backgroundImageView = _backgoundImageView;

#pragma mark - init methods

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setUp];
  }
  return self;
}

#pragma mark - private methods

- (void)setUp {
  self.userInteractionEnabled = YES;
  self.clipsToBounds = NO;
  _countDownNumber = 0.0;
  // subviews
  _backgoundImageView = [[UIImageView alloc] init];
  [self addSubview:_backgoundImageView];

  UIImage *timeImage = [UIImage imageNamed:@"gamebar_timeicon"];
  _timeLabel = [[BIGameBarLabel alloc] init];
  _timeLabel.image = timeImage;
  [self addSubview:_timeLabel];

  UIImage *gemImage = [UIImage imageNamed:@"gamebar_gemicon"];
  _moneyLabel = [[BIGameBarLabel alloc] init];
  _moneyLabel.image = gemImage;
  [_moneyLabel.textLabel
      setAttributedText:[self attributedMoneyTextWithMoney:0]];
  [self addSubview:_moneyLabel];

  UIImage *exitImage = [UIImage imageNamed:@"gamebar_monkey_normal"];
  _exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [_exitButton setImage:exitImage forState:UIControlStateNormal];
  [_exitButton setImage:[UIImage imageNamed:@"gamebar_monkey_press"]
               forState:UIControlStateHighlighted];
  [_exitButton addTarget:self
                  action:@selector(exitButtonTapped:)
        forControlEvents:UIControlEventTouchUpInside];
  [_exitButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
  [self addSubview:_exitButton];

  // layout
  [_backgoundImageView anchorCenterToSuperView];
  [_backgoundImageView makeWidthEqual:self];
  [_backgoundImageView makeHeightEqual:self];

  // |(65/890.0)-(200/890.0)-(40/890.0)-(260/890.0)-...

  CGFloat timeImageRatio = timeImage.size.width / timeImage.size.height;
  //    [_timeLabel autoSetHeight:kDefaultLabelHeight];
  //    [_timeLabel autoSetWidth:kDefaultLabelHeight * timeImageRatio];
  CGFloat widthRatio = 200 / 890.0;
  [_timeLabel makeWidthEqual:self mutiplier:widthRatio];
  [_timeLabel makeAttribute:NSLayoutAttributeHeight
                     toView:self
                toAttribute:NSLayoutAttributeWidth
                 multiplier:widthRatio / timeImageRatio
                   constant:0.0];
  [_timeLabel anchor:BILayoutAttributeLeft
              toView:self
          toPosition:BILayoutAttributeRight
          multiplier:65 / 890.0];
  [_timeLabel anchorCenterYToSuperView];

  CGFloat moneyImageRatio = gemImage.size.width / gemImage.size.height;
  [_moneyLabel anchorCenterYToSuperView];
  [_moneyLabel anchor:BILayoutAttributeLeft
               toView:_timeLabel
           toPosition:BILayoutAttributeRight
             constant:10];
  [_moneyLabel makeHeightEqual:_timeLabel];
  [_moneyLabel makeAttribute:NSLayoutAttributeWidth
                      toView:_timeLabel
                 toAttribute:NSLayoutAttributeHeight
                  multiplier:moneyImageRatio
                    constant:0.0];

  [_exitButton anchor:BILayoutAttributeRight
          toSuperView:BILayoutAttributeRight
             constant:0.0];
  [_exitButton anchorCenterYToSuperView];
  [_exitButton anchor:BILayoutAttributeLeft
               toView:_moneyLabel
           toPosition:BILayoutAttributeRight
             constant:0];
  [_exitButton makeHeightEqual:self mutiplier:1.2];

  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(orientationDidChanged:)
             name:UIDeviceOrientationDidChangeNotification
           object:nil];
}

- (void)fillContents {
  // contents
  NSAssert(self.dataSourceDelegate != nil,
           @"BIGameBar dataSource should not be nil!!!");
  _gameTime = [self.dataSourceDelegate gameTime];

  [_timeLabel.textLabel
      setAttributedText:[self attributedTimeTextWithTime:_gameTime]];

  [self setNeedsLayout];
  [self layoutIfNeeded];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  [self fillContents];
}

- (NSAttributedString *)attributedMoneyTextWithMoney:(NSUInteger)money {
  CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
  NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
  NSString *timeText = [NSString stringWithFormat:@"%lu", (unsigned long)money];
  NSAttributedString *middle = [[NSAttributedString alloc]
      initWithString:timeText
          attributes:@{
            NSForegroundColorAttributeName : [UIColor greenColor],
            NSFontAttributeName : [UIFont fontWithName:@"Marker Felt" size:kGameBarLabelFontSize(screenWidth)],
            NSKernAttributeName : @(kGameBarLabelTextKern)
          }];
  [string appendAttributedString:middle];
  return string;
}

- (NSAttributedString *)attributedTimeTextWithTime:(NSTimeInterval)time {
  CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
  NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
  NSString *timeText = [NSString stringWithFormat:@"%1.1f", time];
  NSAttributedString *middle = [[NSAttributedString alloc]
      initWithString:timeText
          attributes:@{
            NSForegroundColorAttributeName : [UIColor greenColor],
            NSFontAttributeName : [UIFont fontWithName:@"Marker Felt" size:kGameBarLabelFontSize(screenWidth)],
            NSKernAttributeName : @(kGameBarLabelTextKern)
          }];
  NSAttributedString *last = [[NSAttributedString alloc]
      initWithString:@"s"
          attributes:@{
            NSForegroundColorAttributeName : [UIColor greenColor],
            NSFontAttributeName : [UIFont
                fontWithName:@"Trebuchet MS" size:kGameBarLabelFontSize(screenWidth) / 2.0]
          }];

  [string appendAttributedString:middle];
  [string appendAttributedString:last];
  return string;
}

- (void)orientationDidChanged:(NSNotification *)notification {
  [self fillContents];
  NSString *moneyString = _moneyLabel.textLabel.attributedText.string;
  _moneyLabel.textLabel.attributedText =
      [self attributedMoneyTextWithMoney:moneyString.integerValue];
}

#pragma mark - timer method

- (void)countDown {
  _countDownNumber += kCountDownTimeInterval;
  if (_countDownNumber >= _gameTime) {
    [self invalidateTimer];
    [self timeout];
  }
  NSTimeInterval remainTime =
      (_gameTime - _countDownNumber) > 0 ? (_gameTime - _countDownNumber) : 0;
  [_timeLabel.textLabel
      setAttributedText:[self attributedTimeTextWithTime:remainTime]];
}

- (void)invalidateTimer {
  [_timer invalidate];
  _timer = nil;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - event methods

- (void)exitButtonTapped:(id)sender {
  if ([self.delegate respondsToSelector:@selector(gameBarClosed:)]) {
    [self.delegate gameBarClosed:self];
    [self invalidateTimer];
    [self fillContents];
    _moneyLabel.textLabel.attributedText =
        [self attributedMoneyTextWithMoney:0];
  }
}

- (void)timeout {
  if ([self.delegate respondsToSelector:@selector(gameBarTimeout:)]) {
    [self.delegate gameBarTimeout:self];
  }
}

#pragma mark - piblic methods

- (void)start {
  _countDownNumber = 0.0;
  [_timer invalidate];
  _timer = [NSTimer scheduledTimerWithTimeInterval:kCountDownTimeInterval
                                            target:self
                                          selector:@selector(countDown)
                                          userInfo:nil
                                           repeats:YES];
}

- (void)updateMoney:(NSUInteger)count {
  [_moneyLabel.textLabel
      setAttributedText:[self attributedMoneyTextWithMoney:count]];

  [self setNeedsLayout];
  [self layoutIfNeeded];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
