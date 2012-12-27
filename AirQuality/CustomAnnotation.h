//
//  CustomAnnotation.h
//  GeoLocationARC
//
//  Created by Kostas Stamatis on 12/1/12.
//  Copyright (c) 2012 Kostas Stamatis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "StationInfo.h"

@interface CustomAnnotation : NSObject <MKAnnotation> {
    
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    
    StationInfo *stationInfo;
    
}
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *subtitle;

@property (nonatomic) StationInfo *stationInfo;

@end

