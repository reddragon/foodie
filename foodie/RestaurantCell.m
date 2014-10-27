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
    [self.restImage.layer setCornerRadius:5.0];
    [self.restImage.layer setMasksToBounds:YES];
    
    [self.numReviews setText:[NSString stringWithFormat:@"%@ reviews", dictionary[@"review_count"]]];
    
    NSArray* locArray = dictionary[@"location"][@"address"];
    if (locArray.count == 0) {
        [self.address setText:@"Address Unknown"];
    } else {
      [self.address setText:dictionary[@"location"][@"address"][0]];
    }
    
    NSMutableArray* categories = [[NSMutableArray alloc] initWithCapacity:20];
    for (NSArray* category in dictionary[@"categories"]) {
        [categories addObject:category[0]];
    }
    NSString* category = [categories componentsJoinedByString:@", "];
    [self.category setText:category];
    
    float distance = [dictionary[@"distance"] floatValue] / (1600.0);
    NSString* str = [NSString stringWithFormat:@"%.2f mi", distance];
    [self.distance setText:str];
    
    // Randomize setting the dollar rating
    srand48([dictionary[@"review_count"] integerValue]);
    double dr = drand48();
    int rating = 0;
    if (dr <= 0.5) {
        rating = 1;
    } else if (dr <= 0.75) {
        rating = 2;
    } else if (dr <= 0.95) {
        rating = 3;
    } else {
        rating = 4;
    }
    
    NSMutableString* rstr = [[NSMutableString alloc] initWithString:@""];
    for (int i = 1; i <= rating; i++) {
        [rstr appendFormat:@"$"];
    }
    [self.dollarRating setText:rstr];
    // [rcell.distance setText:<#(NSString *)#>]
}

- (void)awakeFromNib {
    // Initialization code
    self.restaurantName.preferredMaxLayoutWidth = self.restaurantName.frame.size.width;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.restaurantName.preferredMaxLayoutWidth = self.restaurantName.frame.size.width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
