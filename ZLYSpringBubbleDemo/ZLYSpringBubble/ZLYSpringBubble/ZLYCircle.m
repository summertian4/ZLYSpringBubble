//
//  ZLYCircle.m
//  ZLYSpringBubble
//
//  Created by 周凌宇 on 2017/1/23.
//  Copyright © 2017年 周凌宇. All rights reserved.
//

#import "ZLYCircle.h"

@implementation ZLYCircle

#pragma mark - init

- (instancetype)init {
    if (self = [super init]) {
        _center = CGPointMake(0, 0);
        _r = 1.0;
    }
    return self;
}

- (instancetype)initWithCenter:(CGPoint)center r:(CGFloat)r {
    if (self = [super init]) {
        _center = center;
        _r = r;
    }
    return self;
}

#pragma mark - Public

- (CGRect)frame {
    CGRect frame = CGRectMake(self.center.x - self.r,
                              self.center.y - self.r,
                              self.r * 2,
                              self.r * 2);
    return frame;
}

@end
