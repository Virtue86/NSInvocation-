//
//  NSObject+Invoke.h
//  NSInvocation
//
//  Created by Virtue on 2019/2/26.
//  Copyright © 2019年 none. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Invoke)
- (id)performSelector:(SEL)aSelector andArguments:(NSArray *)arguments;

- (id)performBlock:(id)block andArguments:(NSArray *)arguments;
@end

NS_ASSUME_NONNULL_END
