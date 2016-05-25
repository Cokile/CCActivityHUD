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
    self.activityView.isTheOnlyActiveView = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender {
    [self.view addSubview:self.activityView];
    [self.activityView show];
}


- (IBAction)dismiss:(id)sender {
    [self.activityView dismiss];
}

@end
