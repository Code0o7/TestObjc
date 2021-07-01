//
//  TimerTarget.h
//  TestObjc
//
//  Created by MrChen on 2021/7/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakProxy : NSProxy

@property (nonatomic, weak) id target;

- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
