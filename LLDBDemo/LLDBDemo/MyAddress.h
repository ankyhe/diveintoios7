//
//  MyAddress.h
//  LLDBDemo
//
//  Created by AnkyHe on 11/11/13.
//  Copyright (c) 2013 Gery. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _Gender : NSInteger {
    GenderUnknown = 0,
    GenderMale = 1,
    GenderFemale = 2,
} Gender;

@interface MyAddress : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) Gender gender;

@end
