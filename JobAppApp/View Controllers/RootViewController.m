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

- (void)storeFinishedQuiz;
- (void)transitionToFavoriteAppView;
- (void)transitionToPuzzleView;
- (void)transitionToFinalQuestionView;
- (void)shareResultsViaEmail;
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
    finalQuestionViewController = [[FinalQuestionViewController alloc] init];
    finalQuestionViewController.delegate = self;
    [self addChildViewController:finalQuestionViewController];
    
    [self transitionFromViewController:puzzleViewController
                      toViewController:finalQuestionViewController
                              duration:0.5
                               options:UIViewAnimationOptionTransitionFlipFromTop
                            animations:nil
                            completion:^(BOOL finished) {
                                [puzzleViewController removeFromParentViewController];
                                [finalQuestionViewController didMoveToParentViewController:self];
                            }];
}


#pragma mark - Email Methods
- (void)shareResultsViaEmail
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;

        [mailViewController setToRecipients:@[@"jason.casillas@gmail.com"]];

        NSString *subjectString = @"Job App: Is there more code where that came from?";
        NSString *exampleCodeString = @"This example was nice, but I'd like to see something using ...";
        if ([currentQuiz.isGoodExampleOfCode boolValue]) {
            subjectString = @"Job App: That'll do";
            exampleCodeString = @"We might be in touch...";
        }
        [mailViewController setSubject:subjectString];

        [mailViewController setMessageBody:[NSString stringWithFormat:@"I picked %@ because... \r\nI think %@ is great because... \r\nIt took me %i seconds to finish the puzzle.\r\n%@", currentQuiz.preferredFontName, currentQuiz.favoriteAppName, [currentQuiz.secondsToSolvePuzzle intValue], exampleCodeString, nil] isHTML:NO];

        [self presentViewController:mailViewController animated:YES completion:nil];
    } else {
        NSLog(@"Device is unable to send email in its current state.");
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Core Data Methods
- (void)createQuizObject
{
    currentQuiz = (Quiz *)[NSEntityDescription insertNewObjectForEntityForName:@"Quiz" inManagedObjectContext:self.managedObjectContext];
    currentQuiz.startedAt = [NSDate date];
}

- (void)storeFinishedQuiz
{
    currentQuiz.finishedAt = [NSDate date];

    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"The finished quiz did not save with error: %@", [error userInfo]);
    }
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


#pragma mark - FinalQuestionViewControllerDelegate Methods
- (void)FinalQuestionViewControllerReceivedEnoughInformation:(BOOL)gaveEnoughInformation
{
    currentQuiz.isGoodExampleOfCode = [NSNumber numberWithBool:gaveEnoughInformation];

    [self storeFinishedQuiz];
    [self shareResultsViaEmail];
}
@end
