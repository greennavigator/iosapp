//
//  StationInfo.h
//  AirQuality
//
//  Created by Kostas Stamatis on 12/15/12.
//  Copyright (c) 2012 Kostas Stamatis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StationValue.h"
@interface StationInfo : NSObject {
    double lat;
    double lon;
    NSMutableArray *_values;
    int _currentIndex;
    BOOL isPoint;
}
- (id) initWithDictionary:(NSDictionary *)dict;
@property (nonatomic, strong) StationValue *currentValue;
@property (nonatomic, readonly) int sid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, readonly) UIColor *color;

@property (nonatomic) double lat;
@property (nonatomic) double lon;
@property (nonatomic, strong) StationValue *value;
@property (nonatomic) BOOL isPoint;
- (id) initWithStationInfo:(StationInfo *)stationInfo;

@end
