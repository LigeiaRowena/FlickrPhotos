//
//  UIImageView+Utility.m
//  FlickrPhotos
//
//  Created by Francesca Corsini on 30/11/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//

#import "UIImageView+Utility.h"


@implementation UIImageView (Utility)


#pragma mark - Utility methods


- (void)setImageFromUrl:(NSString *)urlString {
	// set activity and placeholder
    self.image = [UIImage imageNamed:@"placeholder"];
	UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	activity.color = [UIColor blackColor];
	activity.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
	activity.hidesWhenStopped = YES;
	[self addSubview:activity];
    
    // start animating activity
    NSURL *url = [NSURL URLWithString:urlString];
    if (url == nil) {
        return;
    }
	[activity startAnimating];
    
    //
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            if (image && !error) {
                self.image = image;
            }
            [activity stopAnimating];
        });
    });
}


@end
