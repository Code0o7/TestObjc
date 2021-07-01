//
//  TestViewController.m
//  TestObjc
//
//  Created by MrChen on 2021/6/30.
//

#import "TestViewController.h"
#import "WeakProxy.h"

@interface TestViewController ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, strong) dispatch_source_t sourceTimer;

@property (nonatomic, assign) BOOL start;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerAction)];
//    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//    self.displayLink.preferredFramesPerSecond = 1;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[[WeakProxy alloc]initWithTarget:self] selector:@selector(timerAction) userInfo:nil repeats:YES];
//    self.timer.fireDate = [NSDate distantFuture];
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    self.sourceTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//    dispatch_time_t startTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
//    dispatch_source_set_timer(self.sourceTimer, startTime, 1.0*NSEC_PER_SEC, 0);
//    dispatch_source_set_event_handler(self.sourceTimer, ^{
//        NSLog(@"222");
//    });
//    dispatch_resume(self.sourceTimer);
//    dispatch_source_set_cancel_handler(self.sourceTimer, ^{
//        NSLog(@"取消计时器");
//    });
    
    self.displayLink.preferredFramesPerSecond
}

// gcd定时器
- (void)gcdTimer
{
    //创建全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
    //使用全局队列创建计时器
    dispatch_source_t sourceTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //定时器延迟时间
    NSTimeInterval delayTime = 1.0f;
    
    //定时器间隔时间
    NSTimeInterval timeInterval = 1.0f;
    
    //设置开始时间
    dispatch_time_t startDelayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
    
    //设置计时器
    dispatch_source_set_timer(sourceTimer,startDelayTime,timeInterval*NSEC_PER_SEC,0.1*NSEC_PER_SEC);
    
    //执行事件
    dispatch_source_set_event_handler(sourceTimer,^{
        NSLog(@"111");
    });
    
    //启动计时器
    dispatch_resume(sourceTimer);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.timer.fireDate = [NSDate distantFuture];
//    self.timer = nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //销毁定时器
//    dispatch_source_cancel(self.sourceTimer);
    dispatch_suspend(<#dispatch_object_t  _Nonnull object#>)
}

- (void)timerAction
{
    NSLog(@"111");
}

- (void)dealloc
{
    self.timer.fireDate = [NSDate distantFuture];
    NSLog(@"释放了%s",__FUNCTION__);
}

@end
