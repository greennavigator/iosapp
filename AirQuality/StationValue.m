//
//  StationValue.m
//  AirQuality
//
//  Created by George Stavrou on 12/15/12.
//  Copyright (c) 2012 Kostas Stamatis. All rights reserved.
//

#import "StationValue.h"

@implementation StationValue
@synthesize code, sid, year, doy, hhmm;
@synthesize co, no, no2, nox, so2, o3, mp25, state = _state, stateColor = _stateColor;
- (id) initWithDictionary:(NSDictionary *)dict{
    if( self = [super init]){
        @try {
            self.code = [[dict objectForKey:@"code"] intValue];
            self.sid = [[dict objectForKey:@"sid"] intValue];
            self.year = [[dict objectForKey:@"year"] intValue];
            self.doy = [[dict objectForKey:@"doy"] intValue];
            self.hhmm = [dict objectForKey:@"time"];

            self.co = [[dict objectForKey:@"co"] floatValue];
            self.no = [[dict objectForKey:@"no"] floatValue];
            self.no2 = [[dict objectForKey:@"no2"] floatValue];
            self.nox = [[dict objectForKey:@"nox"] floatValue];
            self.so2 = [[dict objectForKey:@"so2"] floatValue];
            self.o3 = [[dict objectForKey:@"o3"] floatValue];
            self.mp25 = [[dict objectForKey:@"mp25"] floatValue];
            
            if (self.co > 9000.0f) {
                self.co = 0.0f;
            }
            if (self.no > 9000.0f) {
                self.no = 0.0f;
            }
            if (self.no2 > 9000.0f) {
                self.no2 = 0.0f;
            }
            if (self.nox > 9000.0f) {
                self.nox = 0.0f;
            }
            if (self.so2 > 9000.0f) {
                self.so2 = 0.0f;
            }
            if (self.o3 > 9000.0f) {
                self.o3 = 0.0f;
            }
            if (self.mp25 > 9000.0f) {
                self.mp25 = 0.0f;
            }
        }
        @catch (NSException *exception) {
            
        }
    }
    return self;
}

- (StationState)stateCo{
    
    StationState coState;
    
    //CO
    if (self.co >=0.0f && self.co < 6.0f) {
        coState = ssLow;
    }
    else if (self.co >= 6.0f && self.co < 11.0f){
        coState = ssMid;
    }
    else if (self.co >= 11.0f && self.co < 15.0f){
        coState = ssHigh;
    }
    else if (self.co >= 15.0f){
        coState = ssExtreme;
    }
    
    return coState;

}

- (StationState)stateSo2{
    
    StationState so2State;
    
    if (self.so2 >=0.0f && self.so2 < 176.0f) {
        so2State = ssLow;
    }
    else if (self.so2 >= 176.0f && self.so2 < 351.0f){
        so2State = ssMid;
    }
    else if (self.so2 >= 351.0f && self.so2 < 450.0f){
        so2State = ssHigh;
    }
    else if (self.so2 >= 450.0f){
        so2State = ssExtreme;
    }
    
    return so2State;
    
}

- (StationState)stateNo2{
    
    StationState no2State;
    
    if (self.no2 >=0.0f && self.no2 < 101.0f) {
        no2State = ssLow;
    }
    else if (self.no2 >= 101.0f && self.no2 < 201.0f){
        no2State = ssMid;
    }
    else if (self.no2 >= 201.0f && self.no2 < 400.0f){
        no2State = ssHigh;
    }
    else if (self.no2 >= 400.0f){
        no2State = ssExtreme;
    }
    
    return no2State;
    
}

- (StationState)stateO3{
    
    StationState o3State;
    
    if (self.o3 >=0.0f && self.o3 < 121.0f) {
        o3State = ssLow;
    }
    else if (self.o3 >= 121.0f && self.o3 < 181.0f){
        o3State = ssMid;
    }
    else if (self.o3 >= 181.0f && self.o3 < 240.0f){
        o3State = ssHigh;
    }
    else if (self.o3 >= 240.0f){
        o3State = ssExtreme;
    }
    
    return o3State;
    
}

