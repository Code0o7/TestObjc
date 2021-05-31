//
//  ViewController.m
//  TestObjc
//
//  Created by 臻尚 on 2021/4/12.
//

#import "ViewController.h"
#import <ZLPhotoBrowser.h>
#import "AnimationTool.h"

@interface ViewController ()

@property (nonatomic, strong) AnimationTool *animationTool;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *testView = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 80, 80)];
    testView.backgroundColor = [UIColor redColor];
    testView.layer.cornerRadius = 40;
    testView.layer.masksToBounds = YES;
    [self.view addSubview:testView];
    
    [AnimationTool floatAnimationWithView:testView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

- (void)floadAnimation
{
    UIView *testView = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 80, 80)];
    testView.backgroundColor = [UIColor redColor];
    testView.layer.cornerRadius = 40;
    testView.layer.masksToBounds = YES;
    [self.view addSubview:testView];
        
        //设置x轴方向的缩放动画
        CAKeyframeAnimation *xScaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
        xScaleAnimation.values = @[@1, @0.9, @1, @1.1, @0.9, @1];
        xScaleAnimation.duration = 3.f;
        xScaleAnimation.repeatCount = CGFLOAT_MAX;
        xScaleAnimation.removedOnCompletion = NO;
        xScaleAnimation.fillMode = kCAFillModeForwards;
        
        //设置y轴方向的缩放动画
        CAKeyframeAnimation *yScaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
        yScaleAnimation.values = @[@0.9, @1, @1.1, @0.8, @1, @0.9];
        yScaleAnimation.duration = 3.f;
        yScaleAnimation.repeatCount = CGFLOAT_MAX;
        yScaleAnimation.removedOnCompletion = NO;
        yScaleAnimation.fillMode = kCAFillModeForwards;
        
        //设置x轴方向的移动动画
        CAKeyframeAnimation *xTranslationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        xTranslationAnimation.values = @[@0, @5, @(-5), @0, @5, @0];
        xTranslationAnimation.duration = 3.f;
        xTranslationAnimation.repeatCount = CGFLOAT_MAX;
        xTranslationAnimation.removedOnCompletion = NO;
        xTranslationAnimation.fillMode = kCAFillModeForwards;
        
        //设置y轴方向的移动动画
        CAKeyframeAnimation *yTranslationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
        yTranslationAnimation.values = @[@0, @5, @1, @-5, @0];
        yTranslationAnimation.duration = 3.f;
        yTranslationAnimation.repeatCount = CGFLOAT_MAX;
        yTranslationAnimation.removedOnCompletion = NO;
        yTranslationAnimation.fillMode = kCAFillModeForwards;
        
        //组动画
        CAAnimationGroup *groupAnimation = [[CAAnimationGroup alloc] init];
        groupAnimation.animations = @[xScaleAnimation, yScaleAnimation, xTranslationAnimation, yTranslationAnimation];//将所有动画添加到动画组
        groupAnimation.duration = 3.f;
        groupAnimation.repeatCount = CGFLOAT_MAX;
        groupAnimation.removedOnCompletion = NO;
        groupAnimation.fillMode = kCAFillModeForwards;
        
        [testView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
}

- (void)getCurrentWave {
    
}


- (void)test
{
    NSArray *weightArr = @[@{@"A":@"30"},@{@"B":@"40"},@{@"C":@"10"},@{@"D":@"20"}];
        //1.0
        NSInteger sumA = 0,sumB = 0,sumC = 0,sumD = 0,sumE = 0;
        for (int i = 0; i < 110000; i++) {
            NSString *key = [self getRadomKeyWithWeightArr:weightArr];
            if ([key isEqualToString:@"A"]) {
                sumA ++;
            }else if ([key isEqualToString:@"B"]){
                sumB ++;
            }else if ([key isEqualToString:@"C"]){
                sumC ++;
            }else if ([key isEqualToString:@"D"]){
                sumD ++;
            }else if ([key isEqualToString:@"E"]){
                sumE ++;
            }
        }
        NSString *str = [NSString stringWithFormat:@" A:%li\n B:%li\n C:%li\n D:%li\n E:%li\n ",(long)sumA,(long)sumB,(long)sumC,(long)sumD,(long)sumE];
        NSLog(@"验证取数概率的测试结果\n%@",str);
        //2.0
//        NSArray *resultArr = [self getRadomArrWithWeightArr:weightArr ResultArrCount:3];
//        NSLog(@"取数出对应个数:\n%@",resultArr);
}

/**
 从一个加权数组随机取出一个数
 parm:
 1.weightArr 加权数组[@"唯一标识符":@"权重,统一处理成整数",...]
 示例:[@{@"A":@"3"},@{@"B":@"4"},@{@"C":@"1"},@{@"D":@"2"},@{@"E":@"1"},]
 */
-(NSString *)getRadomKeyWithWeightArr:(NSArray <NSDictionary *>*)weightArr
{
    weightArr = [weightArr sortedArrayUsingComparator:^NSComparisonResult(NSDictionary*  _Nonnull obj1, NSDictionary*  _Nonnull obj2) {
        if ([obj1.allValues.firstObject integerValue] >= [obj2.allValues.firstObject integerValue]) {
            return NSOrderedAscending;
        }else{
            return NSOrderedDescending;
        }
    }];
    
    NSMutableArray *keyArr = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *valueArr = [NSMutableArray arrayWithCapacity:1];
    for (NSDictionary *dic in weightArr) {
        NSString *key = dic.allKeys.firstObject;
        [keyArr addObject:key];
        [valueArr addObject:dic[key]];
    }
    
    NSInteger sum = 0;
    NSMutableArray *weightSumArr = [NSMutableArray arrayWithCapacity:1];
    for (NSString *weightValue in valueArr) {
        sum = sum + weightValue.integerValue;
        [weightSumArr addObject:@(sum)];
    }
    
    long randomValue = random()%(sum - 0 + 1) + 0;
    NSNumber *index;
    for (int i = 0; i < weightSumArr.count - 1; i++) {
        if (randomValue <= [weightSumArr[i] longValue]) {
            index = @(i);
            break;
        }else{
            if (randomValue <= [weightSumArr[i + 1] longValue]) {
                index = @(i + 1);
                break;
            }
        }
    }
    
    return keyArr[index.integerValue];
}

/**
 从一个加权数组随机取出n个数的新数组(加权随机数)
 parm:
 1.weightArr 加权数组[@"唯一标识符":@"权重,统一处理成整数",...]
 示例:[@{@"A":@"3"},@{@"B":@"4"},@{@"C":@"1"},@{@"D":@"2"},@{@"E":@"1"},]
 2.resultCount 最终结果的个数
 */
-(NSArray *)getRadomArrWithWeightArr:(NSArray <NSDictionary *>*)weightArr ResultArrCount:(NSInteger)resultCount{
    
    NSMutableSet *mSet = [NSMutableSet setWithCapacity:1];
    while (mSet.count < resultCount) {
        NSString *key = [self getRadomKeyWithWeightArr:weightArr];
        [mSet addObject:key];
    }
    return mSet.allObjects;
}



@end
