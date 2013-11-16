//
//  RootViewController.h
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

#import "FontSelectionViewController.h"
#import "AppSelectionViewController.h"
#import "PuzzleViewController.h"
#import "FinalQuestionViewController.h"

@interface RootViewController : UIViewController <FontSelectionViewControllerDelegate,
                                                  AppSelectionViewControllerDelegate,
                                                  PuzzleViewControllerDelegate,
                                                  FinalQuestionViewControllerDelegate,
                                                  MFMailComposeViewControllerDelegate>
{
    FontSelectionViewController *fontSelectionViewController;
    AppSelectionViewController  *appSelectionViewController;
    PuzzleViewController        *puzzleViewController;
    FinalQuestionViewController *finalQuestionViewController;
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (void)createQuizObject;
@end
