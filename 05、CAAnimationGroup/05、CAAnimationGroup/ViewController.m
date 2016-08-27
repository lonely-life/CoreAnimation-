//
//  ViewController.m
//  06、CAAnimationGroup
//
//  Created by kinglinfu on 16/8/27.
//  Copyright © 2016年 Tens. All rights reserved.
//

#import "ViewController.h"

#define TScreenWidth [UIScreen mainScreen].bounds.size.width

#define TScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *aniImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.bgView.layer.delegate = self;
    [self.bgView.layer setNeedsDisplay];
    
    NSLog(@"%@",NSStringFromCGRect(self.aniImageView.frame));
    NSLog(@"%f, %f",TScreenWidth, TScreenHeight);
    
}

//设置动画的启动点，添加一个动画
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    [self.aniImageView.layer addAnimation:[self animationGroup] forKey:@"group"];
}

//确定动画的起始、终点位置

- (CAAnimation *)positionAnimation {
    
    CAKeyframeAnimation *keyAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //动画持续时间
    keyAni.duration = 3.0;
    //动画进行时的模式
    keyAni.fillMode = kCAFillModeForwards;
    //是否按照原路径返回
    keyAni.removedOnCompletion = NO;
    keyAni.path = [self path].CGPath;
    
    return keyAni;
}

//设置动画的循环属性（再次开始时的设置）
- (CAAnimation *)rotationAnimation {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];

    //动画过程中的时间
    animation.beginTime = 3.0;
    //动画持续时间
    animation.duration = 2.0;
    //
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.byValue = @(2 * M_PI);
    
    return animation;
}

//
- (CAAnimation *)downAnimation {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.beginTime = 3.0;
    animation.duration = 2.0;
    animation.byValue = [NSValue valueWithCGPoint:CGPointMake(-100, TScreenHeight)];
    
    return animation;
}


//设置动画的基点
- (UIBezierPath *)path  {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //起点
    [path moveToPoint:CGPointMake(0, TScreenHeight)];
    //终点
    CGPoint toPoint = CGPointMake(TScreenWidth, 0);
    //中间的弧度点
    CGPoint controlPoint = CGPointMake(TScreenWidth,TScreenHeight);
    [path addQuadCurveToPoint:toPoint controlPoint:controlPoint];
    
    return path;
}


- (CAAnimation *)animationGroup {

    // 创建一个动画组，用于组合多种动画
    CAAnimationGroup * aniGroup = [CAAnimationGroup animation];
    
    // 动画组的完成时间
    aniGroup.duration = 5.0;
    aniGroup.fillMode = kCAFillModeForwards;
    aniGroup.removedOnCompletion = NO;
    // 组合多个动画
    aniGroup.animations = @[[self positionAnimation],[self rotationAnimation],[self downAnimation]];
    return aniGroup;
}


- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {

    CGContextAddPath(ctx, [self path].CGPath);
    CGContextSetLineWidth(ctx, 5);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextDrawPath(ctx, kCGPathStroke);
}

@end
