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

@interface RootViewController : UIViewController <FontSelectionViewControllerDelegate,
                                                  AppSelectionViewControllerDelegate>
{
    FontSelectionViewController *fontSelectionViewController;
    AppSelectionViewController  *appSelectionViewController;
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
