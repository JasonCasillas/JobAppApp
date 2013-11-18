//
//  PuzzleView.h
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PuzzleViewDelegate;

@interface PuzzleView : UIView
{
    UILabel *suggestionHalfOneLabel;
    UILabel *suggestionHalfTwoLabel;

    UIView *circleView;
    UIView *squareView;
    float   squareStartingWidth;

    UIPanGestureRecognizer   *circlePanGestureRecognizer;
    UIPinchGestureRecognizer *squarePinchGestureRecognizer;
}

@property BOOL puzzleHasBeenSolved;

@property (nonatomic, weak) id <PuzzleViewDelegate> delegate;

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer;
- (void)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer;
- (BOOL)view:(UIView *)movingView isWithinView:(UIView *)containingView;
@end

@protocol PuzzleViewDelegate <NSObject>
- (void)puzzleViewPlacedCircleInSquare;
@end
