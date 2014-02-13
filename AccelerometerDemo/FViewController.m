//
//  FViewController.m
//  AccelerometerDemo
//
//  Created by lieyunye on 2/13/14.
//  Copyright (c) 2014 lieyunye. All rights reserved.
//

#import "FViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface FViewController ()
{
    CMMotionManager *motionManager;
}
@end

@implementation FViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval=1.0/10.0;
    if ([motionManager isAccelerometerAvailable]) {
        NSOperationQueue *que = [[NSOperationQueue alloc] init];
        [motionManager startAccelerometerUpdatesToQueue:que withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            [self performSelectorOnMainThread:@selector(onMainThread:)
                                   withObject:accelerometerData waitUntilDone:NO];
        }];
    }
}

- (void)onMainThread:(CMAccelerometerData *)accelerometerData{
    NSLog(@"X = %.04f, Y = %.04f, Z = %.04f",accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z);
    
    if (fabs(accelerometerData.acceleration.y) < 0.5 && fabs(accelerometerData.acceleration.z) < 0.6) {
        self.yLabel.text = @"横屏 ";
    }
    if (fabs(accelerometerData.acceleration.y) > 0.8 && fabs(accelerometerData.acceleration.z) < 0.6) {
        self.yLabel.text = @"竖屏 ";
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
