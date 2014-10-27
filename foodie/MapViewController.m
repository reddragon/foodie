//
//  MapViewController.m
//  foodie
//
//  Created by Gaurav Menghani on 10/27/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

#define METERS_PER_MILE 1609.344

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 37.774866;
    zoomLocation.longitude= -122.394556;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, METERS_PER_MILE, METERS_PER_MILE);
    
    [self.mapView setRegion:viewRegion animated:YES];
    
    NSLog(@"Restaurant count: %d", self.restaurants.count);
    for (NSDictionary* r in self.restaurants) {
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D location;
        location.latitude = [r[@"location"][@"coordinate"][@"latitude"] floatValue];
        location.longitude = [r[@"location"][@"coordinate"][@"longitude"] floatValue];
        
        point.coordinate = location;
        point.title = r[@"name"];
        
        float distance = [r[@"distance"] floatValue] / (1600.0);
        NSString* str = [NSString stringWithFormat:@"%.2f mi away", distance];
        point.subtitle = str;
    
        [self.mapView addAnnotation:point];
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

@end
