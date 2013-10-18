//
//  MapViewController.h
//  NSCoders2
//
//  Created by Narcis Zait on 10/17/13.
//  Copyright (c) 2013 Narcis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>{
    IBOutlet MKMapView *mapView;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D currentCenter;
    
    IBOutlet UIToolbar *toolbar;
}

@property (nonatomic,retain) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIButton *showToolbarButton;

-(IBAction)showToolbar:(id)sender;
-(IBAction)showUserLocation:(id)sender;
-(IBAction)showDrivingRoute:(id)sender;
-(IBAction)showWalkingRoute:(id)sender;
//-(IBAction)showPublicTransport:(id)sender;


@end
