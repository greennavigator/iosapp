//
//  CalloutViewController.h
//  AirQuality
//
//  Created by Kostas Stamatis on 12/16/12.
//  Copyright (c) 2012 Kostas Stamatis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalloutView : UIView {
    
    IBOutlet UILabel *titleLabel;
    
    IBOutlet UILabel *coLabel;
    IBOutlet UILabel *so2Label;
    IBOutlet UILabel *no2Label;
    IBOutlet UILabel *o3Label;
    IBOutlet UILabel *pmLabel;
}

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *coLabel;
@property (nonatomic) UILabel *so2Label;
@property (nonatomic) UILabel *no2Label;
@property (nonatomic) UILabel *o3Label;
@property (nonatomic) UILabel *pmLabel;

@end
