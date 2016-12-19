//
//  SaveViewController.m
//  CoreData
//
//  Created by SWUComputer on 2016. 11. 7..
//  Copyright © 2016년 SWUComputer. All rights reserved.
//

#import "SaveViewController.h"
#import <CoreData/CoreData.h>

@interface SaveViewController ()

@end

@implementation SaveViewController

@synthesize ideaTitle, ideaContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)savePressed:(UIBarButtonItem *)sender {
    
    NSManagedObjectContext *context =nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    
    // friend record를 새로 생성함
    NSManagedObject *newIdea = [NSEntityDescription insertNewObjectForEntityForName:@"Idea" inManagedObjectContext:context];
    [newIdea setValue:ideaTitle.text forKey:@"ideaTitle"];
    [newIdea setValue:ideaContent.text forKey:@"ideaContent"];
    [newIdea setValue:[NSDate date] forKey:@"ideaDate"];
    
    // save() method를 호출하여 자료를 저장함
    NSError *error=nil;
    // Save the context
    
    
    if (![context save:&error]) {
        NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]); }
    
    // 이전 화면으로 복귀
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
