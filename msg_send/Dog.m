//
//  Dog.m
//  msg_send
//
//  Created by Phoenix on 2018/3/1.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#import "Dog.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Cat.h"

@implementation Dog {
    NSString *_name;
}
@dynamic name;
void mySetName(id self, SEL _cmd, NSString *newValue) {
//    Ivar ivar = class_getInstanceVariable(Dog.class, "_name");
//    object_setIvar(self, ivar, [newValue copy]);
    if (((Dog *)self)->_name != newValue) {
        ((Dog *)self)->_name = [newValue copy];
    }
}

NSString * myGetName(id self, SEL _cmd) {
//    Ivar ivar = class_getInstanceVariable(Dog.class, "_name");
//    return object_getIvar(self, ivar);
    return ((Dog *)self)->_name;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%s", __func__);
    if ([NSStringFromSelector(sel) isEqualToString:@"setName:"]) {
        class_addMethod(self, sel, (IMP)mySetName, "v@:@");
    }
    else {
        class_addMethod(self, sel, (IMP)myGetName, "@@:");
    }
    return YES;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"%s", __func__);
    return Cat.new;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"%s", __func__);
    NSString *selStr = NSStringFromSelector(aSelector);
    if([selStr isEqualToString:@"name"]) {
        NSMethodSignature *sig = [NSMethodSignature signatureWithObjCTypes:"@@:"];
        return sig;
    }
    else {
        NSMethodSignature *sig = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
        return sig;
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%s", __func__);
    
    SEL sel = [anInvocation selector];
    Cat *cat = [[Cat alloc] init];
    if([cat respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:cat];
    }
    else {
        [self doesNotRecognizeSelector:sel];
    } 
}
@end