- (StationState)stateMP{
    
    StationState mp25State;
    
    if (self.mp25 >=0.0f && self.mp25 < 51.0f) {
        mp25State = ssLow;
    }
    else if (self.mp25 >= 51.0f && self.mp25 < 151.0f){
        mp25State = ssMid;
    }
    else if (self.mp25 >= 151.0f && self.mp25 < 300.0f){
        mp25State = ssHigh;
    }
    else if (self.mp25 >= 300.0f){
        mp25State = ssExtreme;
    }
    
    return mp25State;
    
}

- (StationState)state{
    
    StationState coState;
    StationState so2State;
    StationState no2State;
    StationState o3State;
    StationState mp25State;
    
    //CO
    if (self.co >=0.0f && self.co < 6.0f) {
        coState = ssLow;
    }
    else if (self.co >= 6.0f && self.co < 11.0f){
        coState = ssMid;
    }
    else if (self.co >= 11.0f && self.co < 15.0f){
        coState = ssHigh;
    }
    else if (self.co >= 15.0f){
        coState = ssExtreme;
    }
    
    //SO2
    if (self.so2 >=0.0f && self.so2 < 176.0f) {
        so2State = ssLow;
    }
    else if (self.so2 >= 176.0f && self.so2 < 351.0f){
        so2State = ssMid;
    }
    else if (self.so2 >= 351.0f && self.so2 < 450.0f){
        so2State = ssHigh;
    }
    else if (self.so2 >= 450.0f){
        so2State = ssExtreme;
    }
    
    //NO2
    if (self.no2 >=0.0f && self.no2 < 101.0f) {
        no2State = ssLow;
    }
    else if (self.no2 >= 101.0f && self.no2 < 201.0f){
        no2State = ssMid;
    }
    else if (self.no2 >= 201.0f && self.no2 < 400.0f){
        no2State = ssHigh;
    }
    else if (self.no2 >= 400.0f){
        no2State = ssExtreme;
    }
    
    //O3
    if (self.o3 >=0.0f && self.o3 < 121.0f) {
        o3State = ssLow;
    }
    else if (self.o3 >= 121.0f && self.o3 < 181.0f){
        o3State = ssMid;
    }
    else if (self.o3 >= 181.0f && self.o3 < 240.0f){
        o3State = ssHigh;
    }
    else if (self.o3 >= 240.0f){
        o3State = ssExtreme;
    }
    
    //PM25
    if (self.mp25 >=0.0f && self.mp25 < 51.0f) {
        mp25State = ssLow;
    }
    else if (self.mp25 >= 51.0f && self.mp25 < 151.0f){
        mp25State = ssMid;
    }
    else if (self.mp25 >= 151.0f && self.mp25 < 300.0f){
        mp25State = ssHigh;
    }
    else if (self.mp25 >= 300.0f){
        mp25State = ssExtreme;
    }
    NSArray *arr = [NSArray arrayWithObjects:[NSNumber numberWithInt:coState],
                    [NSNumber numberWithInt:so2State],
                    [NSNumber numberWithInt:no2State],
                    [NSNumber numberWithInt:o3State],
                    [NSNumber numberWithInt:mp25State],
                    nil];
    NSArray *sortArr = [arr sortedArrayUsingComparator:^(id a, id b) {
        NSNumber *n1 = (NSNumber *)a;
        NSNumber *n2 = (NSNumber *)b;
        return (NSComparisonResult)[n2 compare:n1];
    }];
    _state = (StationState)[[sortArr objectAtIndex:0] intValue];
    return _state;
}
- (UIColor *) stateColor{
    StationState ss = self.state;
    if (ss == ssLow) {
        return [UIColor greenColor];
    }
    else if (ss == ssMid){
        return [UIColor yellowColor];
    }
    else if (ss == ssHigh){
        return [UIColor orangeColor];
    }
    return [UIColor redColor];
}
@end
