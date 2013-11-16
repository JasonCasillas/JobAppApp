//
//  RootViewController.m
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import "RootViewController.h"

#import "Quiz.h"

@interface RootViewController ()
{
    Quiz *currentQuiz;
}

- (void)createQuizObject;
- (void)transitionToFavoriteAppView;
- (void)transitionToPuzzleView;
- (void)transitionToFinalQuestionView;
@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    fontSelectionViewController = [[FontSelectionViewController alloc] init];
    fontSelectionViewController.delegate = self;
    [self addChildViewController:fontSelectionViewController];
    fontSelectionViewController.view.frame = self.view.frame;
    [self.view addSubview:fontSelectionViewController.view];
    [fontSelectionViewController didMoveToParentViewController:self];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Transition Methods
- (void)transitionToFavoriteAppView
{
    appSelectionViewController = [[AppSelectionViewController alloc] init];
    appSelectionViewController.delegate = self;
    [self addChildViewController:appSelectionViewController];

    [self transitionFromViewController:fontSelectionViewController
                      toViewController:appSelectionViewController
                              duration:0.5
                               options:UIViewAnimationOptionTransitionFlipFromBottom
                            animations:nil
                            completion:^(BOOL finished) {
                                [fontSelectionViewController removeFromParentViewController];
                                [appSelectionViewController didMoveToParentViewController:self];
                            }];
}

- (void)transitionToPuzzleView
{
    puzzleViewController = [[PuzzleViewController alloc] init];
    puzzleViewController.delegate = self;
    [self addChildViewController:puzzleViewController];

    [self transitionFromViewController:appSelectionViewController
                      toViewController:puzzleViewController
                              duration:0.5
                               options:UIViewAnimationOptionTransitionFlipFromRight
                            animations:nil
                            completion:^(BOOL finished) {
                                [appSelectionViewController removeFromParentViewController];
                                [puzzleViewController didMoveToParentViewController:self];
                            }];
}

- (void)transitionToFinalQuestionView
{
    NSLog(@"Ask away...");
}


#pragma mark - Core Data Methods
- (void)createQuizObject
{
    currentQuiz = (Quiz *)[NSEntityDescription insertNewObjectForEntityForName:@"Quiz" inManagedObjectContext:self.managedObjectContext];
    currentQuiz.startedAt = [NSDate date];
}


#pragma mark - FontSelectionViewControllerDelegate Methods
- (void)fontSelectionViewControllerReceivedSelectedFontNamed:(NSString *)fontName
{
    currentQuiz.preferredFontName = fontName;

    [self transitionToFavoriteAppView];
}

#pragma mark - AppSelectionViewControllerDelegate Methods
- (void)appSelectionViewControllerReceivedSelectedAppNamed:(NSString *)appName
{
    currentQuiz.favoriteAppName = appName;

    [self transitionToPuzzleView];
}


#pragma mark - PuzzleViewControllerDelegate Methods
- (void)puzzleViewControllerSolvedPuzzleInSeconds:(NSNumber *)seconds
{
    currentQuiz.secondsToSolvePuzzle = seconds;

    [self transitionToFinalQuestionView];
}
@end
