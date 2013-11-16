//
//  Quiz.h
//  JobAppApp
//
//  Created by Jason Casillas on 11/16/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Quiz : NSManagedObject

@property (nonatomic, retain) NSString * favoriteAppName;
@property (nonatomic, retain) NSDate * finishedAt;
@property (nonatomic, retain) NSNumber * isGoodExampleOfCode;
@property (nonatomic, retain) NSString * preferredFontName;
@property (nonatomic, retain) NSNumber * secondsToSolvePuzzle;
@property (nonatomic, retain) NSDate * startedAt;

@end
