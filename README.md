## CCActivityIndicatorView

[![](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Cokile/CCActivityIndicatorView/blob/master/Licence)
[![](https://img.shields.io/github/release/Cokile/CCActivityIndicatorView.svg)](https://github.com/Cokile/CCActivityIndicatorView/releases)
[![](http://img.shields.io/cocoapods/v/CCActivityIndicatorView.svg)](http://cocoapods.org/pods/CCActivityIndicatorView)



## Captures

<img src=Captures/capture1.gif width=210 height=372>
<img src=Captures/capture2.gif width=210 height=372>
<img src=Captures/capture3.gif width=210 height=372>
<img src=Captures/capture4.gif width=210 height=372>



## Installation

### Use Cocoapods

Simply add one line to your Podfile:

```
pod 'CCActivityIndicatorView'
```

### Manually 

Add  `CCActivityIndicatorView.h` and `CCActivityIndicatorView.m` to your project.



## Easy to use

`CCActivityIndicatorView` now support four types

* CCIndicatorTypeScalingDots

* CCIndicatorTypeLeadingDots

* CCIndicatorTypeCircle

* CCIndicatorTypeArc


  ​

The default type is `CCIndicatorTypeScalingDots`

```objective-c
#import "CCActivityIndicatorView.h"

// Make sure the frame is square.
self.myactivityIndicatorView = [[CCActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-60, 60, 120, 120)];
self.myactivityIndicatorView.isTheOnlyActiveView = NO;
```

Or you can specify the type

```objective-c
// Make sure the frame is square.

// CCActivityIndicatorView with type CCIndicatorTypeScalingDots
self.activityView = [[CCActivityIndicatorView alloc] initWithFrame:CGRectMake(width/2-60, 60, 120, 120) type:CCIndicatorTypeLeadingDots];

// CCActivityIndicatorView with type CCIndicatorTypeLeadingDots
self.activityView = [[CCActivityIndicatorView alloc] initWithFrame:CGRectMake(width/2-60, 60, 120, 120) type:CCIndicatorTypeLeadingDots];

// CCActivityIndicatorView with type CCIndicatorTypeCircle
self.activityView = [[CCActivityIndicatorView alloc] initWithFrame:CGRectMake(width/2-60, 60, 120, 120) type:CCIndicatorTypeCircle];

// CCActivityIndicatorView with type CCIndicatorTypeArc
self.activityView = [[CCActivityIndicatorView alloc] initWithFrame:CGRectMake(width/2-60, 60, 120, 120) type:CCIndicatorTypeArc];
```



When you want to show the activity indicator view, simply use

```objective-c
// Make sure you have added the activity indicator view as a subview before show it.
[self.view addSubview:self.myactivityIndicatorView];
[self.myactivityIndicatorView show];
```

Then when some tasks have completed,  use

```objective-c
[self.myactivityIndicatorView dismiss];
```



## Customisable

* *color* : Set the backgrond color. The default color is black.


* *borderColor* : Set the background border color. The default background color is black.


* *alpha* : Set the backgrond alpha. The default value is 0.86.


* *borderWidth* : Set the backgrond border width. THe default value is 0.


* *cornerRadius* : Set the background corner radius. The default value is 10.0;


* *indicatorColor* : Set the indicator color. The default color is white.


* *isTheOnlyActiveView* : A boolean value indicates whether the ohter UIViews are user-interactable. The default value is YES.




## Requirement

iOS 8.0 or later



## TODO

* More types of animation 



Any Pull Requests are welcome.

