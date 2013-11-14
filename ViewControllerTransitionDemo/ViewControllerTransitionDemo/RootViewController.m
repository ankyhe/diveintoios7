//
//  RootViewController.m
//  ViewControllerTransitionDemo
//
//  Created by AnkyHe on 11/12/13.
//  Copyright (c) 2013 Gery Studio. All rights reserved.
//
#import "DetailViewController.h"
#import "MyTransitionAnimator.h"

#import "RootViewController.h"

@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView = tableView;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const CellIdentity = @"CellIdentity";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentity];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentity];
    }
    cell.textLabel.text = @"Select this";
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.transitioningDelegate = self;
    detailViewController.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:detailViewController animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    MyTransitionAnimator *animator = [[MyTransitionAnimator alloc] init];
    animator.presenting = YES;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    MyTransitionAnimator *animator = [[MyTransitionAnimator alloc] init];
    return animator;
}


@end
