//
//  FilterViewController.h
//  foodie
//
//  Created by Gaurav Menghani on 10/25/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterViewController;

@protocol FilterProtocol <NSObject>

- (void)changedProperty:(NSString*)property value:(NSString*)value;

@end

@interface FilterViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *filterTable;
@property (nonatomic, assign) id delegate;
- (void)invokePropertyChange:(NSString*)property value:(NSString*)value;
@end
