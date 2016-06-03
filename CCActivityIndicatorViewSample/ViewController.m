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
    
    CGFloat width = self.view.frame.size.width;
    
    self.activityView = [[CCActivityIndicatorView alloc] initWithFrame:CGRectMake(width/2-60, 60, 120, 120)];
    
    //self.activityView = [[CCActivityIndicatorView alloc] initWithFrame:CGRectMake(width/2-60, 60, 120, 120) type:CCIndicatorTypeScalingDots];
    //self.activityView = [[CCActivityIndicatorView alloc] initWithFrame:CGRectMake(width/2-60, 60, 120, 120) type:CCIndicatorTypeLeadingDots];
    //self.activityView = [[CCActivityIndicatorView alloc] initWithFrame:CGRectMake(width/2-60, 60, 120, 120) type:CCIndicatorTypeCircle];
    //self.activityView = [[CCActivityIndicatorView alloc] initWithFrame:CGRectMake(width/2-60, 60, 120, 120) type:CCIndicatorTypeArc];
    
    self.activityView.isTheOnlyActiveView = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender {
    [self.activityView showInView:self.view];
}


- (IBAction)dismiss:(id)sender {
    [self.activityView dismiss];
}

@end
