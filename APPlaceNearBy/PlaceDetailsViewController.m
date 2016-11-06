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
    

    
    placeDetailsList = [[NSMutableArray alloc]init];

    
    
    detailsLatitude = self.selectedPlaceLat.doubleValue;
    
    detailsLongitude = self.selectedPlaceLng.doubleValue;
    
    widthPhoto=self.selectedPhotoWidth.doubleValue;
    
    photoRef = self.selectedPhotoReference;
    
        [self setUp];

    [self getPhotoDetailsWithAPIKey:kGoogleAPIKey photoReference:self.selectedPhotoReference photoWidth:widthPhoto];

    
   [self getPlaceListDetailsWithAPIKey:kGoogleAPIKey placeID:self.selectedPlaceID];
    
    self.locationMapView.delegate = self;
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


-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
   
    //MKCoordinateSpan mySpan = MKCoordinateSpanMake(0.001, 0.001);

    CLLocationCoordinate2D pressedCoordinate;
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(detailsLatitude,detailsLongitude),500,500);
    
    MKPointAnnotation *myAnnotation =[[MKPointAnnotation alloc]init];
    
    myAnnotation.coordinate = pressedCoordinate;
    
    [mapView addAnnotation:myAnnotation];

   [mapView setRegion:region animated:YES];
//    
//    
//    CLLocationCoordinate2D placeCoord;
//    placeCoord.latitude=[[loc objectForKey:@"lat"] doubleValue];
//    placeCoord.longitude=[[loc objectForKey:@"lng"] doubleValue];
//    
//    MKMapPoint *placeObject = [[MKPointAnnotation alloc]initWithName:name address:vicinity rating:rating coordinate:placeCoord];
//    
//    [_mapView addAnnotation:placeObject];
    
}

-(void)getPlaceListDetailsWithAPIKey:(NSString *)key
                    placeID:(NSString *)placeID
{
    [self.detailsListIndicator startAnimating];

    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/xml?&key=%@&placeid=%@",key,placeID];
    
    
    NSLog(@"%@",urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
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
                      photoWidth:(double)width
{
   // [self.detailsListIndicator startAnimating];
    
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?key=%@&photoreference=%@&maxwidth=%f",key,photoRef,width];

    
    
    NSLog(@"%@",urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
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
                        
                       
                        self.locationImage.image = [UIImage imageWithData:data];
  
                        
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return placeDetailsList.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Custom_Cell"];
    
    
    [self.detailsListIndicator stopAnimating];

    
    NSMutableDictionary *tempDictionary = [placeDetailsList objectAtIndex:indexPath.row];
    
    NSLog(@"%@",tempDictionary);
    
    
    
    NSString *reviewerName = [tempDictionary valueForKey:@"author_name"];
    NSString *unix = [tempDictionary valueForKey:@"time"];
    NSString *reviewerText = [tempDictionary valueForKey:@"text"];
   
    
   // NSString *unix = [NSString stringWithFormat:@"%@",[placeDetailsList valueForKey:@"time"]];
    
    double unixTimeStamp = unix.intValue;
    
    NSTimeInterval _interval  =   unixTimeStamp;
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:_interval];
    
    NSDateFormatter *formatterHours= [[NSDateFormatter alloc] init];
    
    
    [formatterHours setLocale:[NSLocale currentLocale]];
    
    [formatterHours setDateFormat:@"HH:mm a"];
    
    NSString *hoursString = [formatterHours stringFromDate:date];
    

    
    
    cell.labelReviewName.text = reviewerName;
    
    cell.labelReviewName.textColor = [UIColor blueColor];
    
    
    
    cell.labelReviewTime.text = hoursString;
    

    
    cell.labelreviewText.text = reviewerText;
    
    
    
    cell.backgroundColor = [UIColor lightTextColor];
    
    
    return cell;
    
    
}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    
    if ([elementName isEqualToString:@"result"]) {
        placeDetailsDictionary = [[NSMutableDictionary alloc]init];
        
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
        detailDataString = [[NSMutableString alloc]init];
    }
    else if ([elementName isEqualToString:@"time"]) {
        detailDataString = [[NSMutableString alloc]init];
    }
    else if ([elementName isEqualToString:@"text"]) {
        detailDataString = [[NSMutableString alloc]init];
    }

    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    detailDataString = string;
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"result"]) {
        
        [placeDetailsList addObject:placeDetailsDictionary];
        


        [self.detailsListIndicator stopAnimating];
        NSLog(@"%@",placeDetailsDictionary);

        NSLog(@"%@",placeDetailsList);

        
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
        
        [placeDetailsDictionary setValue:detailDataString forKey:@"author_name"];

    }
    else if ([elementName isEqualToString:@"time"]) {
        
        [placeDetailsDictionary setValue:detailDataString forKey:@"time"];
        
    }
    else if ([elementName isEqualToString:@"text"]) {
        
        [placeDetailsDictionary setValue:detailDataString forKey:@"text"];
        
    }
    
    else if([elementName isEqualToString:@"PlaceDetailsResponse"]){
        
        [self.detailsListIndicator stopAnimating];


        [self performSelectorOnMainThread:@selector(updateTableView) withObject:nil waitUntilDone:NO];
        
    }
    
    

    _labelName.text = [placeDetailsDictionary valueForKey:@"name"];
    
    _labelAddress.text = [placeDetailsDictionary valueForKey:@"vicinity"];
    
    _labelContactNo.text = [placeDetailsDictionary valueForKey:@"formatted_phone_number"];
    
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"PARSE ERROR : %@",parseError.localizedDescription);
}



-(void)updateTableView {
    

    [self.tableViewReview reloadData];
    

    
}





- (IBAction)doneAction:(id)sender {

    
}
@end
