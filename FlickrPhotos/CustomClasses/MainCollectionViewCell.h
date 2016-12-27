//
//  MainCollectionViewCell.h
//  FlickrPhotos
//
//  Created by Francesca Corsini on 25/12/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrPhoto.h"


@interface MainCollectionViewCell : UICollectionViewCell


/**
 * Set content of the cell
 *
 */
- (void)setContent:(FlickrPhoto *)model;


@end
