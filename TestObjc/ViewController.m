//
//  ViewController.m
//  TestObjc
//
//  Created by 臻尚 on 2021/4/12.
//

#import "ViewController.h"
#import <ZLPhotoBrowser.h>

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
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
