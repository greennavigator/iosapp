//
//  StationValue.h
//  AirQuality
//
//  Created by George Stavrou on 12/15/12.
//  Copyright (c) 2012 Kostas Stamatis. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {ssLow, ssMid, ssHigh, ssExtreme} StationState;

@interface StationValue : NSObject
- (id) initWithDictionary:(NSDictionary *)dict;
@property (nonatomic, readonly) StationState state;
@property (nonatomic, readonly) UIColor *stateColor;
@property (nonatomic, assign) int code;
@property (nonatomic, assign) int sid;
@property (nonatomic, assign) int year;
@property (nonatomic, assign) int doy;
@property (nonatomic, strong) NSString *hhmm;
@property (nonatomic, assign) float co;
@property (nonatomic, assign) float no;
@property (nonatomic, assign) float no2;
@property (nonatomic, assign) float nox;
@property (nonatomic, assign) float so2;
@property (nonatomic, assign) float o3;
@property (nonatomic, assign) float mp25;

- (StationState)stateCo;
- (StationState)stateMP;
- (StationState)stateO3;
- (StationState)stateNo2;
- (StationState)stateSo2;

@end
