//
//  AppDelegate.m
//  notificationExample
//
//  Created by Fabiola Ramirez on 26/7/15.
//  Copyright (c) 2015 Fabiola Ramirez. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [ESTCloudManager setupAppID:@"beaconex" andAppToken:@"23daae8c41aa4ebbbb792a81749b021e"];
    
    
    //popup
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    
    
    //other
    /*UILocalNotification *localNotification=[launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (localNotification) {
        [application cancelAllLocalNotifications];
    }*/
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
       
/*
    
    NSDate *alarmTime=[[NSDate date] dateByAddingTimeInterval:5.0];
    UIApplication *app=[UIApplication sharedApplication];
         
    UILocalNotification *notifyAlarm=[[UILocalNotification alloc]init];
    if(notifyAlarm){
        notifyAlarm.fireDate=alarmTime;
        notifyAlarm.timeZone=[NSTimeZone defaultTimeZone];
        notifyAlarm.repeatInterval=0;
        notifyAlarm.soundName=@"";
        notifyAlarm.alertBody=@"";
        [app scheduleLocalNotification:notifyAlarm];
    }
  */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    
    
    /*UIApplication *app=[UIApplication sharedApplication];
    NSArray *oldnotifications=[app scheduledLocalNotifications];
    if ([oldnotifications count]>0) {
        [app cancelAllLocalNotifications];
    }
    */
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
