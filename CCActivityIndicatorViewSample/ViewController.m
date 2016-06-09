//
//  ViewController.m
//  CCActivityIndicatorViewSample
//
//  Created by Kelvin on 5/25/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "ViewController.h"
#import "CCActivityHUD.h"

@interface ViewController ()

@property (strong, nonatomic) CCActivityHUD *activityHUD;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activityHUD = [CCActivityHUD new];
    self.activityHUD.isTheOnlyActiveView = NO;
    //self.activityHUD.alpha = 0.4;
    //self.activityHUD.cornerRadius = 20.0;
    //self.activityHUD.borderWidth = 3.0;
    //self.activityHUD.borderColor= [UIColor greenColor];
    //self.activityHUD.backColor = [UIColor redColor];
    //self.activityHUD.indicatorColor = [UIColor blueColor];
    
    //self.activityHUD.appearAnimationType = CCActivityHUDAppearAnimationTypeSlideFromTop;
    //self.activityHUD.appearAnimationType = CCActivityHUDAppearAnimationTypeSlideFromBottom;
    //self.activityHUD.appearAnimationType = CCActivityHUDAppearAnimationTypeSlideFromLeft;
    //self.activityHUD.appearAnimationType = CCActivityHUDAppearAnimationTypeSlideFromRight;
    //self.activityHUD.appearAnimationType = CCActivityHUDAppearAnimationTypeZoomIn;
    
    //self.activityHUD.disappearAnimationType = CCActivityHUDDisappearAnimationTypeSlideToTop;
    //self.activityHUD.disappearAnimationType = CCActivityHUDDisappearAnimationTypeSlideToBottom;
    //self.activityHUD.disappearAnimationType = CCActivityHUDDisappearAnimationTypeSlideToLeft;
    //self.activityHUD.disappearAnimationType = CCActivityHUDDisappearAnimationTypeSlideToRight;
    //self.activityHUD.disappearAnimationType = CCActivityHUDDisappearAnimationTypeZoomOut;
    
    //self.activityHUD.backgroundViewType = CCActivityHUDBackgroundViewTypeBlur;
    //self.activityHUD.backgroundViewType = CCActivityHUDBackgroundViewTypeTransparent;
    //self.activityHUD.backgroundViewType = CCActivityHUDBackgroundViewTypeShadow;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender {
    [self.activityHUD show];
    
    //[self.activityHUD showWithType:CCActivityHUDIndicatorTypeScalingDots];
    //[self.activityHUD showWithType:CCActivityHUDIndicatorTypeLeadingDots];
    //[self.activityHUD showWithType:CCActivityHUDIndicatorTypeMinorArc];
    //[self.activityHUD showWithType:CCActivityHUDIndicatorTypeDynamicArc];
    //[self.activityHUD showWithType:CCActivityHUDIndicatorTypeArcInCircle];
    
    //[self.activityHUD showWithGIFName:@"test.gif"];
}

- (IBAction)dismiss:(id)sender {
    [self.activityHUD dismiss];
    
    //[self.activityHUD dismissWithText:@"This is a sample dismiss text" delay:1.3 flip:YES];
}

@end
