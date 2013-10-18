//
//  SecondViewController.m
//  NSCoders2
//
//  Created by Narcis Zait on 10/17/13.
//  Copyright (c) 2013 Narcis. All rights reserved.
//

#import "MapViewController.h"
#import "DisplayAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [locationManager startUpdatingLocation];
    
    CLLocationCoordinate2D retroCafe = CLLocationCoordinate2DMake(55.69313, 12.54343);
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
