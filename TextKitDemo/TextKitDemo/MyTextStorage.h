//
//  MyTextStorage.h
//  TextKitDemo
//
//  Created by AnkyHe on 11/11/13.
//  Copyright (c) 2013 Gery. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const DefaultAttributeName;

@interface MyTextStorage : NSTextStorage

@property (nonatomic) NSDictionary *tokens;

@end
