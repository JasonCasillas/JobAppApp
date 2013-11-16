//
//  Quiz.h
//  JobAppApp
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Quiz : NSManagedObject

@property (nonatomic, retain) NSString * preferredFontName;
@property (nonatomic, retain) NSString * favoriteAppName;
@property (nonatomic, retain) NSNumber * secondsToSolvePuzzle;
@property (nonatomic, retain) NSNumber * isGoodExample;
@property (nonatomic, retain) NSDate * startedAt;
@property (nonatomic, retain) NSDate * finishedAt;

@end
