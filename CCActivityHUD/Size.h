
#ifndef Size_h
#define Size_h

#define Screen                    [UIScreen mainScreen]

// Frame
// Common marco
#define FrameFor(view)            (view).frame
#define FrameSizeFor(view)        (view).frame.size
#define FrameWidthFor(view)       (view).frame.size.width
#define FrameHeightFor(view)      (view).frame.size.height
#define FrameOriginFor(view)      (view).frame.origin
#define FrameOriginX(view)        (view).frame.origin.x
#define FrameOriginY(view)        (view).frame.origin.y
#define FrameCenterFor(view)      (view).center
#define FrameCenterXFor(view)     (view).center.x
#define FrameCenterYFor(view)     (view).center.y


// Convenient marco
#define ViewFrame                 FrameFor(self)
#define ViewFrameSize             FrameSizeFor(self)
#define ViewFrameWidth            FrameWidthFor(self)
#define ViewFrameHeight           FrameHeightFor(self)
#define ViewFrameOrigin           FrameOriginFor(self)
#define ViewFrameX                FrameOriginX(self)
#define ViewFrameY                FrameOriginY(self)
#define ViewFrameCenter           FrameCenterFor(self)
#define ViewFrameCenterX          FrameCenterXFor(self)
#define ViewFrameCenterY          FrameCenterYFor(self)


// Bounds
// Common marco
#define BoundsFor(view)           (view).bounds
#define BoundsSizeFor(view)       (view).bounds.size
#define BoundsWidthFor(view)      (view).bounds.size.width
#define BoundsHeightFor(view)     (view).bounds.size.height
#define BoundsOriginFor(view)     (view).bounds.origin
#define BoundsOriginXFor(view)    (view).bounds.origin.x
#define BoundsOriginYFor(view)    (view).bounds.origin.y
#define BoundsCenterXFor(view)    BoundsWidthFor(view)/2
#define BoundsCenterYFor(view)    BoundsHeightFor(view)/2
#define BoundsCenterFor(view)     CGPointMake(BoundsCenterXFor(view), BoundsCenterYFor(view))


// Convenient marco
#define ViewBounds                BoundsFor(self)
#define ViewBoundsSize            BoundsSizeFor(self)
#define ViewBoundsWidth           BoundsWidthFor(self)
#define ViewBoundsHeight          BoundsHeightFor(self)
#define ViewBoundsOrigin          BoundsOriginFor(self)
#define ViewBoundsX               BoundsOriginXFor(self)
#define ViewBoundsY               BoundsOriginYFor(self)
#define ViewBoundsCenterX         BoundsWidthFor(self)/2
#define ViewBoundsCenterY         BoundsHeightFor(self)/2
#define ViewBoundsCenter          CGPointMake(BoundsCenterXFor(self), BoundsCenterYFor(self))

#endif
