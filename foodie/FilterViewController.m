//
//  FilterViewController.m
//  foodie
//
//  Created by Gaurav Menghani on 10/25/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import "FilterViewController.h"
#include "ExpandableList.h"

@interface FilterViewController ()
@property (strong, nonatomic) NSArray* filterHeaders;
@property (strong, nonatomic) NSMutableArray* filterRows;
@property (strong, nonatomic) NSMutableArray* isFiltered;
@property NSMutableDictionary* dict;

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.filterTable.delegate = self;
    self.filterTable.dataSource = self;
    self.filterTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    self.dict = [[NSMutableDictionary alloc] initWithCapacity:3];
    [self.dict setValue:[[ExpandableList alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"Auto", @"0.3 miles", @"1 mile", @"5 miles", @"20 miles", nil] defaultIndex:1 tableView:self.filterTable section:1] forKey:@"1"];
    [self.dict setValue:[[ExpandableList alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"All", @"Chinese", @"Fusion", @"Thai", nil] defaultIndex:0 tableView:self.filterTable section:2] forKey:@"2"];

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
    if (indexPath.section != 0) {
        ExpandableList* el = self.dict[[@(indexPath.section) stringValue]];
        [el handleClick:indexPath.row];
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.filterHeaders[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section != 0) {
        ExpandableList* el = self.dict[[@(section) stringValue]];
        NSLog(@"Number of rows in special section %ld are %d", (long)section, [el getNumRows]);
        return [el getNumRows];
    }
    NSLog(@"Number of rows in section %ld are %d", (long)section, [self.filterRows[section] intValue]);
    return [self.filterRows[section] intValue];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self.filterTable dequeueReusableCellWithIdentifier:@"SortByCell"];
    } else {
        ExpandableList* el = self.dict[[@(indexPath.section) stringValue]];
        return [el cellForIndex:indexPath.row];
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
