//
//  FontSelectionView.h
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FontSelectionViewDelegate;

@interface FontSelectionView : UIView
{
    UILabel  *fontSelectionLabel;
    UIButton *markerFeltButton;
    UIButton *helveticaNeueButton;
    UIButton *noteworthyButton;
    UIButton *papyrusButton;
}

@property (nonatomic, weak) id <FontSelectionViewDelegate> delegate;

- (void)tappedButton:(id)sender;
@end

@protocol FontSelectionViewDelegate <NSObject>
- (void)FontSelectionViewSelectedFontNamed:(NSString *)fontName;
@end
