//
//  ViewController.m
//  01、UIView动画
//
//  Created by kinglinfu on 16/8/26.
//  Copyright © 2016年 Tens. All rights reserved.
//

#import "ViewController.h"

/*
 在学习使用CABasicAnimation之前我们需要先来看之前我们一直使用UIView中的动画，这样才能形成一个鲜明的对比，让我们看出来核心动画和UIVIew中的动画之间的区别
 **/

@interface ViewController ()
{
    UIView *aniView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    aniView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    aniView.center = self.view.center;
    aniView.backgroundColor = [UIColor redColor];
    [self.view addSubview:aniView];
}


//点击时触发的事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self animations];
}

- (void)animations {
    
    // 1、简单的动画
    [UIView animateWithDuration:1 animations:^{
        
        //放大东湖
        aniView.transform = CGAffineTransformScale(aniView.transform, 1.5, 1.5);
        aniView.layer.cornerRadius = 100;
    }];
    
    // 2、处理动画完成后的操作
    [UIView animateWithDuration:2 animations:^{
        
        aniView.layer.cornerRadius = 100;
        aniView.transform = CGAffineTransformScale(aniView.transform, 1.5, 1.5);
        
    } completion:^(BOOL finished) {
        
        aniView.transform = CGAffineTransformIdentity;
        aniView.layer.cornerRadius = 0;
    }];
    
    /* 3、设置动画的延迟进行，
     delay：延迟的秒数，
     options: 动画的线性变换
     
     UIViewAnimationOptionCurveEaseInOut   进入、出去时加速
     UIViewAnimationOptionCurveEaseIn      进入时加速
     UIViewAnimationOptionCurveEaseOut     出去时加速
     UIViewAnimationOptionCurveLinear      匀速
     */
    //设置动画的延迟效果
    [UIView animateWithDuration:2 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
        
        aniView.layer.cornerRadius = 50;
        aniView.transform = CGAffineTransformScale(aniView.transform, 2, 2);
        
    } completion:^(BOOL finished) {
        
        aniView.transform = CGAffineTransformIdentity;
        aniView.layer.cornerRadius = 0;
    }];
    
    
    // 4、带有缓存效应的动画，Damping：缓存只（0~1),值越小缓冲越大,Velocity: 动画播放速度
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.3
          initialSpringVelocity:1 options:0 animations:^{
              
              aniView.layer.cornerRadius = 50;
              aniView.transform = CGAffineTransformScale(aniView.transform, 2, 2);
              
          } completion:^(BOOL finished) {
              
              aniView.transform = CGAffineTransformIdentity;
              aniView.layer.cornerRadius = 0;
          }];
    //
    
    /* 5、视图转场动画, 从一个视图到另一个视图的转化过程，
     options:转场样式
     UIViewAnimationOptionTransitionNone            = 0 << 20, // default
     UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
     UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
     UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
     UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
     UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
     UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
     UIViewAnimationOptionTransitionFlipFromBottom
     
     */
    [UIView transitionFromView:self.view toView:aniView duration:1 options:UIViewAnimationOptionTransitionCurlUp completion:^(BOOL finished) {
        
        
    }];
    
    
    // 6、嵌套动画：多个动画组合成一个动画组
    [UIView animateWithDuration:2 animations:^{
        
        aniView.transform = CGAffineTransformScale(aniView.transform, 2, 2);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:2 animations:^{
            
            aniView.layer.cornerRadius = 50;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:0 animations:^{
                
                aniView.transform = CGAffineTransformScale(aniView.transform, 0.5, 0.5);
                
            } completion:^(BOOL finished) {
                
            }];
        }];
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
