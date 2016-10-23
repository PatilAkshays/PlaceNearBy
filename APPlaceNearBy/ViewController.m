//
//  ViewController.m
//  APPlaceNearBy
//
//  Created by Mac on 29/07/1938 Saka.
//  Copyright © 1938 Saka Aksh. All rights reserved.
//

#import "ViewController.h"
#import "PlaceListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    placeTypes = @[@"accounting",
                   @"airport",
                   @"amusement_park",
                   @"aquarium",
                   @"art_gallery",
                   @"atm",
                   @"bakery",
                   @"bank",
                   @"bar",
                   @"beauty_salon",
                   @"bicycle_store",
                   @"book_store",
                   @"bowling_alley",
                   @"bus_station",
                   @"cafe",
                   @"campground",
                   @"car_dealer",
                   @"car_rental",
                   @"car_repair",
                   @"car_wash",
                   @"casino",
                   @"cemetery",
                   @"church",
                   @"city_hall",
                   @"clothing_store",
                   @"convenience_store",
                   @"courthouse",
                   @"centist",
                   @"department_store",
                   @"doctor",
                   @"electrician",
                   @"electronics_store",
                   @"embassy",
                   @"establishment (deprecated)",
                   @"finance (deprecated)",
                   @"fire_station",
                   @"florist",
                   @"food (deprecated)",
                   @"funeral_home",
                   @"furniture_store",
                   @"gas_station",
                   @"general_contractor (deprecated)",
                   @"grocery_or_supermarket (deprecated)",
                   @"gym",
                   @"hair_care",
                   @"hardware_store",
                   @"health (deprecated)",
                   @"hindu_temple",
                   @"home_goods_store",
                   @"hospital",
                   @"insurance_agency",
                   @"jewelry_store",
                   @"laundry",
                   @"lawyer",
                   @"library",
                   @"liquor_store",
                   @"local_government_office",
                   @"locksmith",
                   @"lodging",
                   @"meal_delivery",
                   @"meal_takeaway",
                   @"mosque",
                   @"movie_rental",
                   @"movie_theater",
                   @"moving_company",
                   @"museum",
                   @"night_club",
                   @"painter",
                   @"park",
                   @"parking",
                   @"pet_store",
                   @"pharmacy",
                   @"physiotherapist",
                   @"place_of_worship (deprecated)",
                   @"plumber",
                   @"police",
                   @"post_office",
                   @"real_estate_agency",
                   @"restaurant",
                   @"roofing_contractor",
                   @"rv_park",
                   @"school",
                   @"shoe_store",
                   @"shopping_mall",
                   @"spa",
                   @"stadium",
                   @"storage",
                   @"store",
                   @"subway_station",
                   @"synagogue",
                   @"taxi_stand",
                   @"train_station",
                   @"transit_station",
                   @"travel_agency",
                   @"university",
                   @"veterinary_care",
                   @"zoo"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return placeTypes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    
    cell.textLabel.text = [placeTypes objectAtIndex:indexPath.row];
    
    cell.textLabel.textColor = [UIColor blackColor];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    
    cell.backgroundColor = [UIColor lightTextColor];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *placeType = [placeTypes objectAtIndex:indexPath.row];

    PlaceListViewController *placeListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PlaceListViewController"];
    
    placeListViewController.selectedPlaceType = placeType;

  
    [self.navigationController pushViewController:placeListViewController animated:YES];
    
}


@end
