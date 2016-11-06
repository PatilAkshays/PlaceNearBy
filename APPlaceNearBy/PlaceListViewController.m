//
//  PlaceListViewController.m
//  APPlaceNearBy
//
//  Created by Mac on 29/07/1938 Saka.
//  Copyright © 1938 Saka Aksh. All rights reserved.
//

#import "PlaceListViewController.h"
#import "CustomListTableViewCell.h"
#import "ViewController.h"
#import "PlaceDetailsViewController.h"



@interface PlaceListViewController ()

@end

@implementation PlaceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // [self startLocating];

    
    placeList = [[NSMutableArray alloc]init];
    
    
    if ([self.selectedPlaceType isEqualToString:@"atm"]) {
        
        self.title = self.selectedPlaceType.uppercaseString;
    }
    else{
        NSString *place = self.selectedPlaceType.capitalizedString;
        
        NSString* placeType = [place stringByReplacingOccurrencesOfString:@"_" withString:@" "];

        
        self.title =placeType;
    }
    
    

    [self getPlaceListWithAPIKey:kGoogleAPIKey placeType:self.selectedPlaceType radius:1000 lattitude:kLatitude longitude:kLongitude];
    
    [self setUp];

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
    
    self.listIndicator.hidesWhenStopped = YES;
    
}

-(void)startLocating {
    
    myLocationManager = [[CLLocationManager alloc]init];
    
    myLocationManager.delegate = self;
    
    [myLocationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [myLocationManager requestWhenInUseAuthorization];
    
    [myLocationManager startUpdatingLocation];
    
    
}



-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *currentLocation = [locations lastObject];
    
    currentLatitude= [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    
    currentLongitude= [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    
    
    if (currentLocation != nil) {
        [myLocationManager stopUpdatingLocation];
        
    }
    
    [self getPlaceListWithAPIKey:kGoogleAPIKey placeType:self.selectedPlaceType radius:1000 lattitude:currentLatitude.floatValue longitude:currentLongitude.floatValue];

}
- (IBAction)refreshAction:(id)sender {
    
    [self startLocating];
}


-(void)getPlaceListWithAPIKey:(NSString *)key
                    placeType:(NSString *)type
                       radius:(int)radius
                    lattitude:(double)latitude
                    longitude:(double)longitude
{
    
    [self.listIndicator startAnimating];

    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/xml?&key=%@&location=%f,%f&radius=%d&types=%@",key,latitude,longitude,radius,type];
    
    
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
                        
                        [self.listIndicator stopAnimating];

                    }
                }
                else {
                    //alert
                    [self.listIndicator stopAnimating];

                }
                
            }
            else {
                //alert
                
                [self.listIndicator stopAnimating];

            }
        }
        
        
    }];

    
    [task resume];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return placeList.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CustomListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomList_Cell"];
    
    
    
      [self.listIndicator stopAnimating];

       NSMutableDictionary *tempDictionary = [placeList objectAtIndex:indexPath.row];
    
        NSLog(@"%@",tempDictionary);
    
        NSString *placeName = [tempDictionary valueForKey:@"name"];
        NSString *address = [tempDictionary valueForKey:@"vicinity"];
        NSString *placeID = [tempDictionary valueForKey:@"place_id"];

    
   
        cell.nameLabel.text = placeName;
    
        cell.nameLabel.textColor = [UIColor blueColor];
    
        cell.nameLabel.font = [UIFont boldSystemFontOfSize:16];
    

        cell.addressLabel.text = address;
    
        cell.addressLabel.textColor = [UIColor darkGrayColor];
    
      cell.addressLabel.font = [UIFont systemFontOfSize:15];

    
        cell.placeIdLabel.text = placeID;
    
  //  cell.placeIdLabel.textColor = [UIColor blackColor];

    
      cell.backgroundColor = [UIColor lightTextColor];
    
    
    return cell;
    
    
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    
    if ([elementName isEqualToString:@"result"]) {
        placeDictionary = [[NSMutableDictionary alloc]init];
    }
    else if ([elementName isEqualToString:@"name"]) {
        dataString = [[NSMutableString alloc]init];
    }
    else if ([elementName isEqualToString:@"vicinity"]) {
        dataString = [[NSMutableString alloc]init];
    }
    else if ([elementName isEqualToString:@"place_id"]) {
        dataString = [[NSMutableString alloc]init];
    }
    else if ([elementName isEqualToString:@"lat"]) {
        dataString = [[NSMutableString alloc]init];
    }

    else if ([elementName isEqualToString:@"lng"]) {
        dataString = [[NSMutableString alloc]init];
    }
    
    else if ([elementName isEqualToString:@"photo_reference"]) {
        dataString = [[NSMutableString alloc]init];
    }
    else if ([elementName isEqualToString:@"width"]) {
        dataString = [[NSMutableString alloc]init];
    }

    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    dataString = string;
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"result"]) {
        
        [placeList addObject:placeDictionary];
        
    }
    else if ([elementName isEqualToString:@"name"]) {
        
        [placeDictionary setValue:dataString forKey:@"name"];
        
    }
    else if ([elementName isEqualToString:@"vicinity"]) {
        
        [placeDictionary setValue:dataString forKey:@"vicinity"];
        
    }
    else if ([elementName isEqualToString:@"place_id"]) {
        
        [placeDictionary setValue:dataString forKey:@"place_id"];
        
    }
    else if ([elementName isEqualToString:@"lat"]) {
        
        [placeDictionary setValue:dataString forKey:@"lat"];
        
    }
    else if ([elementName isEqualToString:@"lng"]) {
        
        [placeDictionary setValue:dataString forKey:@"lng"];
        
    }
    else if ([elementName isEqualToString:@"photo_reference"]) {
        
        [placeDictionary setValue:dataString forKey:@"photo_reference"];
        
    }

    else if ([elementName isEqualToString:@"width"]) {
        
        [placeDictionary setValue:dataString forKey:@"width"];
        
    }

    else if([elementName isEqualToString:@"PlaceSearchResponse"]){
        
        
        [self performSelectorOnMainThread:@selector(updateTableView) withObject:nil waitUntilDone:NO];
        
    }
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"PARSE ERROR : %@",parseError.localizedDescription);
}

-(void)updateTableView {
    
    [self.placeListTableView reloadData];
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    PlaceDetailsViewController *placeDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PlaceDetailsViewController"];

    NSDictionary *placeDic = [placeList objectAtIndex:indexPath.row];

    NSString *place_id = [placeDic valueForKey:@"place_id"];
    
    NSString *latitude = [placeDic valueForKey:@"lat"];
    NSString *longitude = [placeDic valueForKey:@"lng"];
    NSString *photoReference = [placeDic valueForKey:@"photo_reference"];
    NSString *width = [placeDic valueForKey:@"width"];



    placeDetailViewController.selectedPlaceID = place_id;
    placeDetailViewController.selectedPlaceLat = latitude;
    placeDetailViewController.selectedPlaceLng = longitude;
    placeDetailViewController.selectedPhotoReference = photoReference;
    placeDetailViewController.selectedPhotoWidth = width;

    

    [self.navigationController pushViewController:placeDetailViewController animated:YES];

}



@end
