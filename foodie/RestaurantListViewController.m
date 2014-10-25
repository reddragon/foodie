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
#import "UIImageView+AFNetworking.h"

@interface RestaurantListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *restTable;
@property (strong, nonatomic) NSArray* restaurants;

@end

@implementation RestaurantListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Setting up the table and registering the nib
    self.restTable.dataSource = self;
    self.restTable.delegate = self;
    self.restTable.rowHeight = UITableViewAutomaticDimension;
    [self.restTable registerNib:[UINib nibWithNibName:@"RestaurantCell" bundle:nil] forCellReuseIdentifier:@"RestaurantCell"];
    
    // Set up the navbar.
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:175.0/255.0 green:6.0/255.0 blue:6.0/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setBarStyle:UIStatusBarStyleLightContent];
    // [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:1.0]];
    // [UINavigationBar a]
    // [self.navigationController.navigationBar setAlpha:1.0];
    
    // Querying the client
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
    // TODO
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.restaurants.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantCell* rcell = [self.restTable dequeueReusableCellWithIdentifier:@"RestaurantCell"];
    NSDictionary* rest = self.restaurants[indexPath.row];
    [rcell initWithResponseDict:rest index:indexPath.row];
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
