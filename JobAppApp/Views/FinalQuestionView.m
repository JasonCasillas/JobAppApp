//
//  FinalQuestionView.m
//  JobAppApp
//
//  Created by Jason Casillas on 11/16/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import "FinalQuestionView.h"

#import "UIColor+CustomColors.h"
#import "UIFont+CustomFont.h"

#import "Constants.h"

@implementation FinalQuestionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor backgroundBlue];

        NSString *finalQuestionString = @"This is a pretty simple app, but does it give you enough insight into how I code?";
        UIFont *labelFont = [UIFont selectedFontOfSize:30.0];
        float labelPadding = 20.0;
        float buttonGap = 20.0;

        CGRect finalQuestionLabelBoundingRect = [finalQuestionString boundingRectWithSize:CGSizeMake(self.bounds.size.width-labelPadding*2.0,
                                                                                                     self.bounds.size.height-(TEXT_BUTTON_HEIGHT*2.0+buttonGap))
                                                                                  options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                                               attributes:[NSDictionary dictionaryWithObject:labelFont
                                                                                                                    forKey:NSFontAttributeName]
                                                                                  context:nil];

        finalQuestionLabel = [[UILabel alloc] initWithFrame:CGRectMake(floorf(self.bounds.size.width/2.0-finalQuestionLabelBoundingRect.size.width/2.0),
                                                                       labelPadding,
                                                                       finalQuestionLabelBoundingRect.size.width,
                                                                       finalQuestionLabelBoundingRect.size.height)];
        finalQuestionLabel.numberOfLines = 0;
        finalQuestionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        finalQuestionLabel.text = finalQuestionString;
        finalQuestionLabel.backgroundColor = [UIColor clearColor];
        finalQuestionLabel.textColor = [UIColor lightBlue];
        finalQuestionLabel.font = labelFont;
        [self addSubview:finalQuestionLabel];

        UIFont *buttonFont = [UIFont selectedFontOfSize:30.0];
        enoughInfoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [enoughInfoButton setTitle:@"Yep" forState:UIControlStateNormal];
        [enoughInfoButton setFrame:CGRectMake(floorf(self.bounds.size.width/2-finalQuestionLabelBoundingRect.size.width/2),
                                              self.bounds.size.height-(TEXT_BUTTON_HEIGHT*2.0+buttonGap*2.0),
                                              finalQuestionLabelBoundingRect.size.width,
                                              TEXT_BUTTON_HEIGHT)];
        [enoughInfoButton setTitleColor:[UIColor lightOrange] forState:UIControlStateNormal];
        enoughInfoButton.titleLabel.font = buttonFont;
        [enoughInfoButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:enoughInfoButton];

        notEnoughInfoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [notEnoughInfoButton setTitle:@"Nope" forState:UIControlStateNormal];
        [notEnoughInfoButton setFrame:CGRectMake(floorf(self.bounds.size.width/2-finalQuestionLabelBoundingRect.size.width/2),
                                                 enoughInfoButton.frame.origin.y+TEXT_BUTTON_HEIGHT+buttonGap,
                                                 finalQuestionLabelBoundingRect.size.width,
                                                 TEXT_BUTTON_HEIGHT)];
        [notEnoughInfoButton setTitleColor:[UIColor lightOrange] forState:UIControlStateNormal];
        notEnoughInfoButton.titleLabel.font = buttonFont;
        [notEnoughInfoButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:notEnoughInfoButton];

        NSString *thankYouString = @"Thanks for Playing!";
        thanksLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelPadding,
                                                                0.0,
                                                                self.bounds.size.width-labelPadding*2.0,
                                                                self.bounds.size.height)];
        thanksLabel.numberOfLines = 0;
        thanksLabel.lineBreakMode = NSLineBreakByWordWrapping;
        thanksLabel.text = thankYouString;
        thanksLabel.textAlignment = NSTextAlignmentCenter;
        thanksLabel.backgroundColor = [UIColor clearColor];
        thanksLabel.textColor = [UIColor lightBlue];
        thanksLabel.font = labelFont;
        thanksLabel.hidden = YES;
        [self addSubview:thanksLabel];

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


#pragma mark - Gesture Recognizers
- (void)tappedButton:(id)sender
{
    BOOL enoughInfo = YES;

    if (sender == notEnoughInfoButton) {
        enoughInfo = NO;
    }

    [self.delegate finalQuestionViewSelectedEnoughInfo:enoughInfo];
    thanksLabel.hidden = NO;
    finalQuestionLabel.hidden = YES;
    enoughInfoButton.hidden = YES;
    notEnoughInfoButton.hidden = YES;
}
@end
