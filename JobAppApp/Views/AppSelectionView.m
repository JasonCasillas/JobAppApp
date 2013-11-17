//
//  AppSelectionView.m
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import "AppSelectionView.h"

#import "UIColor+CustomColors.h"
#import "UIFont+CustomFont.h"

@implementation AppSelectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor backgroundBlue];

        float buttonGap = 20.0;
        UIImage *ideaBucketImage = [UIImage imageNamed:@"idea_bucket_icon.png"];
        ideaBucketButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [ideaBucketButton setImage:ideaBucketImage forState:UIControlStateNormal];
        [ideaBucketButton setFrame:CGRectMake(buttonGap,
                                              buttonGap,
                                              ideaBucketImage.size.width,
                                              ideaBucketImage.size.height)];
        [ideaBucketButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ideaBucketButton];

        UIImage *lotusWeiImage = [UIImage imageNamed:@"lotus_wei_icon.png"];
        lotusWeiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [lotusWeiButton setImage:lotusWeiImage forState:UIControlStateNormal];
        [lotusWeiButton setFrame:CGRectMake(self.bounds.size.width-buttonGap-lotusWeiImage.size.width,
                                            buttonGap,
                                            lotusWeiImage.size.width,
                                            lotusWeiImage.size.height)];
        [lotusWeiButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lotusWeiButton];

        UIImage *storiesOnStixImage = [UIImage imageNamed:@"stories_on_stix_icon.png"];
        storiesOnStixButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [storiesOnStixButton setImage:storiesOnStixImage forState:UIControlStateNormal];
        [storiesOnStixButton setFrame:CGRectMake(buttonGap,
                                                 self.bounds.size.height-buttonGap-storiesOnStixImage.size.height,
                                                 storiesOnStixImage.size.width,
                                                 storiesOnStixImage.size.height)];
        [storiesOnStixButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:storiesOnStixButton];

        UIImage *cravingsTrackerImage = [UIImage imageNamed:@"cravings_tracker_icon.png"];
        cravingsTrackerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cravingsTrackerButton setImage:cravingsTrackerImage forState:UIControlStateNormal];
        [cravingsTrackerButton setFrame:CGRectMake(self.bounds.size.width-buttonGap-cravingsTrackerImage.size.width,
                                                   self.bounds.size.height-buttonGap-cravingsTrackerImage.size.height,
                                                   cravingsTrackerImage.size.width,
                                                   cravingsTrackerImage.size.height)];
        [cravingsTrackerButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cravingsTrackerButton];

        NSString *appSelectionString = @"Which App Do You Like The Most";
        UIFont *labelFont = [UIFont selectedFontOfSize:40.0];
        CGRect appSelectionLabelBoundingRect = [appSelectionString boundingRectWithSize:CGSizeMake(self.bounds.size.width,
                                                                                                   (self.bounds.size.height-ideaBucketButton.frame.origin.y+ideaBucketButton.bounds.size.height)*2)
                                                                                options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                                             attributes:[NSDictionary dictionaryWithObject:labelFont
                                                                                                                    forKey:NSFontAttributeName]
                                                                                context:nil];
        appSelectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(floorf(self.bounds.size.width/2.0-appSelectionLabelBoundingRect.size.width/2.0),
                                                                      floorf(self.bounds.size.height/2.0-appSelectionLabelBoundingRect.size.height/2.0),
                                                                      appSelectionLabelBoundingRect.size.width,
                                                                      appSelectionLabelBoundingRect.size.height)];
        appSelectionLabel.numberOfLines = 0;
        appSelectionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        appSelectionLabel.text = appSelectionString;
        appSelectionLabel.backgroundColor = [UIColor clearColor];
        appSelectionLabel.textAlignment = NSTextAlignmentCenter;
        appSelectionLabel.textColor = [UIColor lightBlue];
        appSelectionLabel.font = labelFont;
        [self addSubview:appSelectionLabel];
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
    NSString *selectedAppName;

    if (sender == ideaBucketButton) {
        selectedAppName = @"Idea Bucket";
    } else if (sender == lotusWeiButton) {
        selectedAppName = @"Lotus Wei";
    } else if (sender == storiesOnStixButton) {
        selectedAppName = @"Stories on Stix";
    } else if (sender == cravingsTrackerButton) {
        selectedAppName = @"Cravings Tracker";
    }

    [self.delegate appSelectionViewSelectedAppNamed:selectedAppName];
}
@end
