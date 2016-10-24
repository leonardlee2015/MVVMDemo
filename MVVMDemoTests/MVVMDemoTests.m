//
//  MVVMDemoTests.m
//  MVVMDemoTests
//
//  Created by  Leonard on 2016/10/21.
//  Copyright © 2016年  Leonard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HomeVIewModel.h"

@interface MVVMDemoTests : XCTestCase
@property (nonnull,strong,nonatomic)XCTestExpectation *expectation;
@end

@implementation MVVMDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

-(void)testHomeVM{
    self.expectation = [self expectationWithDescription:@"aa"];

    HomeVIewModel *vm = [HomeVIewModel new];
    [vm handleDataWithSuccess:^(NSArray<HomeModel *> * _Nonnull homeModels) {


        XCTAssert(homeModels.count >0,@"adsfadfa");
        [self.expectation fulfill];
    } failure:^(NSError * _Nonnull error) {
        [self.expectation fulfill];

    }];
    [self waitForExpectationsWithTimeout:20 handler:nil];
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
