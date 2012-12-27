//
//  StandardLocationManager.h
//  GeoLocationARC
//
//  Created by Kostas Stamatis on 11/26/12.
//  Copyright (c) 2012 Kostas Stamatis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class StandardLocationManager;

@protocol StandardLocationManagerDelegate <NSObject>

- (void)locationServicesNotEnabledForStandardLocationManager:(StandardLocationManager *)standardLocationManager;
- (void)standardLocationManager:(StandardLocationManager *)standardLocationManager didUpdateLocations:(NSArray *)locations;
- (void)standardLocationManager:(StandardLocationManager *)standardLocationManager didFailWithError:(NSError *)error;

@end

@interface StandardLocationManager : NSObject <CLLocationManagerDelegate> {
    
    CLLocationManager *locationManager;
    
    CLLocationAccuracy accuracy;
    CLLocationDistance distandeFilter;
    
    id<StandardLocationManagerDelegate> delegate;
    
    BOOL serviceStarted;
}

@property (nonatomic) id<StandardLocationManagerDelegate> delegate;

@property (nonatomic, assign) CLLocationAccuracy accuracy;
@property (nonatomic, assign) CLLocationDistance distandeFilter;

+ (id)sharedStandardLocationManager;

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

@end
