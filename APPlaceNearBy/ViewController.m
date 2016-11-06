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
    self.title = [NSString stringWithFormat:@"SEARCH PLACES"];
    
    placeTypes = @[@"Accounting",
                   @"Airport",
                   @"Amusement Park",
                   @"Aquarium",
                   @"Art Gallery",
                   @"Atm",
                   @"Bakery",
                   @"Bank",
                   @"Bar",
                   @"Beauty Salon",
                   @"Bicycle Store",
                   @"Book Store",
                   @"Bowling Alley",
                   @"Bus Station",
                   @"Cafe",
                   @"Campground",
                   @"Car Dealer",
                   @"Car Rental",
                   @"Car Repair",
                   @"Car Wash",
                   @"Casino",
                   @"Cemetery",
                   @"Church",
                   @"City Hall",
                   @"Clothing Store",
                   @"Convenience Store",
                   @"Courthouse",
                   @"Dentist",
                   @"Department Store",
                   @"Doctor",
                   @"Electrician",
                   @"Electronics Store",
                   @"Embassy",
                   @"Establishment (deprecated)",
                   @"Finance (deprecated)",
                   @"Fire Station",
                   @"Florist",
                   @"Food (deprecated)",
                   @"Funeral Home",
                   @"Furniture Store",
                   @"Gas Station",
                   @"General Contractor (deprecated)",
                   @"Grocery or Supermarket (deprecated)",
                   @"Gym",
                   @"Hair Care",
                   @"Hardware Store",
                   @"Health (deprecated)",
                   @"Hindu Temple",
                   @"Home Goods Store",
                   @"Hospital",
                   @"Insurance Agency",
                   @"Jewelry Store",
                   @"Laundry",
                   @"Lawyer",
                   @"Library",
                   @"Liquor Store",
                   @"Local Government Office",
                   @"Locksmith",
                   @"Lodging",
                   @"Meal Delivery",
                   @"Meal Takeaway",
                   @"Mosque",
                   @"Movie Rental",
                   @"Movie Theater",
                   @"Moving Company",
                   @"Museum",
                   @"Night Club",
                   @"Painter",
                   @"Park",
                   @"Parking",
                   @"Pet Store",
                   @"Pharmacy",
                   @"Physiotherapist",
                   @"Place of Worship (deprecated)",
                   @"Plumber",
                   @"Police",
                   @"Post Office",
                   @"Real Estate Agency",
                   @"Restaurant",
                   @"Roofing Contractor",
                   @"Rv Park",
                   @"School",
                   @"Shoe Store",
                   @"Shopping Mall",
                   @"Spa",
                   @"Stadium",
                   @"Storage",
                   @"Store",
                   @"Subway Station",
                   @"Synagogue",
                   @"Taxi Stand",
                   @"Train Station",
                   @"Transit Station",
                   @"Travel Agency",
                   @"University",
                   @"Veterinary Care",
                   @"Zoo"];

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
    
    NSString *place = [placeTypes objectAtIndex:indexPath.row];
    
    NSString* placeType = [place stringByReplacingOccurrencesOfString:@" " withString:@"_"];


    PlaceListViewController *placeListViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PlaceListViewController"];
    
        
    placeListViewController.selectedPlaceType = placeType.lowercaseString;

  
    [self.navigationController pushViewController:placeListViewController animated:YES];
    
}


@end
