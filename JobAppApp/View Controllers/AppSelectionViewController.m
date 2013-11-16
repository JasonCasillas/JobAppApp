//
//  AppSelectionViewController.m
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import "AppSelectionViewController.h"

@interface AppSelectionViewController ()

@end

@implementation AppSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.appSelectionView = [[AppSelectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.appSelectionView.delegate = self;
    self.view = self.appSelectionView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - AppSelectionView Delegate Methods
- (void)appSelectionViewSelectedAppNamed:(NSString *)appName
{
    [self.delegate appSelectionViewControllerReceivedSelectedAppNamed:appName];
}
@end
