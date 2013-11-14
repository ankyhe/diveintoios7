//
//  ViewController.m
//  CoreAnimationDemo
//
//  Created by AnkyHe on 11/13/13.
//  Copyright (c) 2013 Gery Studio. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) CALayer *theLayer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    /*
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 400;
    self.view.layer.sublayerTransform = perspective;
    
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(100, 100, 100, 100);
    blueLayer.backgroundColor = [[UIColor blueColor] CGColor];
    blueLayer.zPosition = -100;
    [self.view.layer addSublayer:blueLayer];
    
    CALayer *greenLayer = [CALayer layer];
    greenLayer.frame = CGRectMake(140, 140, 100, 100);
    greenLayer.backgroundColor = [[UIColor greenColor] CGColor];
    [self.view.layer addSublayer:greenLayer];
    
    CALayer *grayLayer = [CALayer layer];
    grayLayer.frame = CGRectMake(180, 180, 100, 100);
    grayLayer.backgroundColor = [[UIColor grayColor] CGColor];
    grayLayer.zPosition = 100;
    [self.view.layer addSublayer:grayLayer];
    
    [self performSelector:@selector(animate) withObject:nil afterDelay:0.5];
     */
    
    /*
    CALayer *greenLayer = [CALayer layer];
    greenLayer.frame = CGRectMake(140, 140, 100, 100);
    greenLayer.position = CGPointMake(self.view.bounds.size.width * .5, 190);
    greenLayer.backgroundColor = [[UIColor greenColor] CGColor];
    [self.view.layer addSublayer:greenLayer];
    
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(140, 260, 100, 100);
    blueLayer.anchorPoint = CGPointMake(0.6, 0.5);
    blueLayer.position = CGPointMake(self.view.bounds.size.width * .5, 310);
    blueLayer.backgroundColor = [[UIColor blueColor] CGColor];
    [self.view.layer addSublayer:blueLayer];
     */
    
    /*
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 400;
    self.view.layer.sublayerTransform = perspective;
    
    CALayer *greenLayer = [CALayer layer];
    greenLayer.frame = CGRectMake(140, 20, 100, 300);
    greenLayer.position = CGPointMake(self.view.bounds.size.width * .5, 190);
    greenLayer.backgroundColor = [[UIColor greenColor] CGColor];
    self.theLayer = greenLayer;
    [self.view.layer addSublayer:greenLayer];
    [self performSelector:@selector(flipBack) withObject:nil afterDelay:0.5];
     */
    
    CALayer *imageLayer = [CALayer layer];
    imageLayer.backgroundColor = [UIColor blueColor].CGColor;
    imageLayer.frame = CGRectMake(100, 100, 100, 111);
    imageLayer.contents = (id)[[UIImage imageNamed:@"phone.png"] CGImage];
    imageLayer.contentsScale = 2.0f;
    imageLayer.borderColor = [[UIColor greenColor] CGColor];
    imageLayer.borderWidth = 1.0f;
    imageLayer.cornerRadius = 10.0f;
    imageLayer.masksToBounds = YES;
    
    CALayer *imageBgLayer = [CALayer layer];
    imageBgLayer.frame = imageLayer.frame;
    imageBgLayer.borderColor = [[UIColor greenColor] CGColor];
    imageBgLayer.borderWidth = 1.0f;
    imageBgLayer.cornerRadius = 10.0f;
    imageBgLayer.shadowOpacity = 0.5;
    imageBgLayer.shadowOffset = CGSizeMake(5, 5);
    [self.view.layer addSublayer:imageBgLayer];
    [self.view.layer addSublayer:imageLayer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animate
{
    [UIView animateWithDuration:2.0 animations:^{
        CATransform3D perspective = CATransform3DIdentity;
        perspective.m34 = -1.0 / 800;
        self.view.layer.sublayerTransform = perspective;
    }];
    
}

- (void)flipBack
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI / 4];
    rotationAnimation.duration = 1.0f;
    [self.theLayer addAnimation:rotationAnimation forKey:@"rotationAnimation1"];
    
}

@end
