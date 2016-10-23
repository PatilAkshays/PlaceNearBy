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

@interface PlaceDetailsViewController : UIViewController<MKMapViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
}

@property NSString *selectedPlaceID;
@property (strong, nonatomic) IBOutlet UITextField *textFieldReview;
- (IBAction)doneAction:(id)sender;


@end
