//
//  MainCollectionViewCell.m
//  FlickrPhotos
//
//  Created by Francesca Corsini on 25/12/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//

#import "MainCollectionViewCell.h"
#import "UIImageView+Utility.h"


@interface MainCollectionViewCell ()
@property (nonatomic, weak) IBOutlet UIImageView *thumbnail;
@end


@implementation MainCollectionViewCell


#pragma mark - Init


- (void)awakeFromNib {
    [super awakeFromNib];
    [self.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.layer setBorderWidth:0.5f];
    [self.layer setCornerRadius:4.0f];
    [self setClipsToBounds:YES];
    self.thumbnail.image = nil;
}


- (void)setContent:(FlickrPhoto *)model {
    [self.thumbnail setImageFromUrl:model.thumbnailUrl hasPlaceholder:YES isThumbnail:YES];
}


@end
