//
//  BIGameBarLevelView.m
//  BaiduInputLib
//
//  Created by AugustRush on 1/4/16.
//
//

#import "BIGameBarLevelView.h"

#define kDefaultStarsCount 5

@implementation BIGameBarLevelView {
  BIGameBarStarView *_strokeStarsView;
  BIGameBarStarView *_fillStarsView;
}

#pragma mark - init method

- (instancetype)init {
  self = [super init];
  if (self) {
    [self setUp];
  }
  return self;
}

#pragma mark - private methods

- (void)setUp {
  self.clipsToBounds = YES;
  self.backgroundColor = [UIColor clearColor];

  _strokeStarsView = [[BIGameBarStarView alloc] init];
  _strokeStarsView.contentsLayer.contents = (id)[UIImage imageNamed:@"gamebar_star_normal"].CGImage;
  [self addSubview:_strokeStarsView];

  _fillStarsView = [[BIGameBarStarView alloc] init];
  _fillStarsView.contentsLayer.contents = (id)[UIImage imageNamed:@"gamebar_star_filled"].CGImage;
  _fillStarsView.starsCount = 2;
  [self addSubview:_fillStarsView];

  _strokeStarsView.translatesAutoresizingMaskIntoConstraints = NO;
  [self
      addConstraint:[NSLayoutConstraint constraintWithItem:_strokeStarsView
                                                 attribute:NSLayoutAttributeLeft
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:self
                                                 attribute:NSLayoutAttributeLeft
                                                multiplier:1
                                                  constant:0]];
  [self
      addConstraint:[NSLayoutConstraint constraintWithItem:_strokeStarsView
                                                 attribute:NSLayoutAttributeTop
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:self
                                                 attribute:NSLayoutAttributeTop
                                                multiplier:1
                                                  constant:0]];
  [self addConstraint:[NSLayoutConstraint
                          constraintWithItem:_strokeStarsView
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1
                                    constant:0]];

  [self addConstraint:[NSLayoutConstraint
                          constraintWithItem:_strokeStarsView
                                   attribute:NSLayoutAttributeWidth
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeWidth
                                  multiplier:1.0 / kDefaultStarsCount
                                    constant:0]];

  _fillStarsView.translatesAutoresizingMaskIntoConstraints = NO;
  [self
      addConstraint:[NSLayoutConstraint constraintWithItem:_fillStarsView
                                                 attribute:NSLayoutAttributeLeft
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:self
                                                 attribute:NSLayoutAttributeLeft
                                                multiplier:1
                                                  constant:0]];
  [self
      addConstraint:[NSLayoutConstraint constraintWithItem:_fillStarsView
                                                 attribute:NSLayoutAttributeTop
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:self
                                                 attribute:NSLayoutAttributeTop
                                                multiplier:1
                                                  constant:0]];
  [self addConstraint:[NSLayoutConstraint
                          constraintWithItem:_fillStarsView
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1
                                    constant:0]];

  [self addConstraint:[NSLayoutConstraint
                          constraintWithItem:_fillStarsView
                                   attribute:NSLayoutAttributeWidth
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeWidth
                                  multiplier:1.0 / kDefaultStarsCount
                                    constant:0]];
}

- (void)setLevel:(NSUInteger)level
{
    _level = level;
    _fillStarsView.starsCount = level;
}

@end

//*** star view

@interface BIGameBarStarView ()

@property(nonatomic, strong) CALayer *contentsLayer;

@end

@implementation BIGameBarStarView

- (instancetype)init {
  self = [super init];
  if (self) {
    [self setUp];
  }
  return self;
}

+ (Class)layerClass {
  return [CAReplicatorLayer class];
}

- (void)setUp {
  self.clipsToBounds = NO;
  self.backgroundColor = [UIColor clearColor];
  _contentsLayer = [CALayer layer];
    _contentsLayer.contentsGravity = kCAGravityResizeAspect;
  [self.layer addSublayer:_contentsLayer];

  CAReplicatorLayer *layer = (CAReplicatorLayer *)self.layer;
  layer.instanceCount = kDefaultStarsCount;
}

- (void)setStarsCount:(NSUInteger)starsCount {
  _starsCount = starsCount;
  CAReplicatorLayer *layer = (CAReplicatorLayer *)self.layer;
  layer.instanceCount = _starsCount;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _contentsLayer.frame = self.bounds;
  CAReplicatorLayer *layer = (CAReplicatorLayer *)self.layer;

  CATransform3D transform = CATransform3DIdentity;
  transform =
      CATransform3DTranslate(transform, CGRectGetWidth(self.bounds), 0, 0);
  layer.instanceTransform = transform;
}

@end
