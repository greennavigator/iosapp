//
//  CustomAnnotationView.m
//  CustomAnnotation
//
//  Created by akshay on 8/17/12.
//  Copyright (c) 2012 raw engineering, inc. All rights reserved.
//

#import "HACustomAnnotationView.h"
#import "CustomAnnotation.h"

@implementation HACustomAnnotationView

@synthesize calloutView2;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];

    CustomAnnotation *ann = (CustomAnnotation *)self.annotation;
    if(selected)
    {
        //Add your custom view to self...
        UIViewController *controller = [[UIViewController alloc] initWithNibName:@"CalloutView" bundle:[NSBundle mainBundle]];
        UIImageView *aView = [[UIImageView alloc] initWithFrame:CGRectMake(-24, 35, 40, 40)];
        //aView.backgroundColor = [UIColor yellowColor];
        aView.image = [UIImage imageNamed:@"my_callout.png"];
        aView.contentMode = UIViewContentModeScaleToFill;
        calloutView2 = (CalloutView *)controller.view;
        [calloutView2 setFrame:CGRectMake(-80, -190, 220, 211)];
        
        calloutView2.titleLabel.text = ann.stationInfo.name;
        calloutView2.o3Label.text = [NSString stringWithFormat:@"%.2f",ann.stationInfo.currentValue.o3];
        if ((int)(ann.stationInfo.currentValue.o3)==0){
            calloutView2.o3Label.text = @"---";
        }
        calloutView2.so2Label.text = [NSString stringWithFormat:@"%.2f",ann.stationInfo.currentValue.so2];
        if ((int)(ann.stationInfo.currentValue.so2)==0){
            calloutView2.so2Label.text = @"---";
        }

        calloutView2.no2Label.text = [NSString stringWithFormat:@"%.2f",ann.stationInfo.currentValue.no2];
        if ((int)(ann.stationInfo.currentValue.no2)==0){
            calloutView2.no2Label.text = @"---";
        }
        
        calloutView2.coLabel.text = [NSString stringWithFormat:@"%.2f",ann.stationInfo.currentValue.co];
        if ((int)(ann.stationInfo.currentValue.co)==0){
            calloutView2.coLabel.text = @"---";
        }
        
        calloutView2.pmLabel.text = [NSString stringWithFormat:@"%.2f",ann.stationInfo.currentValue.mp25];
        if ((int)(ann.stationInfo.currentValue.mp25)==0){
            calloutView2.pmLabel.text = @"---";
        }
        
        StationState stateCo = [ann.stationInfo.currentValue stateCo];
        switch (stateCo) {
            case ssExtreme:
                calloutView2.coLabel.textColor = [UIColor redColor];
                break;
            case ssHigh:
                calloutView2.coLabel.textColor = [UIColor orangeColor];
                break;
            case ssMid:
                calloutView2.coLabel.textColor = [UIColor yellowColor];
                break;
            case ssLow:
                calloutView2.coLabel.textColor = [UIColor greenColor];
                break;
            default:
                break;
        }
        StationState stateSo2 = [ann.stationInfo.currentValue stateSo2];
        switch (stateSo2) {
            case ssExtreme:
                calloutView2.so2Label.textColor = [UIColor redColor];
                break;
            case ssHigh:
                calloutView2.so2Label.textColor = [UIColor orangeColor];
                break;
            case ssMid:
                calloutView2.so2Label.textColor = [UIColor yellowColor];
                break;
            case ssLow:
                calloutView2.so2Label.textColor = [UIColor greenColor];
                break;
            default:
                break;
        }
        StationState stateNo2 = [ann.stationInfo.currentValue stateNo2];
        switch (stateNo2) {
            case ssExtreme:
                calloutView2.no2Label.textColor = [UIColor redColor];
                break;
            case ssHigh:
                calloutView2.no2Label.textColor = [UIColor orangeColor];
                break;
            case ssMid:
                calloutView2.no2Label.textColor = [UIColor yellowColor];
                break;
            case ssLow:
                calloutView2.no2Label.textColor = [UIColor greenColor];
                break;
            default:
                break;
        }
        StationState stateO3 = [ann.stationInfo.currentValue stateO3];
        switch (stateO3) {
            case ssExtreme:
                calloutView2.o3Label.textColor = [UIColor redColor];
                break;
            case ssHigh:
                calloutView2.o3Label.textColor = [UIColor orangeColor];
                break;
            case ssMid:
                calloutView2.o3Label.textColor = [UIColor yellowColor];
                break;
            case ssLow:
                calloutView2.o3Label.textColor = [UIColor greenColor];
                break;
            default:
                break;
        }
        StationState statePM = [ann.stationInfo.currentValue stateMP];
        switch (statePM) {
            case ssExtreme:
                calloutView2.pmLabel.textColor = [UIColor redColor];
                break;
            case ssHigh:
                calloutView2.pmLabel.textColor = [UIColor orangeColor];
                break;
            case ssMid:
                calloutView2.pmLabel.textColor = [UIColor yellowColor];
                break;
            case ssLow:
                calloutView2.pmLabel.textColor = [UIColor greenColor];
                break;
            default:
                break;
        }
        
        //[calloutView2 sizeToFit];
        
        //[self animateCalloutAppearance];
        [self addSubview:calloutView2];
    }
    else
    {
        //Remove your custom view...
        [calloutView2 removeFromSuperview];
    }
}

- (void)didAddSubview:(UIView *)subview{
    CustomAnnotation *ann = self.annotation;
    
        if ([[[subview class] description] isEqualToString:@"UICalloutView"]) {
            for (UIView *subsubView in subview.subviews) {
                if ([subsubView class] == [UIImageView class]) {
                    UIImageView *imageView = ((UIImageView *)subsubView);
                    [imageView removeFromSuperview];
                }else if ([subsubView class] == [UILabel class]) {
                    UILabel *labelView = ((UILabel *)subsubView);
                    [labelView removeFromSuperview];
                }
            }
        }
    
}

- (void)animateCalloutAppearance {
    CGFloat scale = 0.001f;
    calloutView2.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -50);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        CGFloat scale = 1.1f;
        calloutView2.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
            CGFloat scale = 0.95;
            calloutView2.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.075 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
                CGFloat scale = 1.0;
                calloutView2.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
            } completion:nil];
        }];
    }];
}

@end
