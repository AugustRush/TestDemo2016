/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 6.x Edition
 BSD License, Use at your own risk
 */

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

// Return distance between two points
static float distance (CGPoint p1, CGPoint p2)
{
    float dx = p2.x - p1.x;
    float dy = p2.y - p1.y;
    
    return sqrt(dx*dx + dy*dy);
}

@interface UIBezierPath (Points)
@property (nonatomic, readonly) NSArray *points;
@property (nonatomic, readonly) NSArray *bezierElements;
@property (nonatomic, readonly) CGFloat length;

- (NSArray *) pointPercentArray;
- (CGPoint) pointAtPercent: (CGFloat) percent withSlope: (CGPoint *) slope;
+ (UIBezierPath *) pathWithPoints: (NSArray *) points;
+ (UIBezierPath *) pathWithElements: (NSArray *) elements;

@end
