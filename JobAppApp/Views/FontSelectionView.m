//
//  FontSelectionView.m
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import "FontSelectionView.h"

@implementation FontSelectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:19.0/255.0 green:22.0/255.0 blue:29.0/255.0 alpha:1.0];

        NSString *fontSelectionString = @"Pick a Font";
        UIFont *labelFont = [UIFont systemFontOfSize:40.0];
        CGSize fontSelectionLabelSize = [fontSelectionString sizeWithAttributes:[NSDictionary dictionaryWithObject:labelFont forKey:NSFontAttributeName]];
        fontSelectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(floorf(self.bounds.size.width/2-fontSelectionLabelSize.width/2),
                                                                       20.0,
                                                                       fontSelectionLabelSize.width,
                                                                       fontSelectionLabelSize.height)];
        fontSelectionLabel.text = fontSelectionString;
        fontSelectionLabel.backgroundColor = [UIColor clearColor];
        fontSelectionLabel.textAlignment = NSTextAlignmentCenter;
        fontSelectionLabel.textColor = [UIColor colorWithRed:115.0/255.0 green:148.0/255.0 blue:191.0/255.0 alpha:1.0];
        fontSelectionLabel.font = labelFont;
        [self addSubview:fontSelectionLabel];

        float buttonHeight = 50.0;
        float buttonGap = (self.bounds.size.height - (fontSelectionLabel.frame.origin.y+fontSelectionLabel.bounds.size.height)*2.0 - buttonHeight*4.0)/4.0;
        markerFeltButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [markerFeltButton setTitle:@"Marker Felt" forState:UIControlStateNormal];
        [markerFeltButton setFrame:CGRectMake(floorf(self.bounds.size.width/2-fontSelectionLabelSize.width/2),
                                              fontSelectionLabel.frame.origin.y+fontSelectionLabel.bounds.size.height+buttonGap,
                                              fontSelectionLabelSize.width,
                                              buttonHeight)];
        [markerFeltButton setTitleColor:[UIColor colorWithRed:255.0/255.0 green:195.0/255.0 blue:26.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        markerFeltButton.titleLabel.font = [UIFont fontWithName:@"Marker Felt" size:20.0];
        [markerFeltButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:markerFeltButton];

        helveticaNeueButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [helveticaNeueButton setTitle:@"Helvetica Neue" forState:UIControlStateNormal];
        [helveticaNeueButton setFrame:CGRectMake(floorf(self.bounds.size.width/2-fontSelectionLabelSize.width/2),
                                                 markerFeltButton.frame.origin.y+markerFeltButton.bounds.size.height+buttonGap,
                                                 fontSelectionLabelSize.width,
                                                 buttonHeight)];
        [helveticaNeueButton setTitleColor:[UIColor colorWithRed:255.0/255.0 green:195.0/255.0 blue:26.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        helveticaNeueButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0];
        [helveticaNeueButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:helveticaNeueButton];

        noteworthyButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [noteworthyButton setTitle:@"Noteworthy" forState:UIControlStateNormal];
        [noteworthyButton setFrame:CGRectMake(floorf(self.bounds.size.width/2-fontSelectionLabelSize.width/2),
                                              helveticaNeueButton.frame.origin.y+helveticaNeueButton.bounds.size.height+buttonGap,
                                              fontSelectionLabelSize.width,
                                              buttonHeight)];
        [noteworthyButton setTitleColor:[UIColor colorWithRed:255.0/255.0 green:195.0/255.0 blue:26.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        noteworthyButton.titleLabel.font = [UIFont fontWithName:@"Noteworthy" size:20.0];
        [noteworthyButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:noteworthyButton];

        papyrusButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [papyrusButton setTitle:@"Papyrus" forState:UIControlStateNormal];
        [papyrusButton setFrame:CGRectMake(floorf(self.bounds.size.width/2-fontSelectionLabelSize.width/2),
                                           noteworthyButton.frame.origin.y+noteworthyButton.bounds.size.height+buttonGap,
                                           fontSelectionLabelSize.width,
                                           buttonHeight)];
        [papyrusButton setTitleColor:[UIColor colorWithRed:255.0/255.0 green:195.0/255.0 blue:26.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        papyrusButton.titleLabel.font = [UIFont fontWithName:@"Papyrus" size:20.0];
        [papyrusButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:papyrusButton];
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
    NSString *selectedFont;

    if (sender == markerFeltButton) {
        selectedFont = @"Marker Felt";
    } else if (sender == helveticaNeueButton) {
        selectedFont = @"HelveticaNeue";
    } else if (sender == noteworthyButton) {
        selectedFont = @"Noteworthy";
    } else if (sender == papyrusButton) {
        selectedFont = @"Papyrus";
    }

    [self.delegate fontSelectionViewSelectedFontNamed:selectedFont];
}
@end
