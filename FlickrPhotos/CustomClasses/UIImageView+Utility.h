//
//  UIImageView+Utility.h
//  FlickrPhotos
//
//  Created by Francesca Corsini on 30/11/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImageView (Utility)


/**
 * Request UIImage property
 *
 * @param urlString photo's url string
 * @param hasPlaceholder tells if the image has a placeholder
 * @param isThumbnail tells if the image is a thumbnail, in this case it's used a normal UIActivityIndicatorView
 */
- (void)setImageFromUrl:(NSString *)urlString hasPlaceholder:(BOOL)hasPlaceholder isThumbnail:(BOOL)isThumbnail;


@end
