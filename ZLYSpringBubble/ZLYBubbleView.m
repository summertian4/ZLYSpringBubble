//
//  ZLYBubbleView.m
//  ZLYSpringBubble
//
//  Created by 周凌宇 on 2017/1/23.
//  Copyright © 2017年 周凌宇. All rights reserved.
//

#import "ZLYBubbleView.h"
#import "ZLYCircle.h"

typedef enum : NSUInteger {
    // 没有气泡
    ZLYBubbleViewModeNone,
    // 两个气泡
    ZLYBubbleViewModeNormal,
} ZLYBubbleViewMode;

@interface ZLYBubbleView ()

@property (nonatomic, assign) CGFloat mode;
@property (nonatomic, strong) ZLYCircle *circleRoot;
@property (nonatomic, strong) ZLYCircle *circleFloating;

@end

@implementation ZLYBubbleView

- (instancetype)init {
    if (self = [super init]) {
        [self initConfig];
    }
    return self;
}

- (void)initConfig {
    _rootCircleR = 10.0;
    _floatingCircleR = 15.0;
    _maxDistance = 100;
    [self setRootCircleCenter:CGPointZero];
    _bubbleColor = [UIColor redColor];
    [self resetConfig];
}

- (void)resetConfig {
    _circleRoot = [[ZLYCircle alloc] initWithCenter:[self rootCircleCenter] r:_rootCircleR];
    _circleFloating = [[ZLYCircle alloc] initWithCenter:[self floatingCircleCenter] r:_floatingCircleR];
    [self setFloatingCircleCenter:[self rootCircleCenter]];
    _mode = ZLYBubbleViewModeNormal;
}

#pragma mark - Overwrite

- (void)drawRect:(CGRect)rect {
    CGFloat currentDistance = [self distance];
    
    if (self.mode == ZLYBubbleViewModeNormal) {
        // 超过最大值就断开
        if (!(currentDistance > self.maxDistance)) {
            
            // 根据距离设置根圆点大小
            // 到最大距离时，圆点半径为 0
            // 比例：
            float scale = [self distance] / self.maxDistance;
            CGFloat r = self.rootCircleR * (1 - scale);
            self.circleRoot.r = r;
            
            [self drawCicle:self.circleRoot.frame color:self.bubbleColor];
            [self drawCicle:self.circleFloating.frame color:self.bubbleColor];
            [self drawBezierCurve:self.bubbleColor];
        } else {
            [self drawCicle:self.circleFloating.frame color:self.bubbleColor];
        }
    }
    
    if (self.mode == ZLYBubbleViewModeNone) {
        // 不绘制
    }
}

#pragma mark - UIResponderStandardEditActions

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    [self setFloatingCircleCenter:point];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self distance] > self.maxDistance) {
        // 气泡都消失
        self.mode = ZLYBubbleViewModeNone;
        [self setNeedsDisplay];
    } else {
        // 气泡归位
        [self resetConfig];
        [self setNeedsDisplay];
    }
}

#pragma mark - Public

- (void)setFloatingCircleCenter:(CGPoint)floatingCircleCenter {
    // 移动圆点的中心点设置
    self.circleFloating.center = floatingCircleCenter;
    
    [self setNeedsDisplay];
}

- (CGPoint)floatingCircleCenter {
    return self.circleFloating.center;
}

- (void)reset {
    [self resetConfig];
    [self setNeedsDisplay];
}

- (void)setRootCircleCenter:(CGPoint)rootCircleCenter {
    self.circleRoot.center = rootCircleCenter;
    [self resetConfig];
}

- (CGPoint)rootCircleCenter {
    return self.circleRoot.center;
}

#pragma mark - Private

/**
 绘制原型

 @param frame 圆形 frame
 @param color 边框和填充颜色
 */
- (void)drawCicle:(CGRect)frame color:(UIColor *)color {
    // 传的是正方形，因此就可以绘制出圆了
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:frame];
    
    // 设置填充颜色
    UIColor *fillColor = color;
    [fillColor set];
    [path fill];
    
    // 设置画笔颜色
    UIColor *strokeColor = color;
    [strokeColor set];
    
    // 画
    [path stroke];
}

/**
 绘制 两元中间连接部分，由两条线段、两条贝塞尔曲线组成

 @param color 填充和边框颜色
 */
- (void)drawBezierCurve:(UIColor *)color {
    // 传的是正方形，因此就可以绘制出圆了
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 设置画笔颜色
    UIColor *strokeColor = color;
    [strokeColor set];
    
    path.lineWidth = 0.5;  //宽度
    path.lineCapStyle = kCGLineCapRound;  //线条拐角
    path.lineJoinStyle = kCGLineJoinRound;  //终点处理
    
    double slope = [self slope];
    NSArray<NSValue *> *rootTangencyPoints = [self tangencyPoint:self.circleRoot lineK:slope];
    NSArray<NSValue *> *floatingTangencyPoints = [self tangencyPoint:self.circleFloating lineK:slope];
    
    //起始点
    [path moveToPoint:[rootTangencyPoints.firstObject CGPointValue]];
    //添加两个控制点
    [path addQuadCurveToPoint:[floatingTangencyPoints.firstObject CGPointValue] controlPoint:[self controlPoint]];
    
    [path addLineToPoint:[floatingTangencyPoints.lastObject CGPointValue]];
    [path moveToPoint:[floatingTangencyPoints.lastObject CGPointValue]];
    
    [path addQuadCurveToPoint:[rootTangencyPoints.lastObject CGPointValue] controlPoint:[self controlPoint]];
    [path addLineToPoint:[rootTangencyPoints.firstObject CGPointValue]];
    
    // 设置填充颜色
    UIColor *fillColor = color;
    [fillColor set];
    [path fill];
    
    // 画
    [path stroke];
}


/**
 切点
 */
- (NSArray<NSValue *> *)tangencyPoint:(ZLYCircle *)circle lineK:(float)lineK {
    // 弧度
    CGFloat radian = 0.0;
    CGFloat yOffset = 0.0;
    CGFloat xOffset = 0.0;
    radian = atan(lineK);
    xOffset = sin(radian) * circle.r;
    yOffset = cos(radian) * circle.r;
    
    CGPoint point0 = CGPointMake(circle.center.x + xOffset, circle.center.y - yOffset);
    CGPoint point1 = CGPointMake(circle.center.x - xOffset, circle.center.y + yOffset);
    
    NSValue *value0 = [NSValue valueWithCGPoint:point0];
    NSValue *value1 = [NSValue valueWithCGPoint:point1];
    
    return @[value0, value1];
}

/**
 两圆斜率

 @return 斜率
 */
- (double)slope {
    CGFloat yOffset = self.circleRoot.center.y - self.circleFloating.center.y;
    CGFloat xOffset = self.circleRoot.center.x - self.circleFloating.center.x;
    
    // 圆心两点斜率
    double lineK = 0.0;
    lineK = (xOffset == 0) ? 0.0: (yOffset / xOffset);
    
    return lineK;
}

/**
 两圆公切线切点组成贝塞尔曲线的控制点

 @return 控制点
 */
- (CGPoint)controlPoint {
    double x = (self.circleRoot.center.x + self.circleFloating.center.x) / 2;
    double y = (self.circleRoot.center.y + self.circleFloating.center.y) / 2;
    
    CGPoint point = CGPointMake(x, y);
    return point;
}

/**
 圆心距离
 */
- (CGFloat)distance {
    CGFloat distance = sqrt(pow((self.circleRoot.center.x - self.circleFloating.center.x), 2)
                             + pow((self.circleRoot.center.y - self.circleFloating.center.y), 2));
    return distance;
}

@end
