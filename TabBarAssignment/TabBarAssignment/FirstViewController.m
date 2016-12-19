//
//  FirstViewController.m
//  TabBarAssignment
//
//  Created by SWUComputer on 2016. 11. 14..
//  Copyright © 2016년 SWUComputer. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "AppDelegate.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Badge Notification 설정
    UIUserNotificationType types = UIUserNotificationTypeBadge;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];

    
    // First VC 가 처음 실행되는 VC 이므로 이곳에 한번만 설정하면 됨
    [self setApplicationBadgeNumber:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (IBAction)addCoffee {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [delegate.coffee addObject:@"커피 한 잔 추가요!!!"];
    
    UITabBarController *tabController =
    (UITabBarController *) delegate.window.rootViewController;
    SecondViewController *tableVC = [[tabController viewControllers] objectAtIndex:1];
    tableVC.coffeeTab.badgeValue = [NSString stringWithFormat:@"%d", [delegate.coffee count]];
    
    [self setApplicationBadgeNumber: [delegate.coffee count]];
}

- (IBAction)addMartini {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [delegate.martini addObject:@"마티니 한 잔 추가요!!!"];
    
    UITabBarController *tabController =
    (UITabBarController *) delegate.window.rootViewController;
    ThirdViewController *tableVC = [[tabController viewControllers] objectAtIndex:2];
    tableVC.martiniTab.badgeValue = [NSString stringWithFormat:@"%d", [delegate.martini count]];
    
    [self setApplicationBadgeNumber: [delegate.martini count]];
}
@end
