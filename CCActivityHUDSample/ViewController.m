//
//  ViewController.m
//  CCActivityIndicatorViewSample
//
//  Created by Kelvin on 5/25/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "ViewController.h"
#import <CCActivityHUD/CCActivityHUD.h>

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
    
    //self.activityHUD.overlayType = CCActivityHUDOverlayTypeBlur;
    //self.activityHUD.overlayType = CCActivityHUDOverlayTypeTransparent;
    //self.activityHUD.overlayType = CCActivityHUDOverlayTypeShadow;
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
    //[self.activityHUD showWithType:CCActivityHUDIndicatorTypeSpringBall];
    //[self.activityHUD showWithType:CCActivityHUDIndicatorTypeScalingBars];
    //[self.activityHUD showWithType:CCActivityHUDIndicatorTypeTriangleCircle];
    
    /*
    [self.activityHUD showWithShape:^(CAShapeLayer *shapeLayer, CAReplicatorLayer *replicatorLayer) {
        shapeLayer.frame = CGRectMake(0, 0, 20, 20);
        shapeLayer.position = CGPointMake(self.activityHUD.frame.size.width/2, self.activityHUD.frame.size.height/2);
        shapeLayer.backgroundColor = [UIColor whiteColor].CGColor;
        shapeLayer.cornerRadius = 10;
    } animation:^(CAAnimationGroup *animationGroup) {
        CABasicAnimation *animation1 = [[CABasicAnimation alloc] init];
        animation1.keyPath  = @"transform.scale";
        animation1.fromValue = [NSNumber numberWithFloat:1.0];
        animation1.toValue = [NSNumber numberWithFloat:0.5];
        animation1.duration = 2.0;
        
        CABasicAnimation *animation2 = [[CABasicAnimation alloc] init];
        animation2.keyPath  = @"transform.scale";
        animation2.beginTime = 2.0;
        animation2.fromValue = [NSNumber numberWithFloat:0.5];
        animation2.toValue = [NSNumber numberWithFloat:1.0];
        animation2.duration = 2.0;
        
        animationGroup.duration = 4.0;
        animationGroup.repeatCount = INFINITY;
        animationGroup.animations = @[animation1, animation2];
    }];
   */
    
    //[self.activityHUD showWithGIFName:@"test.gif"];
    
    //[self.activityHUD showWithText:@"Now loading..." shimmering:YES];
}

- (IBAction)dismiss:(id)sender {
    [self.activityHUD dismiss];
    
    //[self.activityHUD dismissWithText:@"This is a sample dismiss text" delay:0.7 success:NO];
}

@end
