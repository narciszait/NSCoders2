//
//  SecondViewController.m
//  NSCoders2
//
//  Created by Narcis Zait on 10/17/13.
//  Copyright (c) 2013 Narcis. All rights reserved.
//

#import "MapViewController.h"
#import "DisplayAnnotation.h"

@interface MapViewController (){
    CLLocationCoordinate2D retroCafe;
}
@end

@implementation MapViewController

@synthesize toolbar, showToolbarButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [locationManager startUpdatingLocation];
    
    retroCafe = CLLocationCoordinate2DMake(55.69313, 12.54343);
    MKCoordinateSpan span = {.latitudeDelta=0.003433,.longitudeDelta=0.003433}; //delta=0.003433
    MKCoordinateRegion region = {retroCafe, span};
    [mapView setRegion:region animated:YES];
    
    DisplayAnnotation *retroCafeAnnotation = [[DisplayAnnotation alloc] init];
    retroCafeAnnotation.title = @"Cafe Retro Nørrebro";
    retroCafeAnnotation.coordinate = MKCoordinateForMapPoint(MKMapPointForCoordinate(CLLocationCoordinate2DMake(55.69313, 12.54343)));
    [mapView addAnnotation:retroCafeAnnotation];
    mapView.showsBuildings = YES;
    mapView.showsUserLocation = YES;
    
    mapView.delegate = self;
}

- (IBAction)showToolbar:(id)sender{
    if ([sender isKindOfClass:[UIButton self]]) {
        UIButton *button = (UIButton *)sender;
        NSLog(@"the sending view is %@", button);
        [UIView animateWithDuration:0.5 delay:0.0 options: UIViewAnimationOptionCurveLinear
                         animations:^{
                             button.alpha=0.0f;
                         }
                         completion:^(BOOL finished){
                             NSLog(@"Done!");
                             [button setFrame:CGRectMake(0 , [[UIScreen mainScreen] bounds].size.height + 90, 40, 40)];
                             showToolbarButton = button;
                             [self createToolbar];
                         }];
    }
    
    NSLog(@"alpha zero");
}

-(void)createToolbar{
    CGRect frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 95, [[UIScreen mainScreen] bounds].size.width, 50);
    toolbar = [[UIToolbar alloc]initWithFrame:frame];
    //    toolbar.barStyle = UIBarStyleBlackTranslucent;
    toolbar.tintColor=[UIColor colorWithRed:0.886 green:0.91 blue:0.929 alpha:1]; //[UIColor colorWithRed:0.886 green:0.91 blue:0.929 alpha:1]
    //[toolbar sizeToFit];
