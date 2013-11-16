//
//  PuzzleViewController.m
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import "PuzzleViewController.h"

@interface PuzzleViewController ()
{
    NSDate *startTime;
}
@end

@implementation PuzzleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.puzzleView = [[PuzzleView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.puzzleView.delegate = self;
    self.view = self.puzzleView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    startTime = [NSDate date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PuzzleView Delegate Methods
- (void)puzzleViewPlacedCircleInSquare
{
    self.puzzleView.puzzleHasBeenSolved = YES;

    NSDate *endTime = [NSDate date];

    NSTimeInterval intervalSinceStart = [endTime timeIntervalSinceDate:startTime];
    int secondsSinceLoading = round(intervalSinceStart);

    [self.delegate puzzleViewControllerSolvedPuzzleInSeconds:[NSNumber numberWithInt:secondsSinceLoading]];
}
@end
