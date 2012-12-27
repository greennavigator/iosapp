//
//  CustomAnnotationView.h
//  CustomAnnotation
//
//  Created by akshay on 8/17/12.
//  Copyright (c) 2012 raw engineering, inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "CalloutView.h"

@interface HACustomAnnotationView : MKPinAnnotationView

@property (strong, nonatomic) CalloutView *calloutView2;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (void)animateCalloutAppearance;

@end