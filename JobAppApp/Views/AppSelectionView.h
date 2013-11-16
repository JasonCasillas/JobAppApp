//
//  AppSelectionView.h
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AppSelectionViewDelegate;

@interface AppSelectionView : UIView
{
    UILabel  *appSelectionLabel;
    UIButton *ideaBucketButton;
    UIButton *lotusWeiButton;
    UIButton *storiesOnStixButton;
    UIButton *cravingsTrackerButton;
}

@property (nonatomic, weak) id <AppSelectionViewDelegate> delegate;

- (void)tappedButton:(id)sender;
@end

@protocol AppSelectionViewDelegate <NSObject>
- (void)appSelectionViewSelectedAppNamed:(NSString *)appName;
@end
