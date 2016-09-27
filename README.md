## CCActivityHUD

[![](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Cokile/CCActivityHUD/blob/master/Licence)
[![](https://img.shields.io/github/release/Cokile/CCActivityHUD.svg)](https://github.com/Cokile/CCActivityHUD/releases)
[![](https://img.shields.io/cocoapods/v/CCActivityHUD.svg)](https://img.shields.io/cocoapods/v/CCActivityHUD.svg)
[![](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

From v2.0.0, I rename it from __CCActivityIndicatorView__ to __CCActivityHUD__. if you have forked the project before I rename it, you should run the command below to make a Pull Request correctly.

```
git remote set-url upstream git@github.com:Cokile/CCActivityHUD.git
```



## Captures

<img src=Captures/capture1.gif width=210 height=372>
<img src=Captures/capture2.gif width=210 height=372>
<img src=Captures/capture3.gif width=210 height=372>
<img src=Captures/capture4.gif width=210 height=372>
<img src=Captures/capture5.gif width=210 height=372>
<img src=Captures/capture6.gif width=210 height=372>

## Installation

### Cocoapods

```ruby
pod 'CCActivityHUD'
```

__Note__: If you have used `pod 'CCActivityIndicatorView'` in your Podfile, just replace it with  `pod 'CCActivityHUD'` to update the pod.

### Carthage

```ruby
github "Cokile/CCActivityHUD"
```

### Manually 

Add all the files in the CCActivityHUD folder to your project.



## Easy to use 

```objective-c
#import <CCActivityHUD/CCActivityHUD.h>

self.activityHUD = [CCActivityIndicatorView new];

// Show with the default type.
[self.myactivityHUD show];
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	// Your task code here
	dispatch_async(dispatch_get_main_queue(), ^{
    	// When the task has completed.
        [self.activityHUD dismiss];
        });
});
```

#### More options

- Instead of using `show` to show the default indicator animation type,  you can specify the type to show (To see what tpyes you can use, see [Indicator animation type section](https://github.com/Cokile/CCActivityHUD#indicator-animation-type)).

```objective-c
[self.activityHUD showWithType:CCActivityHUDIndicatorTypeDynamicArc];
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	// Your task code here
	dispatch_async(dispatch_get_main_queue(), ^{
    	// When the task has completed.
        [self.activityHUD dismiss];
        });
});
```

__Note:__ You should not call `showWithType:` within `viewDidLoad`, The Animation will not work! Instead, show it within `viewWillAppear` or `viewDidAppear`.

- Do not like the provided indicator animation?  `CCActivityHUD` supports GIF too. Just grab a GIF you like and show with it. __(Remember to add `ImageIO.framework` to your target)__

```objective-c
[self.activityHUD showWithGIFName:@"test.gif"];
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	// Your task code here
	dispatch_async(dispatch_get_main_queue(), ^{
    	// When the task has completed.
        [self.activityHUD dismiss];
        });
});
```

- Or just want to show some text to users?  `CCActivityHUD`  also supports showing text, even with shimmering visual effect. More over, you can also update the text to tell user the current state of the task.

```objective-c
[self.activityHUD showWithText:@"Now loading..." shimmering:YES];
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	// Your tasks code here.
    // ...
    dispatch_async(dispatch_get_main_queue(), ^{
    	// When part of the task has completed.
        [self.activityHUD updateWithText:@"step #1 completed" shimmering:YES];
        });
    // You tasks code here.
    // ...
	dispatch_async(dispatch_get_main_queue(), ^{
    	// When all the tasks have completed.
        [self.activityHUD dismiss];
        });
});
```
- `CCActivityHUD` also support progress. Use `showWithProgress` and perform your task code. In the call back method, update UI in the main thread by  `self.activityHUD.progress = completedTaskAmount/totalTaskAmount`, When all the tasks have completed, use`[self.activityHUD dismiss]`.


- Last but not least, you sometimes need to show some text to users as a feedback when a task has completed rather than simply dismiss a HUD. `CCActivityHUD` also support it.

```objective-c
// Set success to NO will show a cross, and vice versa, YES means showing a tick.
// If you set the text to nil, self.activityHUD will only show a tick or cross according to the success parameter.
[self.activityHUD dismissWithText:@"This is a sample dismiss text" delay:0.7 success:NO]
```



## Customisable

###  Public properties

```objective-c
// Set public properties before showing it.

// Set the backgrond color. The default color is black.
self.activityHUD.backColor = <#UIColor#>;

// Set the background border color. The default background color is black.
self.activityHUD.borderColor = <#UIColor#>;

// Set the backgrond border width. THe default value is 0.
self.activityHUD.borderWidth = <#CGFloat#>;

// Set the background corner radius. The default value is 5.0;
self.activityHUD.cornerRadius = <#CGFloat#>;

// Set the indicator color. The default color is white.
self.activityHUD.indicatorColor = <#UIColor#>;

// Set the boolean value that indicates whether ohter UIViews are user-interactable. The default value is YES.
self.activityHUD.isTheOnlyActiveView = <#BOOL#>;

// Set the appear animation type.
self.activityHUD.appearAnimationType = <#CCActivityHUDAppearAnimationType#>;

//  Set the disappear animation type.
self.activityHUD.disappearAnimationType = <#CCActivityHUDAppearAnimationType#>;

// Set the overlay type
self.activityHUD.overlayType = <#CCActivityHUDOverlayType#>;
```

### Animation Type

#### Indicator animation type

```objective-c
typedef NS_ENUM(NSInteger, CCActivityHUDIndicatorType) {
    CCActivityHUDIndicatorTypeScalingDots, // Default type
    CCActivityHUDIndicatorTypeLeadingDots,
    CCActivityHUDIndicatorTypeMinorArc,
    CCActivityHUDIndicatorTypeDynamicArc,
    CCActivityHUDIndicatorTypeArcInCircle,
    CCActivityHUDIndicatorTypeSpringBall,
    CCActivityHUDIndicatorTypeScalingBars,
	CCActivityHUDIndicatorTypeTriangleCircle
};
```
#### Appear animation type

```objective-c
typedef NS_ENUM(NSInteger, CCActivityHUDAppearAnimationType) {
    CCActivityHUDAppearAnimationTypeSlideFromTop,
    CCActivityHUDAppearAnimationTypeSlideFromBottom,
    CCActivityHUDAppearAnimationTypeSlideFromLeft,
    CCActivityHUDAppearAnimationTypeSlideFromRight,
    CCActivityHUDAppearAnimationTypeZoomIn,
    CCActivityHUDAppearAnimationTypeFadeIn // Default type
};
```
#### Disappear animation type

```objective-c
typedef NS_ENUM(NSInteger, CCActivityHUDDisappearAnimationType) {
    CCActivityHUDDisappearAnimationTypeSlideToTop,
    CCActivityHUDDisappearAnimationTypeSlideToBottom,
    CCActivityHUDDisappearAnimationTypeSlideToLeft,
    CCActivityHUDDisappearAnimationTypeSlideToRight,
    CCActivityHUDDisappearAnimationTypeZoomOut,
    CCActivityHUDDisappearAnimationTypeFadeOut // Default type
};
```
#### Overlay type

```objective-c
typedef NS_ENUM(NSInteger, CCActivityHUDOverlayType) {
    CCActivityHUDOverlayTypeNone, // Default type
    CCActivityHUDOverlayTypeBlur,
    CCActivityHUDOverlayTypeTransparent,
    CCActivityHUDOverlayTypeShadow
};
```
#### Custom indicator animation

From v.2.1.1, You can customize the indicator shape and indicator animation.

```objective-c
[self.activityHUD showWithShape:^(CAShapeLayer *shapeLayer, CAReplicatorLayer *layer) {
    shapeLayer.frame = CGRectMake(0, 0, 20, 20);
    shapeLayer.position = CGPointMake(self.activityHUD.frame.size.width/2, self.activityHUD.frame.size.height/2);
    shapeLayer.backgroundColor = [UIColor whiteColor].CGColor;
    shapeLayer.cornerRadius = 10;
} animationGroup:^(CAAnimationGroup *animationGroup) {
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
```

* `shapeLayer` is used to draw indicator shape. You can use it with `UIBezierPath` draw more complicated shape. For more details about `CAShapeLayer` and `UIBezierPath` you can visit [ CAShapeLayer Class Reference](https://developer.apple.com/library/ios/documentation/GraphicsImaging/Reference/CAShapeLayer_class/) and [UIBezierPath Class Reference](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIBezierPath_class/).
* `replicatorLayer` can creates a specified number of copies of `shapeLayer`. It is the superlayer of `shapeLayer`. For more details about `CAReplicatorLayer` you can visit [CAReplicatorLayer Class Reference](https://developer.apple.com/library/ios/documentation/GraphicsImaging/Reference/CAReplicatorLayer_class/).
* `animationGroup` is the animation to be applied to `shapeLayer`. For more details about `CAAnimationGroup` you can visit [CAAnimationGroup Class Reference](https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CAAnimationGroup_class/).

__Note:__ You should also not call `showWithShape: AnimationGroup:` within `viewDidLoad`, The Animation will not work! Instead, show it within `viewWillAppear` or `viewDidAppear`.



## Requirement

- iOS 8.0 or later
- ARC



## Acknowledgement

[uiimage-from-animated-gif](https://github.com/mayoff/uiimage-from-animated-gif) : A UIImage category that loads animated GIFs. It provides me with the awesome API to integrate GIF into `CCActivityHUD` with few efforts.



## TODO

* More types of animation


Any Pull Requests and issues are welcome. 
