## CCActivityIndicatorView

[![](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Cokile/CCActivityIndicatorView/blob/master/Licence)
[![](https://img.shields.io/github/release/Cokile/CCActivityIndicatorView.svg)](https://github.com/Cokile/CCActivityIndicatorView/releases)



## Capture

<img src=Captures/capture1.gif width=210 height=372>



## Installation

Manually add `CCActivityIndicatorView.h` and `CCActivityIndicatorView.m` to your project.

I will add support for Cocoapods later.



## Easy to use

```objective-c
#import "CCActivityIndicatorView.h"

self.myactivityIndicatorView = [[CCActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-60, 60, 120, 120)];
self.myactivityIndicatorView.isTheOnlyActiveView = NO;
```

When you want to show the activity indicator view, simply use

```objective-c
// Make sure you have added the activity indicator view as a subview before show it.
[self.view addSubview:self.myactivityIndicatorView];
[self.myactivityIndicatorView show];
```

Then when some task has completed,  use

```objective-c
[self.myactivityIndicatorView dismiss]
```



## Customisable

* *color*: Set the backgrond color. The default color is black.


* *borderColor*: Set the background border color. The default background color is black.


* *alpha*: Set the backgrond alpha. The default value is 0.86.


* *borderWidth*: Set the backgrond border width. THe default value is 0.


* *cornerRadius*: Set the background corner radius. The default value is 10.0;


* *indicatorColor*: Set the indicator color. The default color is light grey.


* *indicatorBorderColor*: Set the indicator border color. The default color is white.


* *isTheOnlyActiveView*: A boolean value indicates whether the ohter UIViews are user-interactable. The default value is YES.



## TODO

* More kinds of animation 
* Support for Cocoapods

Any Pull Requests are welcome.

