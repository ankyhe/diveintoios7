//
//  NoteListViewController.m
//  TextKitDemo
//
//  Created by AnkyHe on 10/18/13.
//  Copyright (c) 2013 Gery. All rights reserved.
//

#import "NoteListViewController.h"

#import "NoteEditViewController.h"

static NSArray *noteList = nil;
static NSArray *noteContentList = nil;


@interface NoteListViewController ()

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation NoteListViewController
+ (void)initialize
{
    if (self == [NoteListViewController class]) {
        noteList = @[@"Shopping List", @"TODO List"];
        noteContentList = @[@"For both methods, the gesture recognizer delegate is called once per recognition attempt, which means that failure requirements can be determined lazily. It also means that you can set up failure requirements between recognizers in different view hierarchies. An example of a situation where dynamic failure requirements are useful is in an app that attaches a screen-edge pan gesture recognizer to a view. In this case, you might want all other relevant gesture recognizers associated with that view's subtree to require the screen-edge gesture recognizer to fail so you can prevent any graphical glitches that might occur when the other recognizers get canceled after starting the recognition process. To do this, you could use code similar to the following:",
                            @"In iOS 7, tint color is a property of UIView. iOS 7 apps often use a tint to define a key color that indicates interactivity and selection state for UI elements throughout the app. When you specify a tint for a view, the tint is automatically propagated to all subviews in the view’s hierarchy. Because UIWindow inherits from UIView, you can specify a tint color for the entire app by setting the window’s tint property using code like this:"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    self.title = NSLocalizedString(@"Notes", nil);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView = tableView;
    self.tableView.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
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

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return noteList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const CellIdentity = @"CellIdentity";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentity];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentity];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cell.textLabel.text = noteList[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    return font.lineHeight * 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteEditViewController *ctrl = [[NoteEditViewController alloc] init];
    ctrl.text = noteContentList[indexPath.row];
    [self.navigationController pushViewController:ctrl animated:YES];
}

#pragma mark - Notification
- (void)preferredContentSizeChanged:(NSNotification *)notification
{
    NSLog(@"here");
    [self.tableView reloadData];
}

@end
