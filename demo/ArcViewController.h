//
//  ViewController.h
//  test
//
//  Created by Dealjava on 3/12/16.
//  Copyright © 2016 oirignesia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "drawPath.h"

@interface ArcViewController : UIViewController
{
    __weak IBOutlet drawPath *drawpath;
    __weak IBOutlet UISegmentedControl *segmentAngle;
    int segmentValue;
    __weak IBOutlet UILabel *angleLabel;
    __weak IBOutlet UISlider *sliderangleLabel;
    
    __weak IBOutlet UILabel *startangleLabel;
    int segmentStartValue;
    __weak IBOutlet UISlider *sliderstartangleLabel;
    
    __weak IBOutlet UILabel *radiusLabel;
    __weak IBOutlet UISlider *sliderradiusLabel;
    
}

@end

