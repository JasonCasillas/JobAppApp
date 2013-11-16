//
//  RootViewController.h
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FontSelectionViewController.h"
#import "AppSelectionViewController.h"
#import "PuzzleViewController.h"

@interface RootViewController : UIViewController <FontSelectionViewControllerDelegate,
                                                  AppSelectionViewControllerDelegate,
                                                  PuzzleViewControllerDelegate>
{
    FontSelectionViewController *fontSelectionViewController;
    AppSelectionViewController  *appSelectionViewController;
    PuzzleViewController        *puzzleViewController;
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end
