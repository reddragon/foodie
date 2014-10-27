//
//  RestaurantCell.h
//  foodie
//
//  Created by Gaurav Menghani on 10/21/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UIImageView *restImage;
@property (weak, nonatomic) IBOutlet UIImageView *rating;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *numReviews;
@property (weak, nonatomic) IBOutlet UILabel *dollarRating;
@property (weak, nonatomic) IBOutlet UILabel *category;

- (void) initWithResponseDict:(NSDictionary*)dictionary index:(NSInteger)index;

@end
