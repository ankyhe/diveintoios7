//
//  DetailViewController.m
//  ViewControllerTransitionDemo
//
//  Created by AnkyHe on 11/12/13.
//  Copyright (c) 2013 Gery Studio. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, weak) UIView *backgroundView;
@property (nonatomic, weak) UIButton *button;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    self.backgroundView = view;
    self.backgroundView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.backgroundView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    self.button = button;
    [self.button setTitle:@"Done" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(doneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    self.backgroundView.center = CGPointMake(self.view.bounds.size.width * 0.5,
                                             self.view.bounds.size.height * 0.5);
    
    self.button.center = CGPointMake(self.backgroundView.bounds.size.width * 0.5,
                                     self.backgroundView.bounds.size.height * 0.5);
}

#pragma mark - Actions
- (void)doneButtonClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
