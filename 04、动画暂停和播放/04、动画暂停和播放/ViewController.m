//
//  ViewController.m
//  05、动画的暂停、继续
//
//  Created by kinglinfu on 16/8/27.
//  Copyright © 2016年 Tens. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    
    
    CALayer *layer;
    
    BOOL _isPause;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 250, 250);
    layer.position = self.view.center;
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"get.jpeg"].CGImage);
    
    [self.view.layer addSublayer:layer];
    
    [self rotationAnimation];
    
    
}

//动画的起始位置，
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_isPause) {
        //启动
        
        [self resumeAnimation];
        
    }else {
        //暂停
        
        [self pauseAnimation];
    }
    //继续
    
    _isPause = !_isPause;
    
}

- (void)pauseAnimation {
    
    NSLog(@"CACurrentMediaTime:%f",CACurrentMediaTime());
    
    // CACurrentMediaTime(): 当前媒体时间，表示系统启动后到当前的秒数，当系统重启后这个时间也重置
    CFTimeInterval pauseTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    /*
     设置动画的时间的偏移，所谓的时间偏移就是指动画在暂停之后再次启动时也不会再次回到起始位置，而是会从你暂停的位置开始启动 
     **/
    layer.timeOffset = pauseTime;
    
    layer.speed = 0;
}


- (void)resumeAnimation {
    
    // 获取暂停时的时间
    CFTimeInterval pasuseTime = [layer timeOffset];
    
    layer.speed = 1;
    layer.timeOffset = 0;
    layer.beginTime = 0;
    
    // 设置开始的时间(继续动画，这样设置相当于让动画等待的秒数等于暂停的秒)
    layer.beginTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pasuseTime;
}



- (CAAnimation *)rotationAnimation {
    
    //这里的transform是系统中用来确认动画模型的，rotation是这个函数的函数名，z是动画的旋转基点
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    animation.duration = 2.0;
    animation.byValue = @(2 * M_PI);
    animation.repeatCount = HUGE_VALF;
    
    // 设置动画开始的媒体时间（用于设置动画的延迟启动）,要加上CACurrentMediaTime
    animation.beginTime =  CACurrentMediaTime() + 2;
    
    [layer addAnimation:animation forKey:@"rotaion"];
    
    return animation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
