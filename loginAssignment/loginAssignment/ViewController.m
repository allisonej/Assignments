//
//  ViewController.m
//  loginAssignment
//
//  Created by SWUComputer on 2016. 11. 21..
//  Copyright © 2016년 SWUComputer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize picker;
@synthesize labelResult;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSInteger i;
    monthArray = [[NSMutableArray alloc]init];
    dayArray = [[NSMutableArray alloc] init];
    
    for (i=1;i<=12; i++){
        [monthArray addObject:[NSString stringWithFormat:@"%ld월", (long) i]];
    }
    for (i=1; i<=31; i++) {
        [dayArray addObject:[NSString stringWithFormat:@"%ld일", (long) i]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0)
        return [monthArray count];
    else
        return [dayArray count];
}
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0)
        return [monthArray objectAtIndex:row];
    else
        return [dayArray objectAtIndex:row];
}


- (IBAction)whatDay:(UIButton *)sender {
   // NSInteger success = 0;
    NSString *dayTitle;
    @try {
        //FIRST WAY
/*        // month / day 넘기는 형식
        NSString *post =[[NSString alloc] initWithFormat:@"month=%@&day=%@", [monthArray objectAtIndex:[picker selectedRowInComponent:0]], [dayArray objectAtIndex:[picker selectedRowInComponent:1]]];
        
        // URL. 리소스를 가져오기 위한 객체
            NSURL *url=[NSURL URLWithString:@"http://211.106.28.66/labs/findWhatDay.php"];
        //posting data 인코딩
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];//NSASCIIStringEncoding allowLossyConversion:YES];
        //length
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        //request 설정
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSString *responseString = [[NSString alloc] initWithBytes:[urlData bytes] length:[urlData length] encoding:NSUTF8StringEncoding];
        */
        //SECOND WAY
        
        NSString *rawStr = [[NSString alloc] initWithFormat:@"month=%@&day=%@", [monthArray objectAtIndex:[picker selectedRowInComponent:0]], [dayArray objectAtIndex:[picker selectedRowInComponent:1]]];
        NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:@"http://211.106.28.66/labs/findWhatDay.php"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:data];
        NSURLResponse *response;
        NSError *err;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        NSString *responseString = [[NSString alloc] initWithBytes:[responseData bytes] length:[responseData length] encoding:NSUTF8StringEncoding];
        
        
        dayTitle = responseString;
        labelResult.text = dayTitle;
        

    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        labelResult.text = dayTitle;
    }
} 
@end
