//
//  PuzzleViewController.h
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PuzzleView.h"

@protocol PuzzleViewControllerDelegate;

@interface PuzzleViewController : UIViewController <PuzzleViewDelegate>

@property (nonatomic, strong) PuzzleView *puzzleView;

@property (nonatomic, weak) id <PuzzleViewControllerDelegate> delegate;
@end

@protocol PuzzleViewControllerDelegate <NSObject>
- (void)puzzleViewControllerSolvedPuzzleInSeconds:(NSNumber *)seconds;
@end
