//
//  SettingsTableViewController.m
//  Greebler
//
//  Created by Adrian on 10/4/15.
//  Copyright © 2015 Adrian Secord. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController ()
@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Test"];
    cell.textLabel.text = [NSString stringWithFormat:@"Row %i", (int)indexPath.row];
    return cell;
}

@end
