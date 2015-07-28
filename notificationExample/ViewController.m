//
//  ViewController.m
//  notificationExample
//
//  Created by Fabiola Ramirez on 26/7/15.
//  Copyright (c) 2015 Fabiola Ramirez. All rights reserved.
//

#import "ViewController.h"

#define BEACON_UUID @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"
#define BEACON_MAJOR 51134
#define BEACON_MINOR 6459

@interface ViewController () <ESTBeaconManagerDelegate>

@property (nonatomic, strong) CLBeacon *beacon;
@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



- (IBAction)action:(id)sender;



@end

@implementation ViewController


- (id)initWithBeacon:(CLBeacon *)beacon
{
    self = [super init];
    if (self)
    {
        self.beacon = beacon;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad");
    
    /*
     * Persmission to show Local Notification.
     */
    UIApplication *application = [UIApplication sharedApplication];
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }

    
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    
    [self.beaconManager requestWhenInUseAuthorization];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:BEACON_UUID] major:BEACON_MAJOR minor:BEACON_MINOR identifier:@"beaconRegion1"];
    
    
    [self.beaconManager startMonitoringForRegion:self.beaconRegion];
    
    //[self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
    
}

- (void)viewWillAppear:(BOOL)animated {

    NSLog(@"viewWillAppear");
    
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)action:(id)sender {
    
    
    UILocalNotification * localNotification = [[UILocalNotification alloc]init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    localNotification.alertBody = @"esta es un anotificacion";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    NSLog(@"viewDidDisappear");
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
    
    [super viewDidDisappear:animated];
}

#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(id)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    
    NSLog(@"didRangeBeacons");
    if (beacons.count > 0)
    {
        CLBeacon *firstBeacon = [beacons firstObject];
        
        self.titleLabel.text     = [self textForProximity:firstBeacon.proximity];
        if ([[self textForProximity:firstBeacon.proximity]isEqualToString:@"Near"]) {
            
            NSLog(@"entrandooo!!");
            
            ViewController2 *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewController2"];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
            
            [self presentViewController:navigationController animated:YES completion:nil];
            
            [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
        }
    }
}

#pragma mark -

- (NSString *)textForProximity:(CLProximity)proximity
{
    switch (proximity) {
        case CLProximityFar:
            return @"Far";
            break;
        case CLProximityNear:
            return @"Near";
            break;
        case CLProximityImmediate:
            return @"Immediate";
            break;
            
        default:
            return @"Unknown";
            break;
    }
}

#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(id)manager monitoringDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    UIAlertView* errorView = [[UIAlertView alloc] initWithTitle:@"Monitoring error"
                                                        message:error.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    
    [errorView show];
}

- (void)beaconManager:(id)manager didEnterRegion:(CLBeaconRegion *)region
{
    
    NSLog(@"didEnterRegion");
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Enter region notification";
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)beaconManager:(id)manager didExitRegion:(CLBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Exit region notification";
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}



#pragma mark -

- (void)switchValueChanged
{
    [self.beaconManager stopMonitoringForRegion:self.beaconRegion];
    
    
    
    [self.beaconManager startMonitoringForRegion:self.beaconRegion];
}


@end