//    toolbar.alpha=0.0f;
    
    
    UIImage *locateUser = [UIImage imageNamed:@"locateUser.png"];
    UIButton *locateUserButton = [[UIButton alloc] init];
    [locateUserButton setImage:locateUser forState:UIControlStateNormal];
    [locateUserButton addTarget:self action:@selector(showUserLocation:) forControlEvents:UIControlEventTouchUpInside];
    [locateUserButton setFrame:CGRectMake(0, 0, 40, 42)];
    
    UIImage *car = [UIImage imageNamed:@"car.png"];
    UIButton *carButton = [[UIButton alloc] init];
    [carButton setImage:car forState:UIControlStateNormal];
    [carButton addTarget:self action:@selector(showDrivingRoute:) forControlEvents:UIControlEventTouchUpInside];
    [carButton setFrame:CGRectMake(0, 0, 40, 42)];
    
    UIImage *walk = [UIImage imageNamed:@"walk.png"];
    UIButton *walkButton = [[UIButton alloc] init];
    [walkButton setImage:walk forState:UIControlStateNormal];
    [walkButton addTarget:self action:@selector(showWalkingRoute:) forControlEvents:UIControlEventTouchUpInside];
    [walkButton setFrame:CGRectMake(0, 0, 40, 42)];
    
    UIImage *public = [UIImage imageNamed:@"public.png"];
    UIButton *publicButton = [[UIButton alloc] init];
    [publicButton setImage:public forState:UIControlStateNormal];
    [publicButton addTarget:self action:@selector(showPublicTransport:) forControlEvents:UIControlEventTouchUpInside];
    [publicButton setFrame:CGRectMake(0, 0, 40, 42)];
    
    UIImage *arrowDown = [UIImage imageNamed:@"arrow_down.png"];
    UIButton *arrowDownButton = [[UIButton alloc] init];
    [arrowDownButton setImage:arrowDown forState:UIControlStateNormal];
    [arrowDownButton addTarget:self action:@selector(hideToolbar) forControlEvents:UIControlEventTouchUpInside];
    [arrowDownButton setFrame:CGRectMake(0, 0, 40, 42)];
    
    
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithCustomView:locateUserButton];
    UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithCustomView:carButton];
    UIBarButtonItem *button3 = [[UIBarButtonItem alloc] initWithCustomView:walkButton];
    UIBarButtonItem *button4 = [[UIBarButtonItem alloc] initWithCustomView:publicButton];
    UIBarButtonItem *button5 = [[UIBarButtonItem alloc] initWithCustomView:arrowDownButton];
    
    UIBarButtonItem *flexibleSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpace2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpace3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpace4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    
    NSArray *buttonItems = [NSArray arrayWithObjects:button1, flexibleSpace1, button2, flexibleSpace2, button3, flexibleSpace3, button4, flexibleSpace4, button5, nil];
    [toolbar setItems:buttonItems];
    
    
    
    [UIView animateWithDuration:0.20
                          delay:0.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         toolbar.alpha=1.0f;
                     }
                     completion:^(BOOL finished){
                         [self.view addSubview:toolbar];
                     }];
    NSLog(@"arrowDown x and y: %f %f", arrowDownButton.frame.origin.x, arrowDownButton.frame.origin.y);
    
}

-(void)hideToolbar{
    [UIView animateWithDuration:0.20
                          delay:0.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         toolbar.alpha=0.0f;
                     }
                     completion:^(BOOL finished){
                         NSLog(@"removed toolbar!");
                         NSLog(@"showToolbar y %f",showToolbarButton.frame.origin.y);
                         [showToolbarButton setFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 110, 40, 40)];
                         showToolbarButton.alpha=1.0f;
                     }];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
}

-(void)viewWillAppear:(BOOL)animated{
    [self.view addSubview:toolbar];
}

-(IBAction)showUserLocation:(id)sender{
    NSLog(@"User Location");
    CLLocationCoordinate2D userLocation=CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
    //[mapView setCenterCoordinate:userLocation];
    MKCoordinateSpan span={.latitudeDelta=0.003433,.longitudeDelta=0.003433}; //delta=0.003433
    MKCoordinateRegion region={userLocation,span};
    [mapView setRegion:region animated:YES];
    
}

-(IBAction)showDrivingRoute:(id)sender{
    NSLog(@"driving route");
   // CLLocationCoordinate2D userLocation=CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
    
    MKPlacemark *endLocation = [[MKPlacemark alloc] initWithCoordinate:retroCafe addressDictionary:nil];
    MKMapItem *endingItem = [[MKMapItem alloc] initWithPlacemark:endLocation];
    
    NSMutableDictionary *launchOptions = [[NSMutableDictionary alloc] init];
    [launchOptions setObject:MKLaunchOptionsDirectionsModeDriving forKey:MKLaunchOptionsDirectionsModeKey];
    
    [endingItem openInMapsWithLaunchOptions:launchOptions];
}

-(IBAction)showWalkingRoute:(id)sender{
    NSLog(@"walking route");
    MKPlacemark *endLocation = [[MKPlacemark alloc] initWithCoordinate:retroCafe addressDictionary:nil];
    MKMapItem *endingItem = [[MKMapItem alloc] initWithPlacemark:endLocation];
    
    NSMutableDictionary *launchOptions = [[NSMutableDictionary alloc] init];
    [launchOptions setObject:MKLaunchOptionsDirectionsModeWalking forKey:MKLaunchOptionsDirectionsModeKey];
    
    [endingItem openInMapsWithLaunchOptions:launchOptions];

}

-(IBAction)showPublicTransport:(id)sender{
    NSLog(@"Public transport");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload {
    [super viewDidUnload];
    [locationManager stopUpdatingLocation];
}


@end
