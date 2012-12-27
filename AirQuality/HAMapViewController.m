//
//  HAFirstViewController.m
//  AirQuality
//
//  Created by Kostas Stamatis on 12/15/12.
//  Copyright (c) 2012 Kostas Stamatis. All rights reserved.
//

#import "HAMapViewController.h"

@interface HAMapViewController ()

@end

@implementation HAMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Do any additional setup after loading the view, typically from a nib.
    
    zoomed = NO;
    
    stations = [[DataStore sharedInstance] stations];
    
    //[self displayStationInfo];
    
    [self setRegionsForMonitor];
    
    [self displayStationInfo];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerRequest) userInfo:nil repeats:YES];
    
    [timer fire];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setRegionsForMonitor{
    if ([stations count]>0){
        if(![CLLocationManager locationServicesEnabled]) {
            //[self showAlertWithMessage:@"You need to enable location services to use this app."];
            return;
        }
        
        manager = [[CLLocationManager alloc] init];
        manager.delegate = self;
        for (StationInfo *stationInfo in stations){
            //if (stationInfo.sid==100) continue;
            CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:CLLocationCoordinate2DMake(stationInfo.lat, stationInfo.lon) radius:2500 identifier:[NSString stringWithFormat:@"%i",stationInfo.sid]];
            [manager startMonitoringForRegion:region];
        }
        [manager startUpdatingLocation];
    }
}

- (void) timerRequest{
    [self displayStationInfo2];
}

- (void) displayStationInfo2 {
    for (StationInfo *stationInfo in stations){
        StationValue *stationValue = stationInfo.value;
        
        //NSLog(@"station time (sid=%i): %@", stationInfo.sid, stationValue.hhmm);
        
        int hhmm = [stationValue.hhmm intValue];
        int hours = hhmm/100;
        int h1 = hours/10;
        int h2 = hours%10;
        h1ImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.png", h1]];
        h2ImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.png", h2]];
        
        NSString *sid = [NSString stringWithFormat:@"%i", stationInfo.sid];
        MKCircleView *circleView = [circleLayers objectForKey:sid];
        UIColor *color = stationInfo.currentValue.stateColor;
        circleView.fillColor = color;
        
        MKAnnotationView *pinView = [pinAnnotations objectForKey:sid];
        //StationState state = stationInfo.currentValue.state;
        if ([color isEqual:[UIColor redColor]]){
            pinView.image = [UIImage imageNamed:@"marker4.png"];
        }
        else if ([color isEqual:[UIColor orangeColor]]){
            pinView.image = [UIImage imageNamed:@"marker3.png"];
        }
        else if ([color isEqual:[UIColor yellowColor]]){
            pinView.image = [UIImage imageNamed:@"marker2.png"];
        }
        else if ([color isEqual:[UIColor greenColor]]){
            pinView.image = [UIImage imageNamed:@"marker1.png"];
        }
    }
}

- (void) displayStationInfo {
    if ([stations count]>0){
        
        [mapView removeAnnotations:mapView.annotations];
        [mapView removeOverlays:mapView.overlays];
        
        circleLayers = [[NSMutableDictionary alloc] init];
        pinAnnotations = [[NSMutableDictionary alloc] init];
        
        StationInfo *stationInfo = [stations objectAtIndex:0];
        CLLocationCoordinate2D upper = CLLocationCoordinate2DMake(stationInfo.lat, stationInfo.lon);
        CLLocationCoordinate2D lower = CLLocationCoordinate2DMake(stationInfo.lat, stationInfo.lon);
        
        
        for (StationInfo *stationInfo in stations){
            StationValue *stationValue = stationInfo.value;
            
            NSLog(@"station time (sid=%i): %@", stationInfo.sid, stationValue.hhmm);
            
            CustomAnnotation *annotation = [[CustomAnnotation alloc] init];
            annotation.coordinate = CLLocationCoordinate2DMake(stationInfo.lat, stationInfo.lon);
            annotation.title = stationInfo.name;
            annotation.stationInfo = stationInfo;
            
            [mapView addAnnotation:annotation];
            
            double radius = 2500.0;
            CustomCircle *circle = [CustomCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(stationInfo.lat, stationInfo.lon) radius:radius];
            circle.stationInfo = stationInfo;
            [circle setTitle:@"background"];
            
            [mapView addOverlay:circle];
            
            /*CustomAnnotation *annotation = [[CustomAnnotation alloc] initWithMapView:rmMapView coordinate:CLLocationCoordinate2DMake(stationInfo.lat, stationInfo.lon) andTitle:stationInfo.name];
             
             
             annotation.mapView = rmMapView;
             
             StationInfo *circleStationInfo = [[StationInfo alloc] initWithStationInfo:stationInfo];
             CustomAnnotation *circleAnnotation = [[CustomAnnotation alloc] initWithMapView:rmMapView coordinate:CLLocationCoordinate2DMake(circleStationInfo.lat, circleStationInfo.lon) andTitle:stationInfo.name];
             
             circleAnnotation.stationInfo = circleStationInfo;
             circleAnnotation.mapView = rmMapView;
             
             
             [rmMapView addAnnotation:circleAnnotation];
             [rmMapView addAnnotation:annotation];*/
            
            if(stationInfo.lat > upper.latitude) upper.latitude = stationInfo.lat;
            if(stationInfo.lat < lower.latitude) lower.latitude = stationInfo.lat;
            if(stationInfo.lon > upper.longitude) upper.longitude = stationInfo.lon;
            if(stationInfo.lon < lower.longitude) lower.longitude = stationInfo.lon;
            
        }
        
        MKCoordinateSpan locationSpan;
        locationSpan.latitudeDelta = upper.latitude - lower.latitude;
        locationSpan.longitudeDelta = upper.longitude - lower.longitude;
        CLLocationCoordinate2D locationCenter;
        locationCenter.latitude = (upper.latitude + lower.latitude) / 2;
        locationCenter.longitude = (upper.longitude + lower.longitude) / 2;
        
        CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(upper.latitude-0.1, upper.longitude-0.1);
        CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(lower.latitude+0.1, lower.longitude+0.1);
        
        if (!zoomed){
            zoomed = YES;
            
            MKCoordinateRegion region = MKCoordinateRegionMake(locationCenter, locationSpan);
            
            mapView.region = region;
        }
    }
}

