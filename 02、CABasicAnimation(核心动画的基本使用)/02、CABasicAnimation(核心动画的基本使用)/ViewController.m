//
//  ViewController.m
//  02、CABasicAnimation
//
//  Created by kinglinfu on 16/8/26.
//  Copyright © 2016年 Tens. All rights reserved.
//

#import "ViewController.h"

/***
 这个是Animation 中的一些核心动画的基本使用，通过这个和之前的UIVIew的动画使用的比较，我们可以看出来其实两个动画在使用上十几本相似的，只是说某些细节上还是存在很大的差异，在核心动画中我们所做的事情其实就是设置起始点，终点然后将这两个点位之间的效果进行动画
 ***/

@interface ViewController (){
    
    CALayer *aniLayer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个CALayer
    aniLayer = [CALayer layer];
    aniLayer.frame = CGRectMake(100, 50, 100, 100);
    aniLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"足球"].CGImage);
    
    [self.view.layer addSublayer:aniLayer];
    
}


//添加一个动画，可以理解为这里是这个程序中所有动画效果的启动器
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    /**
     给layer 添加动画
     [self positionAnimation]  这个是需要自己去进行定义的方法，在方法中去实现动画效果
     forKey:@"position 这个是可以填写 也可以不用填写的  ，如果填写请填写相对应的方法中的关键词或者是后缀名
     */
    [aniLayer addAnimation:[self positionAnimation] forKey:@"position"];
    [aniLayer addAnimation:[self rotationAnimation] forKey:@"rotation"];
    
    //    [aniLayer addAnimation:[self boundsAnimation] forKey:@"bounds"];
    
    //    [aniLayer addAnimation:[self scaleAnimation] forKey:@"scale"];
    
}


//使目标发生移动性的动画
- (CAAnimation *)positionAnimation {
    //设置创建一个动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    //设置起始点
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 50)];
    //设置终点
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 550)];
    //设置移动的时间
    animation.duration = 2.0;
    
    //设置动画的模式
    animation.fillMode = kCAFillModeForwards;
    //是否显示移动的过程
    animation.removedOnCompletion = NO;
    //是否原路径返回
    animation.autoreverses = YES;
    //设置重复次数
    animation.repeatCount = HUGE_VALF; //  HUGE_VALF 最大浮点数，表示无限次重复
    
    /* 动画的线性变换(动画速度变化)
     kCAMediaTimingFunctionLinear 匀速
     kCAMediaTimingFunctionEaseIn 加速
     kCAMediaTimingFunctionEaseOut 减速
     kCAMediaTimingFunctionEaseInEaseOut 缓慢进入缓慢出去
     kCAMediaTimingFunctionDefault 默认
     */
    //设置动画变化的线路
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    
    return animation;
}


- (CAAnimation *)boundsAnimation {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)];
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 300, 300)];
    
    animation.duration = 2.0;
    
    return animation;
}

- (CAAnimation *)rotationAnimation {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    // animation.fromValue = @0;
    // animation.toValue = @(2 * M_PI);
    animation.byValue = @( -2 * M_PI);
    
    animation.duration = 2.0;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.autoreverses = YES;
    animation.repeatCount = HUGE_VALF; //  HUGE_VALF 最大浮点数，表示无限次重复
    
    return animation;
}


- (CAAnimation *)scaleAnimation {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // 1、初始值
    animation.fromValue = @1.0;
    // 2、目标值
    animation.toValue = @2.0;
    
    // 3、变化的值， fromValue ~ toValue 值的变化量
    // animation.byValue = @1.0;
    
    // 4、动画时间
    animation.duration = 2.0;
    
    /* 5、动画的填充模式：
     kCAFillModeForwards
     kCAFillModeBackwards
     kCAFillModeBoth
     kCAFillModeRemoved
     */
    animation.fillMode = kCAFillModeForwards;
    
    // 6、动画后是否移除动画后的状态(回到原始状态)，默认是YES, 前提是要设置fillModle为：kCAFillModeForwards
    animation.removedOnCompletion = NO;
    
    // 7、是否有回复效果
    animation.autoreverses = YES;
    
    // 8、设置动画重复次数
    animation.repeatCount = HUGE_VALF; //  HUGE_VALF 最大浮点数，表示无限次重复
    
    // 9、播放动画的速度
    animation.speed = 2;
    
    return animation;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
