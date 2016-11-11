//
//  PlaceDetailsViewController.m
//  APPlaceNearBy
//
//  Created by Mac on 29/07/1938 Saka.
//  Copyright © 1938 Saka Aksh. All rights reserved.
//

#import "PlaceDetailsViewController.h"
#import "ViewController.h"

@interface PlaceDetailsViewController ()

@end

@implementation PlaceDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.locationMapView.delegate = self;

    [self setUp];
    
    self.title =[NSString stringWithFormat:@"Place Details"];


    placeDetailsList = [[NSMutableArray alloc]init];

    reviewsList = [[NSMutableArray alloc]init];

    
    detailsLatitude = self.selectedPlaceLat.doubleValue;
    
    detailsLongitude = self.selectedPlaceLng.doubleValue;
    
    
    CLLocationCoordinate2D location = _locationMapView.userLocation.coordinate;
    MKCoordinateRegion region;
    
    location.latitude  = detailsLatitude;
    location.longitude = detailsLongitude;

    MKPointAnnotation *myAnnotation =[[MKPointAnnotation alloc]init];
    
    myAnnotation.coordinate = location;
    
    [_locationMapView addAnnotation:myAnnotation];
    
    region.center = location;
 
    
    widthPhoto = self.selectedPhotoWidth.intValue;
    
    photoRef = self.selectedPhotoReference;

    CurrentStatus= self.selectedPlaceStatus;


   [self getPhotoDetailsWithAPIKey:kGoogleAPIKey photoReference:photoRef photoWidth:widthPhoto];

   [self getPlaceListDetailsWithAPIKey:kGoogleAPIKey placeID:self.selectedPlaceID];
    
    
    
    if ([CurrentStatus isEqualToString:@"true"]) {
        
        
        _labelOpenClose.text = [NSString stringWithFormat:@"Open Now"];
    }
    else{
        _labelOpenClose.text = [NSString stringWithFormat:@"Close Now"];

    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)setUp {
         
         self.detailsListIndicator.hidesWhenStopped = YES;
         
}
//fetch usko double me convert
//jo double me convert hua h usklo cooridnate bana using CLLocationCoordinate2D


//mkpointannotion
//mapview addannotation


-(void)getPlaceListDetailsWithAPIKey:(NSString *)key
                    placeID:(NSString *)placeID
{
    [self.detailsListIndicator startAnimating];

    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/xml?&key=%@&placeid=%@",key,placeID];
    
    
    NSLog(@"%@",urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSLog(@"%@",url);

    NSURLSession *mySession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *task = [mySession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            //alert
        }
        else {
            
            if (response) {
                
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                
                if (httpResponse.statusCode == 200) {
                    
                    if (data) {
                        
                        //xml parsing
                        
                        parser = [[NSXMLParser alloc]initWithData:data];
                        parser.delegate = self;
                        [parser parse];
                        
                    }
                    else {
                        //alert
                        [self.detailsListIndicator stopAnimating];

                    }
                }
                else {
                    //alert
                    [self.detailsListIndicator stopAnimating];

                }
                
            }
            else {
                //alert
                [self.detailsListIndicator stopAnimating];

            }
        }
        
        
    }];
    
    
    [task resume];
    
}



-(void)getPhotoDetailsWithAPIKey:(NSString *)key
                             photoReference:(NSString *)photoREf
                      photoWidth:(int)width
{
   // [self.detailsListIndicator startAnimating];
    
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?key=%@&photoreference=%@&maxwidth=%d",key,photoRef,width];

    
    
    NSLog(@"%@",urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *mySession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDownloadTask *myDownloadTask = [mySession downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            //alert
        }
        else {
            
            if (response) {
                
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                
                if (httpResponse.statusCode == 200) {
                    
                        
                        NSData *imageData = [NSData dataWithContentsOfURL:location];
                        
                        UIImage *image = [UIImage imageWithData:imageData];

                        [self performSelectorOnMainThread:@selector(updateLocationImage:) withObject:image waitUntilDone:NO];
                }
                else {
                    //alert
                    NSLog(@"%ld",(long)httpResponse.statusCode);
                   
                    
                    
                    NSData *imageData = [NSData dataWithContentsOfURL:location];
                    
                    UIImage *image = [UIImage imageWithData:imageData];
                    
                    [self performSelectorOnMainThread:@selector(updateLocationImage:) withObject:image waitUntilDone:NO];
                    
                    [self.detailsListIndicator stopAnimating];

                }
                
            }
            else {
                //alert
                [self.detailsListIndicator stopAnimating];
                
            }
        }
        
        
    }];
    
    
    [myDownloadTask resume];
    
    
    
}

-(void)updateLocationImage:(UIImage *)image {
    
    self.locationImage.image  = image;
    [self.detailsListIndicator stopAnimating];

}




