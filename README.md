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

self.myactivityIndicatorView = [CCActivityIndicatorView new];
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

Then when some tasks have completed,  use

```objective-c
[self.myactivityIndicatorView dismiss];
```



## Customisable

* ~~*color* : Set the backgrond color. The default color is black.~~


* ~~*borderColor* : Set the background border color. The default background color is black.~~


* ~~*alpha* : Set the backgrond alpha. The default value is 0.86.~~


* ~~*borderWidth* : Set the backgrond border width. THe default value is 0.~~


* ~~*cornerRadius* : Set the background corner radius. The default value is 10.0;~~


* ~~*indicatorColor* : Set the indicator color. The default color is white.~~


__NOTE: Properties above are not work in v1.4.0, I am fixing it.__

* *isTheOnlyActiveView* : A boolean value indicates whether the ohter UIViews are user-interactable. The default value is YES.




## Requirement

iOS 8.0 or later



## TODO

* More types of animation 



Any Pull Requests are welcome.

