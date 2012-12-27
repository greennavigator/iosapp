//
//  CustomCircle.h
//  AirQuality
//
//  Created by Kostas Stamatis on 12/15/12.
//  Copyright (c) 2012 Kostas Stamatis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StationInfo.h"

@interface CustomCircle : MKCircle {
    
    StationInfo *stationInfo;
}

@property (nonatomic) StationInfo *stationInfo;

@end