-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    if ([elementName isEqualToString:@"result"]) {
        
        placeDetailsDictionary = [[NSMutableDictionary alloc]init];
        
    }
    
   else if ([elementName isEqualToString:@"review"]) {
        
        reviewsDictionary = [[NSMutableDictionary alloc]init];
           }
 
    else if ([elementName isEqualToString:@"name"]) {
        detailDataString = [[NSMutableString alloc]init];
    
    }
    else if ([elementName isEqualToString:@"vicinity"]) {
        detailDataString = [[NSMutableString alloc]init];
    }
    else if ([elementName isEqualToString:@"formatted_phone_number"]) {
        detailDataString = [[NSMutableString alloc]init];
    }
    else if ([elementName isEqualToString:@"author_name"]) {
        
        reviewString = [[NSMutableString alloc]init];
    }
    else if ([elementName isEqualToString:@"time"]) {
        reviewString = [[NSMutableString alloc]init];
    }
    else if ([elementName isEqualToString:@"text"]) {
        reviewString = [[NSMutableString alloc]init];
    }

    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    detailDataString = string;
    reviewString = string;

}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"result"]) {
        
        [placeDetailsList addObject:placeDetailsDictionary];
        
       //  [self.detailsListIndicator stopAnimating];
        NSLog(@"%@",placeDetailsDictionary);
        
       // NSLog(@"%@",placeDetailsList);
        
    }


    else if ([elementName isEqualToString:@"review"]) {
        
        [reviewsList addObject:reviewsDictionary];
    
    //    [self.detailsListIndicator stopAnimating];
    //    NSLog(@"%@",placeDetailsDictionary);

    //    NSLog(@"%@",placeDetailsList);

    }
    else if ([elementName isEqualToString:@"name"]) {
        
        [placeDetailsDictionary setValue:detailDataString forKey:@"name"];
    }
    else if ([elementName isEqualToString:@"vicinity"]) {
        
        [placeDetailsDictionary setValue:detailDataString forKey:@"vicinity"];

    }
    else if ([elementName isEqualToString:@"formatted_phone_number"]) {
        
        [placeDetailsDictionary setValue:detailDataString forKey:@"formatted_phone_number"];
    }

    else if ([elementName isEqualToString:@"author_name"]) {
        
        [reviewsDictionary setValue:reviewString forKey:@"author_name"];

    }
    else if ([elementName isEqualToString:@"time"]) {
        
        [reviewsDictionary setValue:reviewString forKey:@"time"];
        
    }
    else if ([elementName isEqualToString:@"text"]) {
        
        [reviewsDictionary setValue:reviewString forKey:@"text"];
        
    }
    
    else if([elementName isEqualToString:@"PlaceDetailsResponse"]){

        [self performSelectorOnMainThread:@selector(updateTableView) withObject:nil waitUntilDone:NO];
        
    }
    

    _labelName.text = [placeDetailsDictionary valueForKey:@"name"];
    
   // [self.labelAddress setLineBreakMode:NSLineBreakByWordWrapping];
    
    //_labelAddress.numberOfLines = 3 ;
    
    _labelAddress.text = [placeDetailsDictionary valueForKey:@"vicinity"];
    

    
    _labelContactNo.text = [placeDetailsDictionary valueForKey:@"formatted_phone_number"];
    
    [self.detailsListIndicator stopAnimating];


     //   [name enumerateSubstringsInRange:NSMakeRange(0, [name length]) options:NSStringEnumerationBySentences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
            
     //       _labelName.text = name;
      //  }];
    

}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"PARSE ERROR : %@",parseError.localizedDescription);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return reviewsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Custom_Cell"];
    
    
    [self.detailsListIndicator stopAnimating];
    
    
    NSMutableDictionary *tempDictionary = [reviewsList objectAtIndex:indexPath.row];
    
    NSLog(@"%@",tempDictionary);
    
    
    
    NSString *reviewerName = [tempDictionary valueForKey:@"author_name"];
    NSString *unix = [tempDictionary valueForKey:@"time"];
    NSString *reviewerText = [tempDictionary valueForKey:@"text"];
    
    
    // NSString *unix = [NSString stringWithFormat:@"%@",[placeDetailsList valueForKey:@"time"]];
    
    double unixTime = unix.intValue;
    
    NSTimeInterval _interval = unixTime;
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:_interval];
    
    NSDateFormatter *formatterHours= [[NSDateFormatter alloc] init];
    
    
    [formatterHours setLocale:[NSLocale currentLocale]];
    
    [formatterHours setDateFormat:@"MMM/dd/yyyy, HH:mm a"];
    
    NSString *hoursString = [formatterHours stringFromDate:date];
    
    
    
    
    cell.labelReviewName.text = reviewerName;
    
    cell.labelReviewName.textColor = [UIColor blueColor];
    
    
    
    cell.labelReviewTime.text = hoursString;
    
    
    
    cell.labelreviewText.text = reviewerText;
    
    
    
    cell.backgroundColor = [UIColor lightTextColor];
    
    
    return cell;
    
    
}

-(void)updateTableView {
    

    [self.tableViewReview reloadData];
    

    
}

- (IBAction)buttonDone:(id)sender {
     ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];

    [self.navigationController pushViewController:viewController animated:YES];

}
@end
