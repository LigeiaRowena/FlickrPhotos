//
//  ViewController.m
//  FlickrPhotos
//
//  Created by Francesca Corsini on 21/12/16.
//  Copyright © 2016 Francesca Corsini. All rights reserved.
//

#import "MainViewController.h"
#import "MainCollectionViewCell.h"
#import "Macros.h"
#import "FlickrNetwoking.h"
#import "FlickrPhoto.h"
#import "SVProgressHUD.h"


@interface MainViewController () {
    NSMutableArray *data;
    FlickrNetwoking *flickrNetwoking;
}
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@end


@implementation MainViewController


#pragma mark - Init MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init data
    data = @[].mutableCopy;
    flickrNetwoking = [FlickrNetwoking new];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [flickrNetwoking reset];
    self.searchBar.text = @"";
    data = @[].mutableCopy;
    [self.collectionView reloadData];
}


#pragma mark - UISearchBarDelegate


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {    
    // resign searchbar
    [searchBar resignFirstResponder];
    
    // run search
    if (!isEmptyString(searchBar.text)) {
        NSString *searchTerm = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD show];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [flickrNetwoking fetchFlickrPhotos:searchTerm loadMore:NO block:^(NSArray *photos, NSError *error) {
            if (error) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Unable to reach network" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [self presentViewController:alertController animated:YES completion:nil];
                });
            } else {
                data = photos.mutableCopy;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [self.collectionView reloadData];
                });
            }
        }];
    } else {
        // empty data
        data = @[].mutableCopy;
        [self.collectionView reloadData];
    }
}


#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return data.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    FlickrPhoto *photo = data[indexPath.row];
    [cell setContent:photo];
    return cell;
}


#pragma mark - UICollectionViewDelegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height) {
        [self loadOtherPages];
    }
}


- (void)loadOtherPages {
    if (![flickrNetwoking hasMoreResults]) {
        return;
    }
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"Loading other results..."];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [flickrNetwoking fetchFlickrPhotos:nil loadMore:YES block:^(NSArray *photos, NSError *error) {
        if (error) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Unable to reach network" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [self presentViewController:alertController animated:YES completion:nil];
            });
        } else {
            data = [data arrayByAddingObjectsFromArray:photos].mutableCopy;
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [self.collectionView reloadData];
            });
        }
    }];
}


@end
