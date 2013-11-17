//
//  UIFont+CustomFont.m
//  JobAppApp
//
//  Created by Jason Casillas on 11/17/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import "UIFont+CustomFont.h"

@implementation UIFont (CustomFont)

+(UIFont *)selectedFontOfSize:(CGFloat)fontSize
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *fontName = [userDefaults valueForKey:@"fontName"];

    return [UIFont fontWithName:fontName size:fontSize];
}
@end
