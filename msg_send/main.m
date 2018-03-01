//
//  main.m
//  msg_send
//
//  Created by Phoenix on 2018/3/1.
//  Copyright © 2018年 Phoenix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"
#import <objc/message.h>
#import "Cat.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Dog *dog = [Dog new];
        dog.name = @"Kiki";
        objc_msgSend(dog, @selector(setName:), @"Kiki");
        NSLog(@"%@", dog.name);
//        Cat *cat = Cat.new;
//        [cat mew];
//        objc_msgSend(cat, @selector(mew));
//        [cat performSelector:@selector(lalala)];
    }
    return 0;
}
