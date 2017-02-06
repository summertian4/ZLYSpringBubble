//
//  ViewController.m
//  ZLYSpringBubble
//
//  Created by 周凌宇 on 2017/1/23.
//  Copyright © 2017年 周凌宇. All rights reserved.
//

#import "ViewController.h"
#import "ZLYBubbleView.h"

@interface ViewController ()

@property (nonatomic, strong) ZLYBubbleView *bubbleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set bubble
    self.bubbleView.rootCircleCenter = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 70);
    self.bubbleView.rootCircleR = 8;
    self.bubbleView.floatingCircleR = 12;
    self.bubbleView.maxDistance = 150;
    self.bubbleView.bubbleColor = [UIColor colorWithRed:0 green:0.4 blue:0.4 alpha:1];
}

- (IBAction)resetBubble:(UIButton *)sender {
    [self.bubbleView reset];
    
}

- (ZLYBubbleView *)bubbleView {
    if (_bubbleView == nil) {
        _bubbleView = [[ZLYBubbleView alloc] init];
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        _bubbleView.frame = CGRectMake(0, 80, width, height - 80);
        _bubbleView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
        
        [self.view addSubview:_bubbleView];
    }
    return _bubbleView;
}

@end
