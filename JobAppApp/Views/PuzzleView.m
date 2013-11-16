//
//  PuzzleView.m
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import "PuzzleView.h"

@implementation PuzzleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:19.0/255.0 green:22.0/255.0 blue:29.0/255.0 alpha:1.0];
        self.puzzleHasBeenSolved = NO;

        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *fontName = [userDefaults valueForKey:@"fontName"];
        UIFont *labelFont = [UIFont fontWithName:fontName size:40.0];

        NSString *suggestionHalfOneString = @"Move the";
        CGSize suggestionHalfOneLabelSize = [suggestionHalfOneString sizeWithAttributes:[NSDictionary dictionaryWithObject:labelFont forKey:NSFontAttributeName]];
        suggestionHalfOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(floorf(self.bounds.size.width/2-suggestionHalfOneLabelSize.width/2),
                                                                           floorf(self.bounds.size.height/3.0-suggestionHalfOneLabelSize.height/2.0),
                                                                           suggestionHalfOneLabelSize.width,
                                                                           suggestionHalfOneLabelSize.height)];
        suggestionHalfOneLabel.text = suggestionHalfOneString;
        suggestionHalfOneLabel.backgroundColor = [UIColor clearColor];
        suggestionHalfOneLabel.textColor = [UIColor colorWithRed:115.0/255.0 green:148.0/255.0 blue:191.0/255.0 alpha:1.0];
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
        circleShapeLayer.strokeColor = [UIColor colorWithRed:255.0/255.0 green:195.0/255.0 blue:26.0/255.0 alpha:1.0].CGColor;
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
        suggestionHalfTwoLabel.textColor = [UIColor colorWithRed:115.0/255.0 green:148.0/255.0 blue:191.0/255.0 alpha:1.0];
        suggestionHalfTwoLabel.font = labelFont;
        [self addSubview:suggestionHalfTwoLabel];

        squareView = [[UIView alloc] initWithFrame:CGRectMake(suggestionHalfTwoLabel.frame.origin.x+suggestionHalfTwoLabel.bounds.size.width+shapeViewPadding,
                                                              floorf(suggestionHalfTwoLabel.frame.origin.y+suggestionHalfTwoLabel.bounds.size.height/2.0-10.0),
                                                              20.0,
                                                              20.0)];

        CALayer *squareViewLayer = [squareView layer];
        squareViewLayer.borderWidth = 2.0;
        squareViewLayer.borderColor = [UIColor colorWithRed:255.0/255.0 green:195.0/255.0 blue:26.0/255.0 alpha:1.0].CGColor;

        [self addSubview:squareView];

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
- (BOOL)circleIsWithinSquare
{
    // Check if starting x and y points of circle are greater than those of the square
    // And if ending x and y points of circle are less than those of the square
    if (circleView.frame.origin.x >= squareView.frame.origin.x &&
        circleView.frame.origin.y >= squareView.frame.origin.y &&
        circleView.frame.origin.x+circleView.bounds.size.width <= squareView.frame.origin.x+squareView.bounds.size.width &&
        circleView.frame.origin.y+circleView.bounds.size.height <= squareView.frame.origin.y+squareView.bounds.size.height) {
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

    if ([self circleIsWithinSquare]) {
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

        if ([self circleIsWithinSquare]) {
            [self.delegate puzzleViewPlacedCircleInSquare];
        }
    }
}
@end
