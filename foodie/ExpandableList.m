//
//  ExpandableList.m
//  foodie
//
//  Created by Gaurav Menghani on 10/26/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import "ExpandableList.h"
#import <UIKit/UIKit.h>

@interface ExpandableList()
@property (strong, nonatomic) NSArray* options;
@property (weak, nonatomic) UITableView* tableView;
@property NSInteger section;
@property NSInteger selectedIndex;
@property bool collapsed;
@property NSInteger numRows;
@end

@implementation ExpandableList

- (ExpandableList*)initWithObjects:(NSArray*)options defaultIndex:(NSInteger)defaultIndex tableView:(UITableView*)tableView section:(NSInteger)section {
    self.options = options;
    self.selectedIndex = defaultIndex;
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
        self.selectedIndex = index;
        NSMutableArray* indexPaths = [[NSMutableArray alloc] initWithCapacity:self.options.count];
        for (NSInteger i = 1; i < self.options.count; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:self.section]];
        }
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
    } else {
        NSLog(@"Beware! Tried collapsing expandableList for section %d, which was already collapsed.", self.section);
    }
}

- (void)expand {
    if (self.collapsed == YES) {
        self.numRows = self.options.count;
        self.collapsed = NO;
        
        NSMutableArray* indexPaths = [[NSMutableArray alloc] initWithCapacity:self.options.count];
        for (NSInteger i = 1; i < self.options.count; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:self.section]];
        }
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
@end
