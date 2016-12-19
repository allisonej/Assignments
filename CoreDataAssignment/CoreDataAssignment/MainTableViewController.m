//
//  RootTableViewController.m
//  CoreData
//
//  Created by SWUComputer on 2016. 11. 7..
//  Copyright © 2016년 SWUComputer. All rights reserved.
//

#import "MainTableViewController.h"
#import <CoreData/CoreData.h>

@interface MainTableViewController ()

@end

@implementation MainTableViewController

@synthesize ideas;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

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
    return [ideas count];
}

// managed object context를 조회하거나 나중에 자료를 저장하기 위한 다양한 용도에 쓰임
- (NSManagedObjectContext *) managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    return context;
}

// View가 보여질 때 자료를 DB에서 가져오도록 한다
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // here we get the friends from the persistent data store (or the database)
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Idea"];//모든 정보를 요청
    
    // Edit the sort key as appropriate. 정렬
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"ideaDate" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    ideas = [[moc executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.tableView reloadData];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Idea Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSManagedObject *idea = [ideas objectAtIndex:indexPath.row];
    
    // 영국 GMT 기준의 시간
    // saveDate.text = [detailFriend valueForKey:@"saveDate"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd h:mm:ss a"];
    // 현재 지역의 기준 시간
    NSString *dateFormat = [formatter stringFromDate:[idea valueForKey:@"ideaDate"]];

    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",dateFormat]];
    [cell.detailTextLabel setText:[idea valueForKey:@"ideaTitle"]];
    return cell;
}

//delete
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self managedObjectContext];
        [context deleteObject:[ideas objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        
        if (![context save:&error]) {
            NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
        }
        
        // Remove friend from table view
        [ideas removeObjectAtIndex:indexPath.row];
        
        // [NSArray arrayWithObject:indexPath] equals @[indexPath] [tableView deleteRowsAtIndexPaths:@[indexPath]
    }
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

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
