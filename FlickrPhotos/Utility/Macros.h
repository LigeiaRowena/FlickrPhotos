//
//  Macros.h
//  BBDemo
//
//  Created by Francesca Corsini on 20/11/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#pragma mark - Const


static NSString *showDetailSegue = @"showDetail";
static NSString *cellIdentifier = @"cellIdentifier";
static NSString *flickrBaseUrl = @"https://api.flickr.com/services/rest/";
static NSString *flickrMethod = @"flickr.photos.search";
static NSString *flickrApiKey = @"59194e39afb206d5ca6ab89f13cbbcc6";


#pragma mark - Interface orientation


static inline UIInterfaceOrientation getOrientation() {
	if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait || [UIDevice currentDevice].orientation == UIDeviceOrientationPortraitUpsideDown)
		return UIInterfaceOrientationPortrait;
	else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft)
		return UIInterfaceOrientationLandscapeRight;
	else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight)
		return UIInterfaceOrientationLandscapeLeft;
	else
		return [[UIApplication sharedApplication] statusBarOrientation];
}


#pragma mark - Device version

static inline BOOL iPad() {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}


static inline BOOL iPhone() {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}


#pragma mark - UI Utility


static inline CGFloat textWidth(UILabel *label) {
	return [label.text boundingRectWithSize:label.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size.width;
}


#pragma mark - NS Utility


static inline NSNumberFormatter *getDecimalFormatter(int digits) {
	NSNumberFormatter *defaultFormatter = [[NSNumberFormatter alloc] init];
	defaultFormatter.locale = [NSLocale currentLocale];
	[defaultFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
	[defaultFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[defaultFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	[defaultFormatter setMaximumFractionDigits:digits];
	[defaultFormatter setMinimumFractionDigits:digits];
	defaultFormatter.alwaysShowsDecimalSeparator = NO;
	return defaultFormatter;
}



static inline BOOL isEmptyObject(id object) {
    return (object == nil || [object isEqual:[NSNull null]] || [object count] == 0);
}


static inline BOOL isEmptyNumber(NSNumber *number) {
    return ([number isEqual:[NSNull null]] || [number isEqualToNumber:[NSNumber numberWithInt:0]]);
}


static inline BOOL isEmptyString(NSString *string) {
    return (string == nil || [string isEqual:[NSNull null]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]);
}

