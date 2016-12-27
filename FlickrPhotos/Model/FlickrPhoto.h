//
//  FlickrPhoto.h
//  FlickrPhotos
//
//  Created by Francesca Corsini on 21/12/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface FlickrPhoto : NSObject


@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumbnailUrl;
@property (nonatomic, strong) NSString *imageUrl;


/**
 * Init the model
 *
 */
- (id)initFlickrPhotoWithDictionary:(NSDictionary *)dictionary;


@end
