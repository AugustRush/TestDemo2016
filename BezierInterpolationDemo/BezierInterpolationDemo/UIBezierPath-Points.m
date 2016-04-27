/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 6.x Edition
 BSD License, Use at your own risk
 */

#import "UIBezierPath-Points.h"

#define POINTSTRING(_CGPOINT_) (NSStringFromCGPoint(_CGPOINT_))
#define VALUE(_INDEX_) [NSValue valueWithCGPoint:points[_INDEX_]]
#define POINT(_INDEX_) [(NSValue *)[points objectAtIndex:_INDEX_] CGPointValue]

// Return distance between two points
static float distance (CGPoint p1, CGPoint p2)
{
	float dx = p2.x - p1.x;
	float dy = p2.y - p1.y;
	
	return sqrt(dx*dx + dy*dy);
}

@implementation UIBezierPath (Points)

void getPointsFromBezier(void *info, const CGPathElement *element)
{
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    CGPathElementType type = element->type;
    CGPoint *points = element->points;
    switch (type) {
        case kCGPathElementAddLineToPoint:
        case kCGPathElementMoveToPoint: {
            [bezierPoints addObject:VALUE(0)];
            break;
        }
        case kCGPathElementAddQuadCurveToPoint: {
            [bezierPoints addObject:VALUE(0)];
            [bezierPoints addObject:VALUE(1)];
            break;
        }
        case kCGPathElementAddCurveToPoint: {
            [bezierPoints addObject:VALUE(0)];
            [bezierPoints addObject:VALUE(1)];
            [bezierPoints addObject:VALUE(2)];
            break;
        }
        case kCGPathElementCloseSubpath: {
            [bezierPoints addObject:[bezierPoints[0] copy]];
            break;
        }
            
    }
}

- (NSArray *)points
{
    NSMutableArray *points = [NSMutableArray array];
    CGPathApply(self.CGPath, (__bridge void *)points, getPointsFromBezier);
    return points;
}

// Return a Bezier path buit with the supplied points
+ (UIBezierPath *) pathWithPoints: (NSArray *) points
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (points.count == 0) return path;
    [path moveToPoint:POINT(0)];
    for (int i = 1; i < points.count; i++)
        [path addLineToPoint:POINT(i)];
    return path;
}

- (CGFloat) length
{
    NSArray *points = self.points;
    float totalPointLength = 0.0f;
    for (int i = 1; i < points.count; i++)
        totalPointLength += distance(POINT(i), POINT(i-1));
    return totalPointLength;
}

- (NSArray *) pointPercentArray
{
    // Use total length to calculate the percent of path consumed at each control point
    NSArray *points = self.points;
    NSUInteger pointCount = points.count;
    
    float totalPointLength = self.length;
    float distanceTravelled = 0.0f;
    
	NSMutableArray *pointPercentArray = [NSMutableArray array];
	[pointPercentArray addObject:@(0.0)];
    
	for (int i = 1; i < pointCount; i++)
	{
		distanceTravelled += distance(POINT(i), POINT(i-1));
		[pointPercentArray addObject:@(distanceTravelled / totalPointLength)];
	}
	
	// Add a final item just to stop with. Probably not needed.
	[pointPercentArray addObject:[NSNumber numberWithFloat:1.1f]]; // 110%
    
    return pointPercentArray;
}

- (CGPoint) pointAtPercent: (CGFloat) percent withSlope: (CGPoint *) slope
{
    NSArray *points = self.points;
    NSArray *percentArray = self.pointPercentArray;
    CFIndex lastPointIndex = points.count - 1;
    
    if (!points.count)
        return CGPointZero;
    
    // Check for 0% and 100%
    if (percent <= 0.0f) return POINT(0);
    if (percent >= 1.0f) return POINT(lastPointIndex);

    // Find a corresponding pair of points in the path
    CFIndex index = 1;
    while ((index < percentArray.count) &&
           (percent > ((NSNumber *)percentArray[index]).floatValue))
        index++;
    
    // This should not happen.
    if (index > lastPointIndex) return POINT(lastPointIndex);
    
    // Calculate the intermediate distance between the two points
    CGPoint point1 = POINT(index -1);
    CGPoint point2 = POINT(index);
    
    float percent1 = [[percentArray objectAtIndex:index - 1] floatValue];
    float percent2 = [[percentArray objectAtIndex:index] floatValue];
    float percentOffset = (percent - percent1) / (percent2 - percent1);
    
    float dx = point2.x - point1.x;
    float dy = point2.y - point1.y;
    
    // Store dy, dx for retrieving arctan
    if (slope) *slope = CGPointMake(dx, dy);
    
    // Calculate new point
    CGFloat newX = point1.x + (percentOffset * dx);
    CGFloat newY = point1.y + (percentOffset * dy);
    CGPoint targetPoint = CGPointMake(newX, newY);
    
    return targetPoint;
}

