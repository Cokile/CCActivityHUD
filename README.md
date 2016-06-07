## CCActivityIndicatorView

[![](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Cokile/CCActivityIndicatorView/blob/master/Licence)
[![](https://img.shields.io/github/release/Cokile/CCActivityIndicatorView.svg)](https://github.com/Cokile/CCActivityIndicatorView/releases)
[![](http://img.shields.io/cocoapods/v/CCActivityIndicatorView.svg)](http://cocoapods.org/pods/CCActivityIndicatorView)



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
pod 'CCActivityIndicatorView'
```

### Manually 

Add the .h, .m files in the CCActivityIndicatorView folder to your project.

Add `ImageIO.framework` to your target.



## Easy to use 

```objective-c
#import "CCActivityIndicatorView.h"

self.myactivityIndicatorView = [CCActivityIndicatorView new];

// Show with the default type
[self.myactivityIndicatorView show];
```

Or you can specify the type to show

```objective-c
self.myactivityIndicatorView = [CCActivityIndicatorView new];

// CCActivityIndicatorView with type CCIndicatorTypeScalingDots
[self.myactivityIndicatorView showWithType:CCIndicatorTypeScalingDots];

// CCActivityIndicatorView with type CCIndicatorTypeLeadingDots
[self.myactivityIndicatorView showWithType:CCIndicatorTypeLeadingDots];

// CCActivityIndicatorView with type CCIndicatorTypeCircle
[self.myactivityIndicatorView showWithType:CCIndicatorTypeCircle];

// CCActivityIndicatorView with type CCIndicatorTypeArc
[self.myactivityIndicatorView showWithType:CCIndicatorTypeArc];
```

Or you can even use your own GIF file

```objective-c
self.myactivityIndicatorView = [CCActivityIndicatorView new];

// Show with GIF
[self.myactivityIndicatorView showWithGIFName:@"test.gif"];
```

Then when some tasks have completed,  simply use

```
[self.myactivityIndicatorView dismiss];
```



## Customisable

###  Public properties

```objective-c
// Set public properties before showing it.

// Set the backgrond color. The default color is black.
self.myactivityIndicatorView.backColor = <#UIColor#>;

// Set the background border color. The default background color is black.
self.myactivityIndicatorView.borderColor = <#UIColor#>;

// Set the backgrond border width. THe default value is 0.
self.myactivityIndicatorView.borderWidth = <#CGFloat#>;

// Set the background corner radius. The default value is 10.0;
self.myactivityIndicatorView.cornerRadius = <#CGFloat#>;

// Set the indicator color. The default color is white.
self.myactivityIndicatorView.indicatorColor = <#UIColor#>;

// Set the boolean value that indicates whether the ohter UIViews are user-interactable. The default value is YES.
self.myactivityIndicatorView.isTheOnlyActiveView = <#BOOL#>;

// Set the appear animation type.
self.myactivityIndicatorView.appearAnimationType = <#CCIndicatorAppearAnimationType#>;

//  Set the disappear animation type.
self.myactivityIndicatorView.disappearAnimationType = <#CCIndicatorDisappearAnimationType#>;

// Set the background view type
self.myactivityIndicatorView.backgroundViewType = <#CCIndicatorBackgroundViewType#>;
```

### Animation Type

#### Indicator animation type

```objective-c
typedef NS_ENUM(NSInteger, CCIndicatorType) {
    CCIndicatorTypeScalingDots, // Default type
    CCIndicatorTypeLeadingDots,
    CCIndicatorTypeCircle,
    CCIndicatorTypeArc
};
```
#### Appear animation type

```objective-c
typedef NS_ENUM(NSInteger, CCIndicatorAppearAnimationType) {
    CCIndicatorAppearAnimationTypeSlideFromTop,
    CCIndicatorAppearAnimationTypeSlideFromBottom,
    CCIndicatorAppearAnimationTypeSlideFromLeft,
    CCIndicatorAppearAnimationTypeSlideFromRight,
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
    CCIndicatorDisappearAnimationTypeFadeOut // Default type
};
```

#### Background view type

```objective-c
typedef NS_ENUM(NSInteger, CCIndicatorBackgroundViewType) {
    CCIndicatorBackgroundViewTypeNone,
    CCIndicatorBackgroundViewTypeBlur,
    CCIndicatorBackgroundViewTypeTransparent,
    CCIndicatorBackgroundViewTypeShadow
};
```



## Requirement

iOS 8.0 or later



## Acknowledgement

[uiimage-from-animated-gif](https://github.com/mayoff/uiimage-from-animated-gif) : A UIImage category that loads animated GIFs.



## TODO

* More types of animation



Any Pull Requests are welcome.

