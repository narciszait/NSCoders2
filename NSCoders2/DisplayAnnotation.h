//
//  DisplayAnnotation.h
//  NSCoders2
//
//  Created by Narcis Zait on 10/18/13.
//  Copyright (c) 2013 Narcis. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface DisplayAnnotation : MKAnnotationView <MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString *title;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

@end
