//
//  FlickrPhotosTests.m
//  FlickrPhotosTests
//
//  Created by Francesca Corsini on 21/12/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FlickrNetwoking.h"


@interface FlickrPhotosTests : XCTestCase {
    FlickrNetwoking *flickrNetwoking;
}
@end


@implementation FlickrPhotosTests


- (void)setUp {
    [super setUp];
    flickrNetwoking = [FlickrNetwoking new];
}


- (void)tearDown {
    [super tearDown];
}


- (void)testFlickrAPI {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [flickrNetwoking fetchFlickrPhotos:@"xmas+cats" loadMore:NO block:^(NSArray *photos, NSError *error) {
        XCTAssertNil(error, @"flickr.photos.search request failed with error: %@", error);
        XCTAssert(photos, @"flickr.photos.search request has response nil");
        dispatch_semaphore_signal(semaphore);
    }];
    long rc = dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 60.0 * NSEC_PER_SEC));
    XCTAssertEqual(rc, 0, @"flickr.photos.search request timed out");
}


@end
