//
//  NoteEditViewController.m
//  TextKitDemo
//
//  Created by AnkyHe on 10/18/13.
//  Copyright (c) 2013 Gery. All rights reserved.
//
#import "DatetimeView.h"
#import "MyTextStorage.h"

#import "NoteEditViewController.h"

@interface NoteEditViewController ()

@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) DatetimeView *datetimeView;
@property (nonatomic, assign) CGPoint beginLocation;

@end

@implementation NoteEditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(self.view.bounds.size.width, CGFLOAT_MAX)];
    textContainer.widthTracksTextView = YES;
    [layoutManager addTextContainer:textContainer];
    
    MyTextStorage *storage = [[MyTextStorage alloc] init];
    [storage addLayoutManager:layoutManager];
    storage.tokens = @{@"Anky" : @{NSForegroundColorAttributeName : [UIColor redColor]},
                       @"Bob" : @{NSForegroundColorAttributeName : [UIColor orangeColor]},
                       DefaultAttributeName : @{NSForegroundColorAttributeName : [UIColor blackColor]}};
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds textContainer:textContainer];
    self.textView = textView;
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.textView.text = self.text;
    [self.view addSubview:self.textView];
    
    DatetimeView *datetimeView = [[DatetimeView alloc] init];
    self.datetimeView = datetimeView;
    [self.view addSubview:self.datetimeView];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(panGestureRecognizer:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredContentSizeChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self updateDatetimeView];
}

#pragma mark - Notification
- (void)preferredContentSizeChanged:(NSNotification *)notifcation
{
    self.textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    [self updateDatetimeView];
}

#pragma mark - Gesture
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:self.view];
    if (CGRectContainsPoint(self.datetimeView.frame, location)) {
        return YES;
    }
    return NO;
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.beginLocation = [gestureRecognizer locationInView:self.view];
        
    } else {
        CGPoint location = [gestureRecognizer locationInView:self.view];
        self.datetimeView.center = CGPointMake(self.datetimeView.center.x + (location.x - self.beginLocation.x),
                                               self.datetimeView.center.y + (location.y - self.beginLocation.y));
        self.beginLocation = location;
        [self showDatetimeView];
    }
    
}

#pragma mark - Helper Methods
- (void)updateDatetimeView
{
    [self.datetimeView updateSize];
    self.datetimeView.frame = CGRectOffset(self.datetimeView.frame,
                                           self.view.frame.size.width - self.datetimeView.frame.size.width - 10,
                                           self.datetimeView.frame.size.height * 0.5 + 20);
    [self showDatetimeView];
    
}

- (void)showDatetimeView
{
    CGPoint center = [self.view convertPoint:self.datetimeView.center toView:self.textView];
    UIBezierPath *path = [self.datetimeView circlePathWithOrigin:center];
    self.textView.textContainer.exclusionPaths = @[path];
}




@end
