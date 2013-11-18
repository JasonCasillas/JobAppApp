//
//  PuzzleView.m
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import "PuzzleView.h"

#import "UIColor+CustomColors.h"
#import "UIFont+CustomFont.h"

@implementation PuzzleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor backgroundBlue];
        self.puzzleHasBeenSolved = NO;

        UIFont *labelFont = [UIFont selectedFontOfSize:40.0];

        NSString *suggestionHalfOneString = @"Move the";
        CGSize suggestionHalfOneLabelSize = [suggestionHalfOneString sizeWithAttributes:[NSDictionary dictionaryWithObject:labelFont forKey:NSFontAttributeName]];
        suggestionHalfOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(floorf(self.bounds.size.width/2-suggestionHalfOneLabelSize.width/2),
                                                                           floorf(self.bounds.size.height/3.0-suggestionHalfOneLabelSize.height/2.0),
                                                                           suggestionHalfOneLabelSize.width,
                                                                           suggestionHalfOneLabelSize.height)];
        suggestionHalfOneLabel.text = suggestionHalfOneString;
        suggestionHalfOneLabel.backgroundColor = [UIColor clearColor];
        suggestionHalfOneLabel.textColor = [UIColor lightBlue];
        suggestionHalfOneLabel.font = labelFont;
        [self addSubview:suggestionHalfOneLabel];

        float shapeViewPadding = 10.0;
        circleView = [[UIView alloc] initWithFrame:CGRectMake(suggestionHalfOneLabel.frame.origin.x+suggestionHalfOneLabel.bounds.size.width+shapeViewPadding,
                                                              floorf(suggestionHalfOneLabel.frame.origin.y+suggestionHalfOneLabel.bounds.size.height/2.0-25.0),
                                                              50.0,
                                                              50.0)];

        CALayer *circleViewLayer = [circleView layer];
        CAShapeLayer *circleShapeLayer = [CAShapeLayer layer];
        float radius = floorf(circleView.bounds.size.width/2.0);
        circleShapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                                           cornerRadius:radius].CGPath;
        circleShapeLayer.position = CGPointMake(0.5, 0.5);
        circleShapeLayer.fillColor = [UIColor clearColor].CGColor;
        circleShapeLayer.strokeColor = [UIColor lightOrange].CGColor;
        circleShapeLayer.lineWidth = 2.0;
        [circleViewLayer addSublayer:circleShapeLayer];

        [self addSubview:circleView];

        NSString *suggestionHalfTwoString = @"into the";
        CGSize suggestionHalfTwoLabelSize = [suggestionHalfTwoString sizeWithAttributes:[NSDictionary dictionaryWithObject:labelFont forKey:NSFontAttributeName]];
        suggestionHalfTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(floorf(self.bounds.size.width/2-suggestionHalfTwoLabelSize.width/2),
                                                                           floorf(self.bounds.size.height*2.0/3.0-suggestionHalfTwoLabelSize.height/2.0),
                                                                           suggestionHalfTwoLabelSize.width,
                                                                           suggestionHalfTwoLabelSize.height)];
        suggestionHalfTwoLabel.text = suggestionHalfTwoString;
        suggestionHalfTwoLabel.backgroundColor = [UIColor clearColor];
        suggestionHalfTwoLabel.textColor = [UIColor lightBlue];
        suggestionHalfTwoLabel.font = labelFont;
        [self addSubview:suggestionHalfTwoLabel];

        squareView = [[UIView alloc] initWithFrame:CGRectMake(suggestionHalfTwoLabel.frame.origin.x+suggestionHalfTwoLabel.bounds.size.width+shapeViewPadding,
                                                              floorf(suggestionHalfTwoLabel.frame.origin.y+suggestionHalfTwoLabel.bounds.size.height/2.0-10.0),
                                                              20.0,
                                                              20.0)];

        CALayer *squareViewLayer = [squareView layer];
        squareViewLayer.borderWidth = 2.0;
        squareViewLayer.borderColor = [UIColor lightOrange].CGColor;

        [self addSubview:squareView];

        //Put the circle view in front, in case the squareView is enlarged enough to make it difficult to grab, but not enough to fully enclose it
        [self bringSubviewToFront:circleView];

        circlePanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [circleView addGestureRecognizer:circlePanGestureRecognizer];

        squarePinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
        [self addGestureRecognizer:squarePinchGestureRecognizer];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



#pragma mark - Location Calculation Methods
- (BOOL)view:(UIView *)movingView isWithinView:(UIView *)containingView
{
    // Check if starting x and y points of circle are greater than those of the square
    // And if ending x and y points of circle are less than those of the square
    if (movingView.frame.origin.x >= containingView.frame.origin.x &&
        movingView.frame.origin.y >= containingView.frame.origin.y &&
        movingView.frame.origin.x+movingView.bounds.size.width <= containingView.frame.origin.x+containingView.bounds.size.width &&
        movingView.frame.origin.y+movingView.bounds.size.height <= containingView.frame.origin.y+containingView.bounds.size.height) {
        return YES;
    }
    return NO;
}


#pragma mark - Gesture Recognizers
- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    if (self.puzzleHasBeenSolved) {
        return;
    }

    CGPoint point = [recognizer locationInView:self];
    [circleView setCenter:point];

    if ([self view:circleView isWithinView:squareView]) {
        [self.delegate puzzleViewPlacedCircleInSquare];
    }
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer
{
    if (self.puzzleHasBeenSolved) {
        return;
    }

    if ([recognizer state] == UIGestureRecognizerStateBegan) {
        squareStartingWidth = squareView.bounds.size.width;
    } else if ([recognizer state] == UIGestureRecognizerStateChanged) {
        CGFloat scaleValue = [(UIPinchGestureRecognizer *)recognizer scale];

        CGRect bounds = squareView.bounds;
        bounds.size.width = floorf(squareStartingWidth*scaleValue);
        bounds.size.height = floorf(squareStartingWidth*scaleValue);
        squareView.bounds = bounds;

        if ([self view:circleView isWithinView:squareView]) {
            [self.delegate puzzleViewPlacedCircleInSquare];
        }
    }
}
@end
