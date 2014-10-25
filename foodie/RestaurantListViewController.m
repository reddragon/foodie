//
//  RestaurantListViewController.m
//  foodie
//
//  Created by Gaurav Menghani on 10/21/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import "RestaurantListViewController.h"
#import "RestaurantCell.h"
#import "YelpClient.h"

@interface RestaurantListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *restTable;
@property (strong, nonatomic) NSArray* restaurants;

@end

@implementation RestaurantListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.restTable.dataSource = self;
    self.restTable.delegate = self;
    self.restTable.rowHeight = 120;
    
    [self.restTable registerNib:[UINib nibWithNibName:@"RestaurantCell" bundle:nil] forCellReuseIdentifier:@"RestaurantCell"];
    
    YelpClient* client = [[YelpClient alloc] initWithConsumerKey:@"LV-f5dSnKJkfJBP8aPJSnQ" consumerSecret:@"P9iLZ-Mk4dtmWlvK1DxqxTo2xps" accessToken:@"j3uvzAZdLnTHu7hrE8uWdnk9b5E0eBLs" accessSecret:@"1CTX2Kn0ldmG4V1wxErO554K2HY"];
    [client searchWithTerm:@"thai" success:^(AFHTTPRequestOperation *operation, id response) {
        NSDictionary* dict = response;
        self.restaurants = dict[@"businesses"];
        NSLog(@"Successful, response: %@", self.restaurants);
        [self.restTable reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed, response: %@", error);
    }];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.restaurants.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantCell* rcell = [self.restTable dequeueReusableCellWithIdentifier:@"RestaurantCell"];
    rcell.restaurantName.text = self.restaurants[indexPath.row][@"name"];
    return rcell;
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
