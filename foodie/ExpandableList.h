//
//  ExpandableList.h
//  foodie
//
//  Created by Gaurav Menghani on 10/26/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UITableView.h>

@interface ExpandableList : NSObject
- (ExpandableList*)initWithObjects:(NSArray*)options defaultIndex:(NSInteger)defaultIndex tableView:(UITableView*)tableView section:(NSInteger)section;
- (void)collapseWithIndex:(NSInteger)index;
- (void)expand;
- (int)getNumRows;
- (BOOL)isCollapsed;
- (void)handleClick:(NSInteger)index;
@end