//
//  DatetimeView.m
//  TextKitDemo
//
//  Created by AnkyHe on 10/18/13.
//  Copyright (c) 2013 Gery. All rights reserved.
//

#import "DatetimeView.h"

@interface DatetimeView()

@property (nonatomic, weak) UILabel *label;

@end

@implementation DatetimeView
- (id)init
{
    return [self initWithDate:nil];
}

- (id)initWithDate:(NSDate *)date
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.label.textColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        UILabel *label = [[UILabel alloc] init];
        self.label = label;
        NSDateFormatter* format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"dd\rMMMM\ryyyy"];
        if (!date) {
            date = [NSDate date];
        }
        NSString *dateString = [format stringFromDate:date];
        self.label.text = dateString;
        [self addSubview:self.label];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor whiteColor];
        self.label.numberOfLines = 0;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(ctx, YES);
    UIBezierPath *path = [self circlePathWithOrigin:self.label.center];
    [[UIColor greenColor] setFill];
    [path fill];
}

#pragma mark - Member Methods
- (void)updateSize
{
    self.label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.label.frame = CGRectMake(0, 0, FLT_MAX, FLT_MAX);
    [self.label sizeToFit];
    CGFloat radius = [self radiusToSurroundFrame:self.label.frame];
    self.frame = CGRectMake(0, 0, radius * 2, radius * 2);
    self.label.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

- (float)radiusToSurroundFrame:(CGRect)frame
{
    return MAX(frame.size.width, frame.size.height) * 0.5 + 20;
}
                      

#pragma mark - Helper Methods
- (UIBezierPath *)circlePathWithOrigin:(CGPoint)origin
{
    CGFloat radius = [self radiusToSurroundFrame:self.label.frame];
    return [UIBezierPath bezierPathWithArcCenter:origin
                                          radius:radius
                                      startAngle:-180.0f
                                        endAngle:180.0f
                                       clockwise:YES];
}

@end
