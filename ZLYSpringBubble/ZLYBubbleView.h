//
//  ZLYBubbleView.h
//  ZLYSpringBubble
//
//  Created by 周凌宇 on 2017/1/23.
//  Copyright © 2017年 周凌宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLYBubbleView : UIView

/** 最大距离，超过最大距离气泡会断开，默认 100 */
@property (nonatomic, assign) CGFloat maxDistance;

/** 根圆点半径，默认 10.0 */
@property (nonatomic, assign) CGFloat rootCircleR;
/** 可拖拽圆点半径，默认 15.0 */
@property (nonatomic, assign) CGFloat floatingCircleR;

/** 根圆点圆心，默认 (0,0) */
@property (nonatomic, assign) CGPoint rootCircleCenter;
/** 可拖拽圆点圆心，默认和根圆点圆心一致 */
@property (nonatomic, assign) CGPoint floatingCircleCenter;

/** 默认 red */
@property (nonatomic, strong) UIColor *bubbleColor;

/**
 重置
 */
- (void)reset;

@end
