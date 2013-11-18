//
//  JobAppAppTests.m
//  JobAppAppTests
//
//  Created by Jason Casillas on 11/15/13.
//  Copyright (c) 2013 The World Needs Heroes. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PuzzleView.h"

@interface JobAppAppTests : XCTestCase

@end

@implementation JobAppAppTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testExample
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}

- (void)testMovingViewIsWithinContainingViewIfContainingViewIsLargeEnoughAndMovingViewIsWithinIt
{
    PuzzleView *puzzleView = [[PuzzleView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 200.0)];

    UIView *containingView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
    [puzzleView addSubview:containingView];

    UIView *movingView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 10.0, 10.0)];
    [puzzleView addSubview:movingView];

    XCTAssertTrue([puzzleView view:movingView isWithinView:containingView], @"Should have been within the boundaries");
}

- (void)testMovingViewIsNotWithinContainingViewIfContainingViewIsLargeEnoughAndMovingViewIsOutsideIt
{
    PuzzleView *puzzleView = [[PuzzleView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 200.0)];

    UIView *containingView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
    [puzzleView addSubview:containingView];

    UIView *movingView = [[UIView alloc] initWithFrame:CGRectMake(21.0, 21.0, 10.0, 10.0)];
    [puzzleView addSubview:movingView];

    XCTAssertFalse([puzzleView view:movingView isWithinView:containingView], @"Should not have been within the boundaries");
}

- (void)testMovingViewIsNotWithinContainingViewIfContainingViewIsNotLargeEnoughAndMovingViewIsInsideIt
{
    PuzzleView *puzzleView = [[PuzzleView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 200.0)];

    UIView *containingView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 10.0, 10.0)];
    [puzzleView addSubview:containingView];

    UIView *movingView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 11.0, 11.0)];
    [puzzleView addSubview:movingView];

    XCTAssertFalse([puzzleView view:movingView isWithinView:containingView], @"Should not have been small enough to fit");
}

- (void)testMovingViewIsNotWithinContainingViewIfContainingViewIsNotLargeEnoughAndMovingViewIsOutsideIt
{
    PuzzleView *puzzleView = [[PuzzleView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 200.0)];

    UIView *containingView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 10.0, 10.0)];
    [puzzleView addSubview:containingView];

    UIView *movingView = [[UIView alloc] initWithFrame:CGRectMake(11.0, 11.0, 20.0, 20.0)];
    [puzzleView addSubview:movingView];

    XCTAssertFalse([puzzleView view:movingView isWithinView:containingView], @"Should not have been small enough to fit, nor within the boundaries");
}
@end
