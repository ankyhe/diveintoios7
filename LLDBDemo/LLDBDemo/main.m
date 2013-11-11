//
//  main.m
//  LLDBDemo
//
//  Created by AnkyHe on 11/11/13.
//  Copyright (c) 2013 Gery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAddress.h"

#import "AppDelegate.h"

void initializeMyAdresses()
{
    MyAddress *address1 = [[MyAddress alloc] init];
    address1.name = @"Anky";
    address1.age = 32;
    address1.gender = GenderMale;
    MyAddress *address2 = [[MyAddress alloc] init];
    address2.name = @"Alice";
    address2.age = 26;
    address1.gender = GenderMale;
    MyAddress *address3 = [[MyAddress alloc] init];
    address3.name = @"Sally";
    address3.age = 29;
    address3.gender = GenderMale;
    
    NSArray *array = @[address1, address2, address3];
    NSLog(@"array is %@", array);
}

int main(int argc, char * argv[])
{
    @autoreleasepool {
        initializeMyAdresses();
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
