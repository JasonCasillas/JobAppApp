//
//  FinalQuestionViewController.m
//  JobAppApp
//
//  Created by Jason Casillas on 11/16/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import "FinalQuestionViewController.h"

@interface FinalQuestionViewController ()

@end

@implementation FinalQuestionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.finalQuestionView = [[FinalQuestionView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.finalQuestionView.delegate = self;
    self.view = self.finalQuestionView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - FinalQuestionViewDelegate Methods
- (void)finalQuestionViewSelectedEnoughInfo:(BOOL)enoughInfo
{
    [self.delegate FinalQuestionViewControllerReceivedEnoughInformation:enoughInfo];
}
@end
