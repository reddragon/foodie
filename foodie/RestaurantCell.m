//
//  RestaurantCell.m
//  foodie
//
//  Created by Gaurav Menghani on 10/21/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import "RestaurantCell.h"
#import "UIImageView+AFNetworking.h"

@implementation RestaurantCell

- (void)initWithResponseDict:(NSDictionary *)dictionary index:(NSInteger)index {
    [self.restaurantName setText:[NSString stringWithFormat:@"%ld. %@", index + 1, dictionary[@"name"]]];
    [self.rating setImageWithURL:[NSURL URLWithString:dictionary[@"rating_img_url"]]];
    [self.restImage setImageWithURL:[NSURL URLWithString:dictionary[@"image_url"]]];
    [self.restImage.layer setCornerRadius:10.0];
    [self.restImage.layer setMasksToBounds:YES];
    
    [self.numReviews setText:[NSString stringWithFormat:@"%@ reviews", dictionary[@"review_count"]]];
    [self.address setText:dictionary[@"location"][@"address"][0]];
    // TODO
    // Set cuisine and distance
    // Randomize setting the dollar rating
    [self.dollarRating setText:@"$$"];
    // [rcell.distance setText:<#(NSString *)#>]
}

- (void)awakeFromNib {
    // Initialization code
    self.restaurantName.preferredMaxLayoutWidth = self.restaurantName.frame.size.width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
