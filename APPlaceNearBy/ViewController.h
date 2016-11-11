//
//  ViewController.h
//  APPlaceNearBy
//
//  Created by Mac on 29/07/1938 Saka.
//  Copyright © 1938 Saka Aksh. All rights reserved.
//

#define kGoogleAPIKey @"AIzaSyDAYKFQOgnZZf40Z01qhu1VWNQ281Xh6Rk"
#define kLatitude 19.0760

#define kLongitude 72.8777



#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>



@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *placeTypes;
   
}

@property (strong, nonatomic) IBOutlet UITableView *placeTypeTableView;




@end

