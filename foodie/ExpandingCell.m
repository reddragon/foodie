//
//  ExpandingCell.m
//  foodie
//
//  Created by Gaurav Menghani on 10/26/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import "ExpandingCell.h"

@implementation ExpandingCell


- (IBAction)onSwitchValueChanged:(id)sender {
    NSLog(@"Switch in row %ld was pressed", (long)self.row);
    if (self.delegate != nil) {
        NSLog(@"Calling delegate");
        [self.delegate onSwitch:self];
    } else {
        NSLog(@"Delegate was nil");
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithOptions:(NSInteger)row isOn:(BOOL)isOn delegate:(id)delegate {
    self.row = row;
    self.delegate = delegate;
    [self.cellSwitch setOn:isOn];
}

@end
