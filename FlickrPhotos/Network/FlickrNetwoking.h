//
//  FlickrNetwoking.h
//  FlickrPhotos
//
//  Created by Francesca Corsini on 21/12/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface FlickrNetwoking : NSObject


/**
 Reset properties
 */
- (void)reset;


/**
 * Fetch for Flickr photos
 *
 * @param searchTerm string to search
 * @param loadMore sets if the request is done for more results
 * @param block completion with response/error
 */
- (void)fetchFlickrPhotos:(NSString *)searchTerm loadMore:(BOOL)loadMore block:(void (^)(NSArray *photos, NSError *error))block;


/**
 Checks if Flickr search has more results

 @return tells if the endpoint has more results
 */
- (BOOL)hasMoreResults;


@end
