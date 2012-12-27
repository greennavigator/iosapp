//
//  DataStore.h
//  AirQuality
//
//  Created by George Stavrou on 12/15/12.
//  Copyright (c) 2012 Kostas Stamatis. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DataStore : NSObject{
    NSMutableArray *_stations;
}
+ (id)sharedInstance;
- (void) loadSampleDataSets;
@property (nonatomic, readonly) NSArray *stations;
@end
