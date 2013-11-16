//
//  FontSelectionViewController.m
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import "FontSelectionViewController.h"

@interface FontSelectionViewController ()

@end

@implementation FontSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.fontSelectionView = [[FontSelectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.fontSelectionView.delegate = self;
    self.view = self.fontSelectionView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - FontSelectionView Delegate Methods
- (void)FontSelectionViewSelectedFontNamed:(NSString *)fontName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:fontName forKey:@"fontName"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self.delegate fontSelectionViewControllerReceivedSelectedFontNamed:fontName];
}
@end
