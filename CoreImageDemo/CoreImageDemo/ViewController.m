//
//  ViewController.m
//  CoreImageDemo
//
//  Created by AnkyHe on 11/14/13.
//  Copyright (c) 2013 Gery Studio. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () {
    CIContext *context;
    CIImage *image;
    dispatch_queue_t processingQueue;
}

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)dealloc
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    processingQueue = dispatch_queue_create("com.gmail.gerystudio.coreimagedemo.processing", NULL);
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"photo" ofType:@"png"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    image = [CIImage imageWithContentsOfURL:fileNameAndPath];
    context = [CIContext contextWithOptions:nil];
    
    [self slideValueChanged:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)slideValueChanged:(id)sender
{
    CGFloat value = 0.5;
    if (sender) {
        UISlider *slider = (UISlider *)sender;
        value = slider.value;
    }
    dispatch_async(processingQueue, ^() {
        CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                      keysAndValues: kCIInputImageKey, image,
                            @"inputIntensity", [NSNumber numberWithFloat:value], nil];
        CIImage *outputImage = [filter outputImage];
        
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        UIImage *newImage = [[UIImage alloc] initWithCGImage:cgimg];
        CGImageRelease(cgimg);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = newImage;
        });
    });
}

@end
