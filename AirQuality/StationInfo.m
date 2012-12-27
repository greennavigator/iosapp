//
//  StationInfo.m
//  AirQuality
//
//  Created by Kostas Stamatis on 12/15/12.
//  Copyright (c) 2012 Kostas Stamatis. All rights reserved.
//

#import "StationInfo.h"
@implementation StationInfo
@synthesize lat, lon, isPoint;
@synthesize name, color, sid = _sid;
@synthesize value, currentValue;
- (id) initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.name = [dict objectForKey:@"name"];
        self.lat = [[dict objectForKey:@"lat"] doubleValue];
        self.lon = [[dict objectForKey:@"lon"] doubleValue];
        _values = [[NSMutableArray alloc] init];
        _currentIndex = -1;
        StationValue *sv = nil;
        for (NSDictionary *dc in [dict objectForKey:@"values"]) {
            sv = [[StationValue alloc] initWithDictionary:dc];
            if (_sid == 0) {
                _sid = sv.sid;
            }
            [_values addObject:sv];
            //[self value];
        }
        isPoint = YES;
    }
    return self;
}
- (StationValue *)value{
    if (_currentIndex < [_values count] - 1) {
        _currentIndex++;
    }else{
        _currentIndex = 0;
    }
    self.currentValue = [_values objectAtIndex:_currentIndex];
    return self.currentValue;
}

- (id)init {
    if (self = [super init]){
        isPoint = YES;
    }
    return self;
}

- (id) initWithStationInfo:(StationInfo *)stationInfo{
    if (self = [super init]){
        isPoint = NO;
        self.lat = stationInfo.lat;
        self.lon = stationInfo.lon;
        self.currentValue = stationInfo.currentValue;
    }
    return self;
}

@end
