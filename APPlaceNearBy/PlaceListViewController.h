//
//  PlaceListViewController.h
//  APPlaceNearBy
//
//  Created by Mac on 29/07/1938 Saka.
//  Copyright © 1938 Saka Aksh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>



@interface PlaceListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,NSXMLParserDelegate>
{
    CLLocationManager *myLocationManager;
    NSString *currentLatitude;
    NSString *currentLongitude;
    
    NSMutableArray *placeList;
    NSMutableDictionary *placeDictionary;
    NSMutableDictionary *latLongDictionary;


    NSXMLParser *parser;
    
    NSString *dataString;

    
}

@property NSString *selectedPlaceType;

@property (strong, nonatomic) IBOutlet UITableView *placeListTableView;
- (IBAction)refreshAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *listIndicator;
@end
