//
//  FinalQuestionViewController.h
//  JobAppApp
//
//  Created by Jason Casillas on 11/16/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FinalQuestionView.h"

@protocol FinalQuestionViewControllerDelegate;

@interface FinalQuestionViewController : UIViewController <FinalQuestionViewDelegate>

@property (nonatomic, strong) FinalQuestionView *finalQuestionView;

@property (nonatomic, weak) id <FinalQuestionViewControllerDelegate> delegate;
@end

@protocol FinalQuestionViewControllerDelegate <NSObject>
- (void)FinalQuestionViewControllerReceivedEnoughInformation:(BOOL)gaveEnoughInformation;
@end
