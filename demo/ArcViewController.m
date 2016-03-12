//
//  ViewController.m
//  test
//
//  Created by Dealjava on 3/12/16.
//  Copyright © 2016 oirignesia. All rights reserved.
//

#import "ArcViewController.h"


@interface ArcViewController ()

@end

@implementation ArcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    segmentValue = 1;
    sliderangleLabel.value = 0.5;
    [self slider:sliderangleLabel];
    
    sliderradiusLabel.value = 0.5;
    [self radius:sliderradiusLabel];
    
    segmentStartValue = 1;
    sliderstartangleLabel.value = 0.5;
    [self startangle:sliderstartangleLabel];
}
-(IBAction)segmentangle:(UISegmentedControl*)sender{
    NSInteger selectedSegment = sender.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        segmentValue = 1;
    }else{
        segmentValue = -1;
    }
    [self slider:sliderangleLabel];
}
-(IBAction)segmentStartAngle:(UISegmentedControl*)sender{
    NSInteger selectedSegment = sender.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        segmentStartValue = 1;
    }else{
        segmentStartValue = -1;
    }
    [self startangle:sliderstartangleLabel];
}

-(IBAction)slider:(UISlider*)sender{
    CGFloat angle = M_PI*sender.value *segmentValue;
    angleLabel.text = [NSString stringWithFormat:@"angle %f",angle];
    drawpath.angle = angle;
}
-(IBAction)radius:(UISlider*)sender{
    CGFloat angle = 200*sender.value;
    radiusLabel.text = [NSString stringWithFormat:@"radius %f",angle];
    drawpath.radius = angle;
}
-(IBAction)startangle:(UISlider*)sender{
    CGFloat angle = (M_PI*2)*sender.value*segmentStartValue;
    startangleLabel.text = [NSString stringWithFormat:@"start angle %f",angle];
    drawpath.startAngle = angle;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
