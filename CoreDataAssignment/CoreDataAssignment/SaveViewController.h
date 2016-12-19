//
//  SaveViewController.h
//  CoreDataAssignment
//
//  Created by SWUComputer on 2016. 11. 7..
//  Copyright © 2016년 SWUComputer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaveViewController : UIViewController<UITextFieldDelegate>{
    NSDate *currentDate;
}

@property (strong, nonatomic) IBOutlet UITextField *ideaTitle;
@property (strong, nonatomic) IBOutlet UITextView *ideaContent;

- (IBAction)savePressed:(UIBarButtonItem *)sender;

- (BOOL) textFieldShouldReturn:(UITextField *)textField;

@end
