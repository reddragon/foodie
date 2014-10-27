//
//  MapViewController.h
//  foodie
//
//  Created by Gaurav Menghani on 10/27/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSArray* restaurants;

@end
