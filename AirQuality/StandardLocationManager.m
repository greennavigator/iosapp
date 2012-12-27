//
//  StandardLocationManager.m
//  GeoLocationARC
//
//  Created by Kostas Stamatis on 11/26/12.
//  Copyright (c) 2012 Kostas Stamatis. All rights reserved.
//

#import "StandardLocationManager.h"

@implementation StandardLocationManager

@synthesize accuracy, distandeFilter, delegate;

#pragma mark Singleton Methods

static StandardLocationManager *sharedStandardLocationManager = nil;

+ (id)sharedStandardLocationManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStandardLocationManager = [[self alloc] init];
    });

    return sharedStandardLocationManager;
}

- (id)init {
    if (self = [super init]) {
        //Do any initializations here
        accuracy = kCLLocationAccuracyHundredMeters;
        distandeFilter = kCLLocationAccuracyHundredMeters;
        
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = accuracy;
        locationManager.distanceFilter = distandeFilter;
                
        serviceStarted = NO;
    }
    return self;
}

#pragma mark - main functions

- (void)startUpdatingLocation {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        [locationManager startUpdatingLocation];
    }
    
    
    BOOL shouldMonitor = [CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized;
    if (shouldMonitor){
        locationManager.delegate = sharedStandardLocationManager;
        [locationManager startUpdatingLocation];
        serviceStarted = YES;
    }
    else {
        if (delegate && [delegate respondsToSelector:@selector(locationServicesNotEnabledForStandardLocationManager:)]){
            [delegate locationServicesNotEnabledForStandardLocationManager:sharedStandardLocationManager];
        }
    }
}

- (void)stopUpdatingLocationBeacuseOfAuthorization {
    if (serviceStarted) {
        [locationManager stopUpdatingLocation];
    }
}

- (void)stopUpdatingLocation {
    if (serviceStarted) {
        [locationManager stopUpdatingLocation];
        serviceStarted = NO;
    }
}

#pragma mark - Setters

- (void)setAccuracy:(CLLocationAccuracy)theAccuracy {
    accuracy = theAccuracy;
    if (serviceStarted){ //start location only if case they were already starded before setting the new accuracy
        [sharedStandardLocationManager stopUpdatingLocation];
        [sharedStandardLocationManager startUpdatingLocation];
    }
}

- (void)setDistandeFilter:(CLLocationDistance)theDistandeFilter{
    distandeFilter = theDistandeFilter;
    if (serviceStarted){ //start location only if case they were already starded before setting the new accuracy
        [sharedStandardLocationManager stopUpdatingLocation];
        [sharedStandardLocationManager startUpdatingLocation];
    }
}

#pragma mark - CLLocation Manager Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //Support for old versions of iOS
    [sharedStandardLocationManager locationManager:manager didUpdateLocations:[NSArray arrayWithObject:newLocation]];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (delegate && [delegate respondsToSelector:@selector(standardLocationManager:didUpdateLocations:)]){
        [delegate standardLocationManager:sharedStandardLocationManager didUpdateLocations:locations];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusAuthorized){
        if (serviceStarted){ //start location only if case they were already starded before authorization changed
            [sharedStandardLocationManager startUpdatingLocation];
        }
    }
    else { //stop anyway... user does not want location services
        [sharedStandardLocationManager stopUpdatingLocationBeacuseOfAuthorization];
        
        if (delegate && [delegate respondsToSelector:@selector(locationServicesNotEnabledForStandardLocationManager:)]){
            [delegate locationServicesNotEnabledForStandardLocationManager:sharedStandardLocationManager];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (delegate && [delegate respondsToSelector:@selector(standardLocationManager:didFailWithError:)]){
        [delegate standardLocationManager:sharedStandardLocationManager didFailWithError:error];
    }
}

@end
