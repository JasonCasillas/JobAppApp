//
//  AppSelectionViewController.h
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppSelectionView.h"

@protocol AppSelectionViewControllerDelegate;

@interface AppSelectionViewController : UIViewController <AppSelectionViewDelegate>

@property (nonatomic, strong) AppSelectionView *appSelectionView;

@property (nonatomic, weak) id <AppSelectionViewControllerDelegate> delegate;
@end

@protocol AppSelectionViewControllerDelegate <NSObject>
- (void)appSelectionViewControllerReceivedSelectedAppNamed:(NSString *)appName;
@end
