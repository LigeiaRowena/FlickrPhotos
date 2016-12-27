# FlickrPhotos
This is just a demo iOS app to search for public Flickr photos Edit.

The app loads the first 100 results from flickr.photos.search request, by scrolling to the bottom the client loads the following 100 results and so on.

I added a Unit Test class in order to test flickr.photos.search endpoint in case of errors, empty results and timeout.

I used Apple class Reachability in order to check for internet connection.

Please after cloning the repo run "pod install" from project folder.

Features:
- Minimum OS: iOS 10.1
- ARC
- Language used: Objective-C
- Devices: iPad/iPhone

Third part framework used:
- [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD)
