//
//  ViewController.m
//  03、CAKeyframeAnimation
//
//  Created by kinglinfu on 16/8/26.
//  Copyright © 2016年 Tens. All rights reserved.
//

/***
 所谓的帧动画，其实与核心动画没有什么区别，只是帧动画只需要确定你动画中主要的几个基点，也就是你动画中所要确定的几个落脚点，然后之后的过程中的动画都是系统自己加的，也就是说在帧动画中我们只需要确认该动画实现的几个基本点位就可以去实现该动画了
 **/

#import "ViewController.h"

#define TScreenWidth [UIScreen mainScreen].bounds.size.width
#define TScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController (){
    
    CALayer *aniLayer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     无论是什么动画都是基于CALayer上的，也就说想要实现动画，首先我们需要创建一个用于储存动画的容器
     */
    
    aniLayer = [CALayer layer];
    aniLayer.bounds = CGRectMake(0 , 0, 100, 100);
    aniLayer.position = CGPointMake(TScreenWidth / 2, 50);
    aniLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"足球"].CGImage);
    [self.view.layer addSublayer:aniLayer];
}


//添加一个动画，整个程序中动画的起始位置
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    [aniLayer addAnimation:[self keyframeAnimation] forKey:@"keyAnimation"];
}


- (CAAnimation *)keyframeAnimation {
    
    //创建一个动画
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //设置动画的点位数
    keyAnimation.duration = 4;
    //是否按照原路径返回？
    //    keyAnimation.autoreverses = YES;
    keyAnimation.repeatCount = HUGE_VALF;
    
    //设置动画中的点位
    NSValue *point_1 = [NSValue valueWithCGPoint:CGPointMake(TScreenWidth / 2,0)];
    NSValue *point_2 = [NSValue valueWithCGPoint:CGPointMake(50,TScreenHeight / 2)];
    NSValue *point_3 = [NSValue valueWithCGPoint:CGPointMake(TScreenWidth / 2,TScreenHeight - 50)];
    NSValue *point_4 = [NSValue valueWithCGPoint:CGPointMake(TScreenWidth - 50,TScreenHeight / 2)];
    NSValue *point_5 = [NSValue valueWithCGPoint:CGPointMake(TScreenWidth / 2,0)];
    
    // values:设置关键帧(多个目标点)
    keyAnimation.values = @[point_1,point_2,point_3,point_4,point_5];
    
    // 设置每一帧所在的时间比例
    keyAnimation.keyTimes = @[@0, @0.2, @0.5, @0.6,@1.0];
    
    /* 插值计算模式：
     kCAAnimationLinear  关键帧之间进行插值计算（线性的）
     kCAAnimationDiscrete 关键帧之间不进行插值计算（离散的）
     kCAAnimationPaced 关键帧之间匀速切换，keyTimes\timingFunctions的设置将不起作用
     kCAAnimationCubic 关键帧进行圆滑曲线相连后插值计算
     kCAAnimationCubicPaced 匀速并且关键帧进行圆滑曲线相连后插值计算
     */
    keyAnimation.calculationMode = kCAAnimationCubicPaced;
    
    return keyAnimation;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
