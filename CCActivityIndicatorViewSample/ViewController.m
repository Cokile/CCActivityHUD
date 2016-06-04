//
//  ViewController.m
//  CCActivityIndicatorViewSample
//
//  Created by Kelvin on 5/25/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "ViewController.h"
#import "CCActivityIndicatorView.h"

@interface ViewController ()

@property (strong, nonatomic) CCActivityIndicatorView *activityView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activityView = [CCActivityIndicatorView new];
    self.activityView.isTheOnlyActiveView = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender {
    [self.activityView show];
    
    //[self.activityView showWithType:CCIndicatorTypeScalingDots];
    //[self.activityView showWithType:CCIndicatorTypeLeadingDots];
    //[self.activityView showWithType:CCIndicatorTypeCircle];
    //[self.activityView showWithType:CCIndicatorTypeArc];
}

- (IBAction)dismiss:(id)sender {
    [self.activityView dismiss];
}

@end
