//
//  ExpandableList.m
//  foodie
//
//  Created by Gaurav Menghani on 10/26/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import "ExpandableList.h"
#import "ExpandingCell.h"
#import <UIKit/UIKit.h>

@interface ExpandableList()
@property (strong, nonatomic) NSArray* options;
@property (weak, nonatomic) UITableView* tableView;
@property NSInteger section;
@property NSInteger selectedOptionIndex;
@property bool collapsed;
@property NSInteger numRows;
@end

@implementation ExpandableList

- (ExpandableList*)initWithObjects:(NSArray*)options defaultIndex:(NSInteger)defaultIndex tableView:(UITableView*)tableView section:(NSInteger)section {
    self.options = options;
    self.selectedOptionIndex = defaultIndex;
    self.numRows = 1;
    self.collapsed = YES;
    self.tableView = tableView;
    self.section = section;
    return self;
}

- (void)collapseWithIndex:(NSInteger)index {
    if (self.collapsed == NO) {
        self.numRows = 1;
        self.collapsed = YES;
        self.selectedOptionIndex = index;
        NSMutableArray* indexPaths = [[NSMutableArray alloc] initWithCapacity:self.options.count];
        for (NSInteger i = 0; i < self.options.count; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:self.section]];
        }
        self.numRows = 0;
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
        
        NSMutableArray* collapsedRow = [[NSMutableArray alloc] initWithCapacity:1];
        [collapsedRow addObject:[NSIndexPath indexPathForItem:0 inSection:self.section]];
        self.numRows = 1;
        [self.tableView insertRowsAtIndexPaths:collapsedRow withRowAnimation:UITableViewRowAnimationBottom];
        
    } else {
        NSLog(@"Beware! Tried collapsing expandableList for section %d, which was already collapsed.", self.section);
    }
}

- (void)expand {
    if (self.collapsed == YES) {
        NSLog(@"In expand!");
        self.numRows = self.options.count;
        self.collapsed = NO;
        
        NSMutableArray* collapsedRow = [[NSMutableArray alloc] initWithCapacity:1];
        [collapsedRow addObject:[NSIndexPath indexPathForItem:0 inSection:self.section]];
        self.numRows = 0;
        [self.tableView deleteRowsAtIndexPaths:collapsedRow withRowAnimation:UITableViewRowAnimationBottom];
        
        NSMutableArray* indexPaths = [[NSMutableArray alloc] initWithCapacity:self.options.count];
        for (NSInteger i = 0; i < self.options.count; i++) {
            NSLog(@"Going to insert %d", i);
            [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:self.section]];
        }
        NSLog(@"Size of indexPaths: %d", indexPaths.count);
        self.numRows = self.options.count;
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
    } else {
        NSLog(@"Beware! Tried expanding expandableList for section %d, which was already expanded.", self.section);
    }
}

- (void)handleClick:(NSInteger)index {
    if (self.collapsed ) {
        [self expand];
    } else {
        [self collapseWithIndex:index];
    }
}

- (int) getNumRows {
    return self.numRows;
}

- (BOOL)isCollapsed {
    return self.collapsed;
}

- (UITableViewCell*)cellForIndex:(NSInteger)index {
    if (self.collapsed) {
        if (index != 0) {
            NSLog(@"Warning! Tried to access a non-zero cell (%d) for a collapsed section %d", index, self.section);
        }
        ExpandingCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"ExpandingCell"];
        [cell.cellLabel setText:[self.options objectAtIndex:index]];
        cell.cellSwitch.hidden = YES;
        return cell;
    } else {
        ExpandingCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"ExpandingCell"];
        [cell initWithOptions:index isOn:(index == self.selectedOptionIndex) delegate:self];
        [cell.cellLabel setText:[self.options objectAtIndex:index]];
        return cell;
    }
}

- (void)onSwitch:(ExpandingCell *)cell {
    NSLog(@"I was just informed that switch at row: %d was changed", cell.row);
    self.selectedOptionIndex = cell.row;
    NSIndexSet* indexSet = [[NSIndexSet alloc] initWithIndex:self.section];
    [self.tableView reloadSections:indexSet withRowAnimation:NO];
}
@end
