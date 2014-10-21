//
//  RestaurantListViewController.m
//  foodie
//
//  Created by Gaurav Menghani on 10/21/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import "RestaurantListViewController.h"
#import "RestaurantCell.h"

@interface RestaurantListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *restTable;

@end

@implementation RestaurantListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.restTable.dataSource = self;
    self.restTable.delegate = self;
    self.restTable.rowHeight = 120;
    
    [self.restTable registerNib:[UINib nibWithNibName:@"RestaurantCell" bundle:nil] forCellReuseIdentifier:@"RestaurantCell"];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantCell* rcell = [self.restTable dequeueReusableCellWithIdentifier:@"RestaurantCell"];
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