/*#pragma mark StandardLocationManager delegate
 - (void)standardLocationManager:(StandardLocationManager *)standardLocationManager didUpdateLocations:(NSArray *)locations {
 
 }
 */

- (void) locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    NSLog(@"didStartMonitoringForRegion: %@", region.identifier);
}

- (void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"Enter region...: %@", region.identifier);
    
    for (StationInfo *stationInfo in stations){
        if (stationInfo.sid == [region.identifier intValue]){
            if ([stationInfo.currentValue.stateColor isEqual:[UIColor redColor]] || [stationInfo.currentValue.stateColor isEqual:[UIColor orangeColor]]){
                NSLog(@"Enter region2...: %@", region.identifier);
                //[self showRegionAlert:@"Entering Region" forRegion:region.identifier];
                
            UILocalNotification *localNotif = [[UILocalNotification alloc] init];
            localNotif.fireDate = [NSDate dateWithTimeInterval:1 sinceDate:[NSDate date]];
            localNotif.timeZone = [NSTimeZone defaultTimeZone];
            localNotif.alertBody = @"You are entering a high-polluted area... Please, change your route!";
            localNotif.alertAction = @"More...";
            
            localNotif.soundName = @"sound1.caf";//"dataPath;//UILocalNotificationDefaultSoundName;
            localNotif.applicationIconBadgeNumber = 0;
                /*NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] init];
                [infoDict setObject:@"NO" forKey:@"iscontact"];
                [infoDict setObject:[NSString stringWithFormat:@"g: %i/%i - %@", [giortiComps day], [giortiComps month], giorti] forKey:@"name"];
                localNotif.userInfo = infoDict;*/
                
                [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
                
                break;
            }
        }
    }
}

- (void) locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    //NSLog(@"Exit region...: %@", region.identifier);
    //[self showRegionAlert:@"Exiting Region" forRegion:region.identifier];
}

- (void) showRegionAlert:(NSString *)alertText forRegion:(NSString *)regionIdentifier {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:alertText
                                                      message:regionIdentifier
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay{
    CustomCircle *circle = (CustomCircle *)overlay;
    MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:overlay];
    
    circleView.backgroundColor = [UIColor redColor];
    if ([circle.title isEqualToString:@"background"])
    {
        circleView.fillColor =  circle.stationInfo.currentValue.stateColor;//  [UIColor colorWithRed:1 green:0 blue:0 alpha:0.3];
        circleView.opaque = NO;
        circleView.alpha = 0.3;
        
        [circleLayers setObject:circleView forKey:[NSString stringWithFormat:@"%i",circle.stationInfo.sid]];
    }
    else
    {
        circleView.strokeColor = [UIColor yellowColor];
        circleView.lineWidth = 2.0;
    }
    
    return circleView;
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:
(id <MKAnnotation>)anAnnotation {
    CustomAnnotation *annotation = (CustomAnnotation *)anAnnotation;
    
    HACustomAnnotationView *pinView = nil;
    if(anAnnotation != mapView.userLocation)
    {
        pinView = (HACustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView){
            // If an existing pin view was not available, create one.
            pinView = [[HACustomAnnotationView alloc] initWithAnnotation:annotation
                                                       reuseIdentifier:@"CustomPinAnnotationView"];
            [pinView setPinColor:MKPinAnnotationColorGreen];
            //[pinView setAnimatesDrop:YES];
            [pinView setCanShowCallout:YES];
            //[pinView setDraggable:YES];
            
            pinView.pinColor = MKPinAnnotationColorRed;
            
            StationState state = annotation.stationInfo.currentValue.state;
            switch (state) {
                case ssExtreme:
                    pinView.image = [UIImage imageNamed:@"marker4.png"];
                    break;
                case ssHigh:
                    pinView.image = [UIImage imageNamed:@"marker3.png"];
                    break;
                case ssMid:
                    pinView.image = [UIImage imageNamed:@"marker2.png"];
                    break;
                case ssLow:
                    pinView.image = [UIImage imageNamed:@"marker1.png"];
                    break;
                default:
                    break;
            }
        }
        else
            pinView.annotation = annotation;
        
        
        pinView.canShowCallout = YES;
        [pinAnnotations setObject:pinView forKey:[NSString stringWithFormat:@"%i",annotation.stationInfo.sid]];
    }
    else {
        [mapView.userLocation setTitle:@"I am here"];
    }
    return pinView;
}


@end
