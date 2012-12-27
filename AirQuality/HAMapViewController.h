//
//  HAFirstViewController.h
//  AirQuality
//
//  Created by Kostas Stamatis on 12/15/12.
//  Copyright (c) 2012 Kostas Stamatis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StationInfo.h"
#import "CustomAnnotation.h"
#import "StandardLocationManager.h"
#import "DataStore.h"
#import "CustomCircle.h"
#import "HACustomAnnotationView.h"

@interface HAMapViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *manager;
    
    IBOutlet MKMapView *mapView;
    NSArray *stations;
    
    BOOL zoomed;
    
    NSMutableDictionary *circleLayers;
    NSMutableDictionary *pinAnnotations;
    
    IBOutlet UIImageView *h1ImageView;
    IBOutlet UIImageView *h2ImageView;
}
@end