void getBezierElements(void *info, const CGPathElement *element)
{
    NSMutableArray *bezierElements = (__bridge NSMutableArray *)info;
    CGPathElementType type = element->type;
    CGPoint *points = element->points;

    switch (type)
    {
        case kCGPathElementCloseSubpath:
            [bezierElements addObject:@[@(type)]];
            break;
        case kCGPathElementMoveToPoint:
        case kCGPathElementAddLineToPoint:
            [bezierElements addObject:@[@(type), VALUE(0)]];
            break;
        case kCGPathElementAddQuadCurveToPoint:
            [bezierElements addObject:@[@(type), VALUE(0), VALUE(1)]];
            break;
        case kCGPathElementAddCurveToPoint:
            [bezierElements addObject:@[@(type), VALUE(0), VALUE(1), VALUE(2)]];
            break;
    }   
}

- (NSArray *) bezierElements
{
    NSMutableArray *elements = [NSMutableArray array];
    CGPathApply(self.CGPath, (__bridge void *)elements, getBezierElements);
    return elements;
}

+ (UIBezierPath *) pathWithElements: (NSArray *) elements
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (elements.count == 0) return path;
    
    for (NSArray *points in elements)
    {
        if (!points.count) continue;
        CGPathElementType elementType = (CGPathElementType)[points[0] integerValue];
        switch (elementType)
        {
            case kCGPathElementCloseSubpath:
                [path closePath];
                break;
            case kCGPathElementMoveToPoint:
                if (points.count == 2)
                    [path moveToPoint:POINT(1)];
                break;
            case kCGPathElementAddLineToPoint:
                if (points.count == 2)
                    [path addLineToPoint:POINT(1)];
                break;
            case kCGPathElementAddQuadCurveToPoint:
                if (points.count == 3)
                    [path addQuadCurveToPoint:POINT(2) controlPoint:POINT(1)];
                break;
            case kCGPathElementAddCurveToPoint:
                if (points.count == 4)
                    [path addCurveToPoint:POINT(3) controlPoint1:POINT(1) controlPoint2:POINT(2)];
                break;
        }
    }
    
    return path;
}

#pragma mark - interpolation methods

- (CGPoint)pointAtQuadCurvePathWithPercent:(CGFloat)percent slope:(CGPoint *)slope {
    NSArray *points = [self points];
    NSAssert(points.count == 3, @"QuadCurve path should has three points!!!");
    CGPoint from = [points[0] CGPointValue];
    CGPoint control = [points[1] CGPointValue];
    CGPoint to = [points[2] CGPointValue];
    
    return [self interpolatePointWithPercent:percent from:from control:control to:to slope:slope];
}

- (CGPoint)pointAtCurvePathWithPercent:(CGFloat)percent slope:(CGPoint *)slope {
    NSArray *points = [self points];
    NSAssert(points.count == 4, @"QuadCurve path should has three points!!!");
    CGPoint from = [points[0] CGPointValue];
    CGPoint control1 = [points[1] CGPointValue];
    CGPoint control2 = [points[2] CGPointValue];
    CGPoint to = [points[3] CGPointValue];

    CGFloat cfdx = control1.x - from.x;
    CGFloat cfdy = control1.y - from.y;
    CGPoint dyFrom = CGPointMake(from.x + cfdx * percent, from.y + cfdy * percent);
    
    CGFloat ccdx = control2.x - control1.x;
    CGFloat ccdy = control2.y - control1.y;
    CGPoint dyControl = CGPointMake(control1.x + ccdx * percent, control1.y + ccdy * percent);
    
    CGFloat tcdx = to.x - control2.x;
    CGFloat tcdy = to.y - control2.y;
    CGPoint dyTo = CGPointMake(control2.x + tcdx * percent, control2.y + tcdy * percent);
    
    return [self interpolatePointWithPercent:percent from:dyFrom control:dyControl to:dyTo slope:slope];
}

- (CGPoint)interpolatePointWithPercent:(CGFloat)percent from:(CGPoint)from control:(CGPoint)control to:(CGPoint)to slope:(CGPoint *)slope {
    CGFloat cfdx = control.x - from.x;
    CGFloat cfdy = control.y - from.y;
    CGPoint fcp = CGPointMake(from.x + cfdx * percent, from.y + cfdy * percent);
    CGFloat tfdx = to.x - control.x;
    CGFloat tfdy = to.y - control.y;
    CGPoint ctp = CGPointMake(control.x + tfdx * percent, control.y + tfdy * percent);
    CGFloat dx = ctp.x - fcp.x;
    CGFloat dy = ctp.y - fcp.y;
    if (slope != NULL) {
        *slope = CGPointMake(dx, dy);
    }
    CGPoint resultP = CGPointMake(fcp.x + dx * percent, fcp.y + dy * percent);
    return resultP;
}

@end
