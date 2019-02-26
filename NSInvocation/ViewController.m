//
//  ViewController.m
//  NSInvocation
//
//  Created by Virtue on 2019/2/26.
//  Copyright © 2019年 none. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Invoke.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*
     1.常规使用
     */

//    NSMethodSignature  *signature = [ViewController instanceMethodSignatureForSelector:selector]; // 获取方法签名
//
//    //创建NSInvocation
//
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//
//    //要执行谁的（target）的哪个方法（selector）
//    invocation.target = self;
//    invocation.selector = selector;
//
//    //使用setArgument:atIndex:方法给要执行的方法设置参数，注意下标从2开始，因为0、1已经被target与selector占用
//    NSNumber *num1 = @(1);
//    NSNumber *num2 = @(2);
//    NSString *userName = @"小明";
//    [invocation setArgument:&num1 atIndex:2];
//    [invocation setArgument:&num2 atIndex:3];
//    [invocation setArgument:&userName atIndex:4];
//
//
//    //执行方法
//    [invocation invoke];
//    //可以在invoke方法前添加，也可以在invoke方法后添加？？？ -- 错误，只能在invoke 后添加
//    //通过方法签名的methodReturnLength判断是否有返回值
//    if (signature.methodReturnLength > 0) {
//        int result;
//        [invocation getReturnValue:&result];
//
//        NSLog(@"result = %d", result);
//    }
//
    /*
    2. 封装使用selector
     */
//    SEL selector = NSSelectorFromString(@"getSumWithNum1:num2:userName:");
//
//    id result1 = [self performSelector:selector andArguments:@[@(3), @(4), @"小红"]];
//    NSLog(@"result1 = %@", result1);
    
    /*
     3. NSInvocation在block中的使用
     */
    NSNumber * (^myBlock)(NSNumber *, NSNumber *) = ^(NSNumber *a, NSNumber * b){
        return @(a.intValue + b.intValue);
    };
    NSLog(@"%@", [self performBlock:myBlock andArguments:@[@2,@4]]);
   
    
}

- (NSNumber *)getSumWithNum1:(NSNumber *)num1 num2:(NSNumber *)num2 userName:(NSString *)userName {
    NSLog(@"num1 = %@, num2 =  %@, userName = %@", num1, num2, userName);
    
    return @(num1.intValue + num2.intValue);
}


@end
