//
//  SecondViewController.h
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
}



@end
