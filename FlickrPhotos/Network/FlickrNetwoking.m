//
//  FlickrNetwoking.m
//  FlickrPhotos
//
//  Created by Francesca Corsini on 21/12/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//


#import "FlickrNetwoking.h"
#import "Macros.h"
#import "FlickrPhoto.h"

//#import "Reachability.h"


@interface FlickrNetwoking () {
    NSUInteger totalCount;
    NSUInteger pages;
    NSUInteger currentPage;
    NSString *searchString;
}
@end


@implementation FlickrNetwoking


#pragma mark - Init


- (instancetype)init {
    if (self = [super init]) {
        [self reset];
    }
    return self;
}


#pragma mark - Public


- (void)reset {
    totalCount = 0;
    pages = 0;
    currentPage = 1;
    searchString = nil;
}


- (BOOL)hasMoreResults {
    return (currentPage < totalCount);
}


- (void)fetchFlickrPhotos:(NSString *)searchTerm loadMore:(BOOL)loadMore block:(void (^)(NSArray *photos, NSError *error))block {
    if (loadMore)
        currentPage++;
    
    if (!isEmptyString(searchTerm)) {
        // different fetch
        if (![searchTerm isEqualToString:searchString]) {
            [self reset];
        }
        searchString = searchTerm;
    }
    
    NSString *stringUrl = [NSString stringWithFormat:@"%@?method=%@&api_key=%@&text=%@&media=photos&page=%lu&format=json&nojsoncallback=1", flickrBaseUrl, flickrMethod, flickrApiKey, searchString, (unsigned long)currentPage];
    NSURL *url = [NSURL URLWithString:stringUrl];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *dataError = nil;
        NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&dataError];
        if (!dataError) {
            NSError *jsonError = nil;
            id response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            if (!jsonError) {
                totalCount = [response[@"photos"][@"total"] integerValue];
                pages = [response[@"photos"][@"pages"] integerValue];
                currentPage = [response[@"photos"][@"page"] integerValue];
                NSArray *jsonArray = response[@"photos"][@"photo"];
                NSString *state = response[@"stat"]; //available values: ok, fail
                if ([state isEqualToString:@"ok"]) {
                    NSArray *parsedArray = [self parsedModelFromArray:jsonArray];
                    block(parsedArray, nil);
                } else {
                    NSError *flickrError = [[NSError alloc] initWithDomain:NSLocalizedDescriptionKey code:0 userInfo:@{@"description": response[@"message"]}];
                    NSLog(@"Error: %@", [flickrError localizedDescription]);
                    block(nil, flickrError);
                }
            } else {
                NSLog(@"Error: %@", [jsonError localizedDescription]);
                block(nil, jsonError);
            }
        } else {
            NSLog(@"Error: %@", [dataError localizedDescription]);
            block(nil, dataError);
        }
    });

    
    /*
    // set Reachability object to check internet connection
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    if (netStatus == NotReachable) {
        block(nil, @"Internet connection not available");
        return;
    }
    */
}


- (NSArray *)parsedModelFromArray:(NSArray *)array {
    NSMutableArray *modelArray = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        FlickrPhoto *model = [[FlickrPhoto alloc] initFlickrPhotoWithDictionary:dict];
        [modelArray addObject:model];
    }
    return modelArray;
}


@end
