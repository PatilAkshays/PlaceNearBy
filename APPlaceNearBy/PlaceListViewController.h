//
//  PlaceListViewController.h
//  APPlaceNearBy
//
//  Created by Mac on 29/07/1938 Saka.
//  Copyright © 1938 Saka Aksh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PlaceDetailsViewController.h"



@interface PlaceListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,NSXMLParserDelegate>
{
    CLLocationManager *myLocationManager;
    NSString *currentLatitude;
    NSString *currentLongitude;
    
    NSMutableArray *placeList;
    
    NSXMLParser *parser;
    
    NSString *dataString;

    NSMutableDictionary *placeDictionary;
    
}

@property NSString *selectedPlaceType;


@property (strong, nonatomic) IBOutlet UITableView *placeListTableView;
- (IBAction)refreshAction:(id)sender;

@end
