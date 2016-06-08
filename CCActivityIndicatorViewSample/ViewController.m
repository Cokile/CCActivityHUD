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
    //self.activityView.alpha = 0.4;
    //self.activityView.cornerRadius = 20.0;
    //self.activityView.borderWidth = 3.0;
    //self.activityView.borderColor= [UIColor greenColor];
    //self.activityView.backColor = [UIColor redColor];
    //self.activityView.indicatorColor = [UIColor blueColor];
    
    //self.activityView.appearAnimationType = CCIndicatorAppearAnimationTypeSlideFromTop;
    //self.activityView.appearAnimationType = CCIndicatorAppearAnimationTypeSlideFromBottom;
    //self.activityView.appearAnimationType = CCIndicatorAppearAnimationTypeSlideFromLeft;
    //self.activityView.appearAnimationType = CCIndicatorAppearAnimationTypeSlideFromRight;
    //self.activityView.appearAnimationType = CCIndicatorAppearAnimationTypeZoomIn;
    
    //self.activityView.disappearAnimationType = CCIndicatorDisappearAnimationTypeSlideToTop;
    //self.activityView.disappearAnimationType = CCIndicatorDisappearAnimationTypeSlideToBottom;
    //self.activityView.disappearAnimationType = CCIndicatorDisappearAnimationTypeSlideToLeft;
    //self.activityView.disappearAnimationType = CCIndicatorDisappearAnimationTypeSlideToRight;
    //self.activityView.disappearAnimationType = CCIndicatorDisappearAnimationTypeZoomOut;
    
    //self.activityView.backgroundViewType = CCIndicatorBackgroundViewTypeBlur;
    //self.activityView.backgroundViewType = CCIndicatorBackgroundViewTypeTransparent;
    //self.activityView.backgroundViewType = CCIndicatorBackgroundViewTypeShadow;
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
    
    //[self.activityView showWithGIFName:@"test.gif"];
}

- (IBAction)dismiss:(id)sender {
    [self.activityView dismiss];
}

@end
