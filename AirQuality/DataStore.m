//
//  DataStore.m
//  AirQuality
//
//  Created by George Stavrou on 12/15/12.
//  Copyright (c) 2012 Kostas Stamatis. All rights reserved.
//

#import "DataStore.h"
#import "SBJson.h"
#import "StationInfo.h"
#import "StationValue.h"
#define STATION_FILES [NSArray arrayWithObjects:@"patisiwn_100_fixed", @"ag_parask_111_fixed", nil]

@implementation DataStore
@synthesize stations = _stations;
+ (id) sharedInstance{
    static dispatch_once_t dt = 0;
    __strong static id _shared = nil;
    dispatch_once(&dt, ^{
        _shared = [[DataStore alloc] init];
    });
    return _shared;
}
- (id) init{
    if (self = [super init]) {
        _stations = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void) loadSampleDataSets{
    NSString *path = nil;
    NSString *data = nil;
    NSDictionary *dict = nil;
    for (NSString *fname in STATION_FILES) {
        path = [[NSBundle mainBundle] pathForResource:fname ofType:@"json"];
        data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [_stations addObject:[[StationInfo alloc] initWithDictionary:[data JSONValue]]];
    }
    
    
    NSLog(@"%@", [dict objectForKey:@"lat"]);
}
@end
