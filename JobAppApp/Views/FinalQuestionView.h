//
//  FinalQuestionView.h
//  JobAppApp
//
//  Created by Jason Casillas on 11/16/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FinalQuestionViewDelegate;

@interface FinalQuestionView : UIView
{
    UILabel  *finalQuestionLabel;
    UIButton *enoughInfoButton;
    UIButton *notEnoughInfoButton;

    UILabel  *thanksLabel;
}

@property (nonatomic, weak) id <FinalQuestionViewDelegate> delegate;

- (void)tappedButton:(id)sender;
@end

@protocol FinalQuestionViewDelegate <NSObject>
- (void)finalQuestionViewSelectedEnoughInfo:(BOOL)enoughInfo;
@end
