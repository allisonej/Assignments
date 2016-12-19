//
//  ThirdViewController.m
//  TabBarAssignment
//
//  Created by SWUComputer on 2016. 11. 14..
//  Copyright © 2016년 SWUComputer. All rights reserved.
//

#import "ThirdViewController.h"
#import "AppDelegate.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

@synthesize martiniTab;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.contentInset =
    UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    return [delegate.martini count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Martini Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    cell.textLabel.text = [delegate.martini objectAtIndex:indexPath.row];

    
    return cell;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

#ifdef __IPHONE_8_0
- (BOOL) checkNotificationType:(UIUserNotificationType)type { UIUserNotificationSettings *currentSettings = [[UIApplication sharedApplication]
                                                                                                             currentUserNotificationSettings]; return (currentSettings.types & type);
}
#endif
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
- (void) setApplicationBadgeNumber:(NSInteger)badgeNumber { UIApplication *application = [UIApplication sharedApplication];
#ifdef __IPHONE_8_0
    // compile with Xcode 6 or higher (iOS SDK >= 8.0)
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        application.applicationIconBadgeNumber = badgeNumber; }
    else {
        if ([self checkNotificationType:UIUserNotificationTypeBadge]) {
            application.applicationIconBadgeNumber = badgeNumber; }
    }
#else
    // compile with Xcode 5 (iOS SDK < 8.0)
    application.applicationIconBadgeNumber = badgeNumber;
#endif
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        [delegate.martini removeObjectAtIndex: indexPath.row];
        martiniTab.badgeValue = [NSString stringWithFormat:@"%d", [delegate.martini count]];
        [self setApplicationBadgeNumber: [delegate.martini count]];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
