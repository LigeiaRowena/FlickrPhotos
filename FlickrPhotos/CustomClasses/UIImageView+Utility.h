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
 * Request image property
 *
 * @param urlString photo's url string
 */
- (void)setImageFromUrl:(NSString *)urlString;


@end
