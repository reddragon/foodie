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
#include "FilterViewController.h"
#include "MapViewController.h"
#include "SVProgressHUD.h"

NSString* const consumerKey = @"LV-f5dSnKJkfJBP8aPJSnQ";
NSString* const consumerSecret = @"P9iLZ-Mk4dtmWlvK1DxqxTo2xps";
NSString* const accessToken = @"j3uvzAZdLnTHu7hrE8uWdnk9b5E0eBLs";
NSString* const accessSecret = @"1CTX2Kn0ldmG4V1wxErO554K2HY";


@interface RestaurantListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *restTable;
@property (strong, nonatomic) NSArray* restaurants;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) UISearchBar* searchBar;
@property (strong, nonatomic) NSString* tempSearchTerm;
@property (strong, nonatomic) NSString* searchTerm;
@property (strong, nonatomic) RestaurantCell* prototypeCell;
@property (strong, nonatomic) NSMutableDictionary* filterDict;
@property bool requiresReload;

@end

@implementation RestaurantListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.requiresReload = YES;
    // Setting up the table and registering the nib
    self.restTable.dataSource = self;
    self.restTable.delegate = self;
    self.restTable.rowHeight = UITableViewAutomaticDimension;
    [self.restTable registerNib:[UINib nibWithNibName:@"RestaurantCell" bundle:nil] forCellReuseIdentifier:@"RestaurantCell"];

    
    // Set up the navbar.
    // self.navigationController.navigationBar = self.navBar;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:175.0/255.0 green:6.0/255.0 blue:6.0/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setBarStyle:UIStatusBarStyleLightContent];
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    //[self.navigationController.tit]
    
    UIBarButtonItem* filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(onPressFilterButton)];
    filterButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = filterButton;
    
    UIBarButtonItem* mapButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(onPressMapButton)];
    mapButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = mapButton;
    
    self.searchTerm = @"";
    self.filterDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"0", @"sort", @"", @"category_filter", @"", @"radius_filter", nil];
    [self searchWithTerm:self.searchTerm];
}

- (void)onPressMapButton {
    MapViewController* mvc = [[MapViewController alloc] init];
    mvc.restaurants = self.restaurants;
    [self.navigationController pushViewController:mvc animated:YES];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.tempSearchTerm = searchText;
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.searchTerm = self.tempSearchTerm;
    [self searchWithTerm:self.searchTerm];
}

- (void)searchWithTerm:(NSString*)term {
    self.requiresReload = NO;
    // Querying the client
    [SVProgressHUD show];
    YelpClient* client = [[YelpClient alloc] initWithConsumerKey:consumerKey consumerSecret:consumerSecret accessToken:accessToken accessSecret:accessSecret filterDict:self.filterDict];
    [client searchWithTerm:term success:^(AFHTTPRequestOperation *operation, id response) {
        [SVProgressHUD dismiss];
        NSDictionary* dict = response;
        self.restaurants = dict[@"businesses"];
        [self.restTable reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"Failed, response: %@", error);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.requiresReload) {
        [self searchWithTerm:self.searchTerm];
    }
}

- (void)onPressFilterButton {
    FilterViewController* fvc = [[FilterViewController alloc] init];
    fvc.delegate = self;
    [self.navigationController pushViewController:fvc animated:YES];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

- (RestaurantCell *)prototypeCell {
    if (_prototypeCell == nil) {
        _prototypeCell = [self.restTable dequeueReusableCellWithIdentifier:@"RestaurantCell"];
    }
    
    return _prototypeCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // self.prototypeCell.business = self.restaurants[indexPath.row];
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}

- (void)changedProperty:(NSString *)property value:(NSString *)value {
    self.requiresReload = YES;
    NSString* sanitizedVal;
    if ([property isEqualToString:@"sort"]) {
        sanitizedVal = value;
    } else if ([property isEqualToString:@"category_filter"]) {
        if ([value isEqualToString:@"All"]) {
            sanitizedVal = @"";
        } else {
            sanitizedVal = [value lowercaseString];
        }
    } else if ([property isEqualToString:@"radius_filter"]) {
        if ([value isEqualToString:@"Auto"]) {
            sanitizedVal = @"";
        } else {
            NSArray* words = [value componentsSeparatedByString:@" "];
            int meters =  (int)(1600.0 * [words[0] floatValue]);
            sanitizedVal = [NSString stringWithFormat:@"%d", meters];
        }
    }
    NSLog(@"Changed property %@ with value %@", property, sanitizedVal);
    self.filterDict[property] = sanitizedVal;
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
