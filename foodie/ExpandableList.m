//
//  ExpandableList.m
//  foodie
//
//  Created by Gaurav Menghani on 10/26/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import "ExpandableList.h"
#import "ExpandingCell.h"
#import "FilterViewController.h"
#import <UIKit/UIKit.h>

@interface ExpandableList()
@property (strong, nonatomic) NSArray* options;
@property (weak, nonatomic) UITableView* tableView;
@property NSInteger section;
@property NSInteger selectedOptionIndex;
@property bool collapsed;
@property NSInteger numRows;
@property NSString* propName;
@property FilterViewController* fvc;
@end

@implementation ExpandableList

- (ExpandableList*)initWithObjects:(NSArray*)options defaultIndex:(NSInteger)defaultIndex tableView:(UITableView*)tableView section:(NSInteger)section propName:(NSString*)propName fvc:(FilterViewController*)fvc {
    self.options = options;
    self.selectedOptionIndex = defaultIndex;
    self.numRows = 1;
    self.collapsed = YES;
    self.tableView = tableView;
    self.section = section;
    self.propName = propName;
    self.fvc = fvc;
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
        [self.tableView insertRowsAtIndexPaths:collapsedRow withRowAnimation:NO];
        
    } else {
        NSLog(@"Beware! Tried collapsing expandableList for section %ld, which was already collapsed.", (long)self.section);
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
        [self.tableView deleteRowsAtIndexPaths:collapsedRow withRowAnimation:NO];
        
        NSMutableArray* indexPaths = [[NSMutableArray alloc] initWithCapacity:self.options.count];
        for (NSInteger i = 0; i < self.options.count; i++) {
            NSLog(@"Going to insert %ld", (long)i);
            [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:self.section]];
        }
        NSLog(@"Size of indexPaths: %lu", (unsigned long)indexPaths.count);
        self.numRows = self.options.count;
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
    } else {
        NSLog(@"Beware! Tried expanding expandableList for section %ld, which was already expanded.", (long)self.section);
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
            NSLog(@"Warning! Tried to access a non-zero cell (%ld) for a collapsed section %ld", (long)index, (long)self.section);
        }
        ExpandingCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"ExpandingCell"];
        [cell.cellLabel setText:[self.options objectAtIndex:self.selectedOptionIndex]];
        cell.cellSwitch.hidden = YES;
        return cell;
    } else {
        ExpandingCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"ExpandingCell"];
        cell.cellSwitch.hidden = NO;
        [cell initWithOptions:index isOn:(index == self.selectedOptionIndex) delegate:self];
        [cell.cellLabel setText:[self.options objectAtIndex:index]];
        return cell;
    }
}

- (void)onSwitch:(ExpandingCell *)cell {
    self.selectedOptionIndex = cell.row;
    [self collapseWithIndex:cell.row];
    NSString* value = [self.options objectAtIndex:self.selectedOptionIndex];
    [self.fvc invokePropertyChange:self.propName value:value];
    // [self.fvc ]
}
@end
