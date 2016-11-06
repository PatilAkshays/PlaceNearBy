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
    double widthPhoto;
    
    
    NSXMLParser *parser;
    
    NSMutableArray *placeDetailsList;

    NSMutableDictionary *placeDetailsDictionary;
    
    NSString *detailDataString;
    

}

@property NSString *selectedPlaceID;
@property NSString *selectedPlaceLat;
@property NSString *selectedPlaceLng;
@property NSString *selectedPhotoReference;
@property NSString *selectedPhotoWidth;


@property (strong, nonatomic) IBOutlet MKMapView *locationMapView;
@property (strong, nonatomic) IBOutlet UIImageView *locationImage;

@property (strong, nonatomic) IBOutlet UILabel *labelOpenClose;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UILabel *labelAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelContactNo;

- (IBAction)doneAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tableViewReview;


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *detailsListIndicator;





@end
