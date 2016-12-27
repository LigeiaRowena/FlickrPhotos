//
//  FlickrPhoto.m
//  FlickrPhotos
//
//  Created by Francesca Corsini on 21/12/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//

#import "FlickrPhoto.h"
#import "Macros.h"


@implementation FlickrPhoto


#pragma mark - Init


- (instancetype)initFlickrPhotoWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        if (!isEmptyObject(dictionary)) {
            self.title = dictionary[@"title"];
            // 75x75 pixels thumbnail image
            self.thumbnailUrl = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_s.jpg", dictionary[@"farm"], dictionary[@"server"], dictionary[@"id"], dictionary[@"secret"]];
            if (iPad()) {
                // 1024 pixel on longest side image
                self.imageUrl = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_b.jpg", dictionary[@"farm"], dictionary[@"server"], dictionary[@"id"], dictionary[@"secret"]];
            } else if (iPhone()) {
                // 320 pixel on longest side image
                self.imageUrl = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_n.jpg", dictionary[@"farm"], dictionary[@"server"], dictionary[@"id"], dictionary[@"secret"]];
            }
        }
    }
    return self;
}


@end
