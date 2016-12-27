//
//  UIImageView+Utility.m
//  FlickrPhotos
//
//  Created by Francesca Corsini on 30/11/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//

#import "UIImageView+Utility.h"
#import "SVProgressHUD.h"


@implementation UIImageView (Utility)


#pragma mark - Utility methods


- (void)setImageFromUrl:(NSString *)urlString hasPlaceholder:(BOOL)hasPlaceholder isThumbnail:(BOOL)isThumbnail {
    
	// set placeholder
    if (hasPlaceholder) {
        self.image = [UIImage imageNamed:@"placeholder"];
    }
    
    // set activity
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    if (isThumbnail) {
        activity.color = [UIColor blackColor];
        activity.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        activity.hidesWhenStopped = YES;
        [self addSubview:activity];
    } else {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    }
	
    
    // start animating activity
    NSURL *url = [NSURL URLWithString:urlString];
    if (url == nil) {
        return;
    }
    if (isThumbnail) {
        [activity startAnimating];
    } else {
        [SVProgressHUD show];
    }
    
    // make request
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            if (image && !error) {
                self.image = image;
            }
            if (isThumbnail) {
                [activity stopAnimating];
            } else {
                [SVProgressHUD dismiss];
            }
        });
    });
}


@end
