//
//  PlaceDetailsViewController.h
//  APPlaceNearBy
//
//  Created by Mac on 29/07/1938 Saka.
//  Copyright © 1938 Saka Aksh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CustomTableViewCell.h"


@interface PlaceDetailsViewController : UIViewController<MKMapViewDelegate,UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>
{
    double detailsLatitude;
    double detailsLongitude;
    
    
    NSString *photoRef;
    NSString *CurrentStatus;

    int widthPhoto;
    
    
    NSXMLParser *parser;
    
    NSMutableArray *placeDetailsList;
    NSMutableArray *reviewsList;

    NSMutableDictionary *placeDetailsDictionary;
    NSMutableDictionary *reviewsDictionary;

    NSString *detailDataString;
    NSString *reviewString;


}

@property NSString *selectedPlaceID;
@property NSString *selectedPlaceLat;
@property NSString *selectedPlaceLng;
@property NSString *selectedPhotoReference;
@property NSString *selectedPhotoWidth;
@property NSString *selectedPlaceStatus;


@property (strong, nonatomic) IBOutlet MKMapView *locationMapView;
@property (strong, nonatomic) IBOutlet UIImageView *locationImage;

@property (strong, nonatomic) IBOutlet UILabel *labelOpenClose;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UILabel *labelAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelContactNo;


@property (strong, nonatomic) IBOutlet UITableView *tableViewReview;


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *detailsListIndicator;

- (IBAction)buttonDone:(id)sender;




@end
