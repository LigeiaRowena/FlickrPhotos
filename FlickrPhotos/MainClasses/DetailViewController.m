//
//  DetailViewController.m
//  FlickrPhotos
//
//  Created by Francesca Corsini on 26/12/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+Utility.h"


@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end


@implementation DetailViewController


#pragma mark - Init


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.photo.title;
    [self.imageView setImageFromUrl:self.photo.imageUrl hasPlaceholder:NO isThumbnail:NO];
}


@end
