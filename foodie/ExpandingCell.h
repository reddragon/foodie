//
//  ExpandingCell.h
//  foodie
//
//  Created by Gaurav Menghani on 10/26/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExpandingCell;

@protocol ExpandingCellDelegate
- (void)onSwitch:(ExpandingCell*)cell;
@end

@interface ExpandingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *cellSwitch;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (nonatomic, weak) id delegate;
@property NSInteger row;
- (void)initWithOptions:(NSInteger)row isOn:(BOOL)isOn delegate:(id)delegate;
@end
