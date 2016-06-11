## CCActivityHUD

[![](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Cokile/CCActivityIndicatorView/blob/master/Licence)
[![](https://img.shields.io/github/release/Cokile/CCActivityIndicatorView.svg)](https://github.com/Cokile/CCActivityIndicatorView/releases)

From v2.0.0, I rename it from __CCActivityIndicatorView__ to __CCActivityHUD__. if you have forked the project bofore I rename it, you should run the command below to make a Pull Request correctly.

```
git remote set-url origin git@github.com:Cokile/CCActivityHUD.git
```



## Captures

<img src=Captures/capture1.gif width=210 height=372>
<img src=Captures/capture2.gif width=210 height=372>
<img src=Captures/capture3.gif width=210 height=372>
<img src=Captures/capture4.gif width=210 height=372>
<img src=Captures/capture5.gif width=210 height=372>



## Installation

### Use Cocoapods

Simply add one line to your Podfile:

```
pod 'CCActivityHUD'
```

__Note__: If you have used `pod 'CCActivityIndicatorView'` in your Podfile, just replace it with the `pod 'CCActivityHUD'` to update the pod.

### Manually 

Add the all the files in the CCActivityHUD folder to your project.

Add `ImageIO.framework` to your target.



## Easy to use 

```objective-c
#import "CCActivityIndicatorView.h"

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

__Note:__ You should not use `showWithType:` within `viewDidLoad`, The Animation will not work! Instead, show it within `viewWillAppear` or `viewDidAppear`.

- Do not like the provided indicator animation?  `CCActivityHUD` supports GIF. Just grab a GIF you like and show with it.

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

- Just want to show some text to users?  `CCActivityHUD`  also supports showing text with shimmering visual effect.

```objective-c
[self.activityHUD showWithText:@"Now loading..." shimmering:YES];
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	// Your task code here
	dispatch_async(dispatch_get_main_queue(), ^{
    	// When the task has completed.
        [self.activityHUD dismiss];
        });
    });
```

- `CCActivityHUD` also support progress. Use `showWithProgress` and perform your task code. In the call back method, update UI in the main thread by  `self.activityHUD.progress = completedTaskAmount/totalTaskAmount`, When all the tasks have completed, use`[self.activityHUD dismiss]`.


- Last but not least, you sometimes need to show some text to users as a feedback rather than simply dismiss a HUD. `CCActivityHUD` also support it.

```objective-c
// Set success to NO will show a cross, and vice versa, YES means showing a tick.
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

// Set the boolean value that indicates whether the ohter UIViews are user-interactable. The default value is YES.
self.activityHUD.isTheOnlyActiveView = <#BOOL#>;

// Set the appear animation type.
self.activityHUD.appearAnimationType = <#CCActivityHUDAppearAnimationType#>;

//  Set the disappear animation type.
self.activityHUD.disappearAnimationType = <#CCActivityHUDAppearAnimationType#>;

// Set the background view type
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
    CCActivityHUDIndicatorTypeArcInCircle
};
```
#### Appear animation type

```objective-c
typedef NS_ENUM(NSInteger, CCIndicatorAppearAnimationType) {
    CCIndicatorAppearAnimationTypeSlideFromTop,
    CCIndicatorAppearAnimationTypeSlideFromBottom,
    CCIndicatorAppearAnimationTypeSlideFromLeft,
    CCIndicatorAppearAnimationTypeSlideFromRight,
    CCIndicatorAppearAnimationTypeZoomIn,
    CCIndicatorAppearAnimationTypeFadeIn // Default type
};
```
#### Disappear animation type

```objective-c
typedef NS_ENUM(NSInteger, CCIndicatorDisappearAnimationType) {
    CCIndicatorDisappearAnimationTypeSlideToTop,
    CCIndicatorDisappearAnimationTypeSlideToBottom,
    CCIndicatorDisappearAnimationTypeSlideToLeft,
    CCIndicatorDisappearAnimationTypeSlideToRight,
  	CCIndicatorDisappearAnimationTypeZoomOut,
    CCIndicatorDisappearAnimationTypeFadeOut // Default type
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



## Requirement

iOS 8.0 or later



## Acknowledgement

[uiimage-from-animated-gif](https://github.com/mayoff/uiimage-from-animated-gif) : A UIImage category that loads animated GIFs. It provides me with the awesome API to integrate GIF into `CCActivityHUD`.



## TODO

* More types of animation


Any Pull Requests are welcome. 
