//
//  NSObject+Invoke.m
//  NSInvocation
//
//  Created by Virtue on 2019/2/26.
//  Copyright © 2019年 none. All rights reserved.
//

#import "NSObject+Invoke.h"
#import "NSInvocation+Block.h"

@implementation NSObject (Invoke)
- (id)performSelector:(SEL)aSelector andArguments:(NSArray *)arguments {
    if (!aSelector) return nil;
    
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    if (!signature) return nil;
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    
    if ([arguments isKindOfClass:[NSArray class]]) {
           NSInteger count = MIN(arguments.count, signature.numberOfArguments - 2);
           for (int i = 0; i < count; i++) {
               const char *type = [signature getArgumentTypeAtIndex:2 + i];
               
               // 需要做参数类型判断然后解析成对应类型，这里默认所有参数均为OC对象
               if (strcmp(type, "@") == 0) {
                   id argument = arguments[i];
                   [invocation setArgument:&argument atIndex:2 + i];
               }
           }
    }
    [invocation invoke];
    id returnVal;
    if (strcmp(signature.methodReturnType, "@") == 0) {
        [invocation getReturnValue:&returnVal];
    }
    // 需要做返回类型判断。比如返回值为常量需要包装成对象，这里仅以最简单的`@`为例
    return returnVal;
}

- (id)performBlock:(id)block andArguments:(NSArray *)arguments {
    if (!block) return nil;
    
    NSInvocation *invocation = [NSInvocation invocationWithBlock:block];
    
    // invocation 有1个隐藏参数，所以 argument 从1开始
    NSMethodSignature *sig = invocation.methodSignature;
    if ([arguments isKindOfClass:[NSArray class]]) {
        NSInteger count = MIN(arguments.count, sig.numberOfArguments - 1);
        for (int i = 0; i < count; i++) {
            const char *type = [sig getArgumentTypeAtIndex:1 + i];
            NSString *typeStr = [NSString stringWithUTF8String:type];
            if ([typeStr containsString:@"\""]) {
                type = [typeStr substringToIndex:1].UTF8String;
            }
            
            // 需要做参数类型判断然后解析成对应类型，这里默认所有参数均为OC对象
            if (strcmp(type, "@") == 0) {
                id argument = arguments[i];
                [invocation setArgument:&argument atIndex:1 + i];
            }
        }
    }
    
    
    [invocation invoke];
    id returnVal;
    const char *type = sig.methodReturnType;
    NSString *returnType = [NSString stringWithUTF8String:type];
    if ([returnType containsString:@"\""]) {
        type = [returnType substringToIndex:1].UTF8String;
    }
    if (strcmp(type, "@") == 0) {
        [invocation getReturnValue:&returnVal];
    }
   
    
    return returnVal;
}


@end
