//
//  FilterViewController.m
//  foodie
//
//  Created by Gaurav Menghani on 10/25/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()
@property (strong, nonatomic) NSArray* filterHeaders;
@property (strong, nonatomic) NSMutableArray* filterRows;
@property (strong, nonatomic) NSMutableArray* isFiltered;

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.filterTable.delegate = self;
    self.filterTable.dataSource = self;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.filterHeaders = [[NSArray alloc] initWithObjects:@"Sort By", @"Radius", @"Categories", nil];
    self.filterRows = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
    self.isFiltered = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithBool:YES], [NSNumber numberWithBool:YES], [NSNumber numberWithBool:YES], nil];
    [self.filterTable registerNib:[UINib nibWithNibName:@"SortByCell" bundle:nil] forCellReuseIdentifier:@"SortByCell"];
    [self.filterTable registerNib:[UINib nibWithNibName:@"ExpandingCell" bundle:nil] forCellReuseIdentifier:@"ExpandingCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.filterTable deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        NSLog(@"Accessed section 1");
        if ([self.isFiltered[indexPath.section] boolValue]) {
            NSLog(@"In filtered section");
            self.isFiltered[indexPath.section] = [NSNumber numberWithBool:NO];
            NSInteger row = 1;
            NSMutableArray* indexPaths = [[NSMutableArray alloc] initWithObjects:[NSIndexPath indexPathForItem:row inSection:indexPath.section], nil];
            self.filterRows[indexPath.section] = [NSNumber numberWithInt:2];
            [self.filterTable insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
        } else {
            NSLog(@"In non filtered section");
            self.isFiltered[indexPath.section] = [NSNumber numberWithBool:YES];
            NSInteger row = 1;
            NSMutableArray* indexPaths = [[NSMutableArray alloc] initWithObjects:[NSIndexPath indexPathForItem:row inSection:indexPath.section], nil];
            self.filterRows[indexPath.section] = [NSNumber numberWithInt:1];
            [self.filterTable deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            
        }
        // [self.filterTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:YES];
    } else if (indexPath.section == 2) {
        self.filterRows[indexPath.section] = [NSNumber numberWithInt:2];
        NSInteger row = 1;
        NSMutableArray* indexPaths = [[NSMutableArray alloc] initWithObjects:[NSIndexPath indexPathForItem:row inSection:indexPath.section], nil];
        [self.filterTable insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        // [self.filterTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:YES];
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.filterHeaders[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Number of rows in section %d are %d", section, [self.filterRows[section] intValue]);
    return [self.filterRows[section] intValue];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.filterHeaders[indexPath.section] isEqual:@"Sort By"]) {
        return [self.filterTable dequeueReusableCellWithIdentifier:@"SortByCell"];
    } else if ([self.filterHeaders[indexPath.section] isEqual:@"Radius"]) {
        return [self.filterTable dequeueReusableCellWithIdentifier:@"ExpandingCell"];
    }
    UITableViewCell* tvc = [[UITableViewCell alloc] init];
    return tvc;
    // return nil;
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
