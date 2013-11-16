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
    NSLog(@"This is where the transition would occur");
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
}
@end
