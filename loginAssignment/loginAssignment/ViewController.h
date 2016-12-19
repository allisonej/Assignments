//
//  ViewController.h
//  loginAssignment
//
//  Created by SWUComputer on 2016. 11. 21..
//  Copyright © 2016년 SWUComputer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>{
    NSMutableArray *monthArray;
    NSMutableArray *dayArray;
}
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet UILabel *labelResult;


- (IBAction)whatDay:(UIButton *)sender;

@end

