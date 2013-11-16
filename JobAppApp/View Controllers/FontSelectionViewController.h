//
//  FontSelectionViewController.h
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FontSelectionView.h"

@protocol FontSelectionViewControllerDelegate;

@interface FontSelectionViewController : UIViewController <FontSelectionViewDelegate>

@property (nonatomic, strong) FontSelectionView *fontSelectionView;

@property (nonatomic, weak) id <FontSelectionViewControllerDelegate> delegate;
@end

@protocol FontSelectionViewControllerDelegate <NSObject>
- (void)fontSelectionViewControllerReceivedSelectedFontNamed:(NSString *)fontName;
@end
