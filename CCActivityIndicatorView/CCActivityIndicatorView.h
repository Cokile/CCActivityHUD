
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CCIndicatorType) {
    CCIndicatorTypeScalingDots,
    CCIndicatorTypeLeadingDots,
    CCIndicatorTypeCircle,
    CCIndicatorTypeArc
};

typedef NS_ENUM(NSInteger, CCIndicatorAppearAnimationType) {
    CCIndicatorAppearAnimationTypeSlideFromTop,
    CCIndicatorAppearAnimationTypeSlideFromBottom,
    CCIndicatorAppearAnimationTypeSlideFromLeft,
    CCIndicatorAppearAnimationTypeSlideFromRight,
    CCIndicatorAppearAnimationTypeZoomIn,
    CCIndicatorAppearAnimationTypeFadeIn
};

typedef NS_ENUM(NSInteger, CCIndicatorDisappearAnimationType) {
    CCIndicatorDisappearAnimationTypeSlideToTop,
    CCIndicatorDisappearAnimationTypeSlideToBottom,
    CCIndicatorDisappearAnimationTypeSlideToLeft,
    CCIndicatorDisappearAnimationTypeSlideToRight,
    CCIndicatorDisappearAnimationTypeZoomOut,
    CCIndicatorDisappearAnimationTypeFadeOut
};

typedef NS_ENUM(NSInteger, CCIndicatorBackgroundViewType) {
    CCIndicatorBackgroundViewTypeNone,
    CCIndicatorBackgroundViewTypeBlur,
    CCIndicatorBackgroundViewTypeTransparent,
    CCIndicatorBackgroundViewTypeShadow
};


@interface CCActivityIndicatorView : UIView

#pragma mark - properties
/**
 *  Set the backgrond color.
    
    The default color is black.
 */
@property (strong, nonatomic) UIColor *backColor;

/**
 *  Set the background border color.
 
    The default background color is black.
 */
@property (strong, nonatomic) UIColor *borderColor;

/**
 *  Set the backgrond border width.
 
    THe default value is 0
 */
@property (nonatomic) CGFloat borderWidth;

/**
 *  Set the background corner radius.
 
    The default value is 10.0
 */
@property (nonatomic) CGFloat cornerRadius;

/**
 *  Set the indicator color.
 
    The default color is light grey.
 */
@property (strong, nonatomic) UIColor *indicatorColor;

/**
 *  A boolean value indicates whether the ohter UIViews are user-interactable.
 
    The default value is YES.
 */
@property (nonatomic) BOOL isTheOnlyActiveView;

/**
 *  Set the animation about how the activity indicator to appear to the screen.
 */
@property CCIndicatorAppearAnimationType appearAnimationType;

/**
 *  Set the animation about how the activity indicator to disappear from the screen.
 */
@property CCIndicatorAppearAnimationType disappearAnimationType;

/**
 *  Set the type of the background view.
 */
@property CCIndicatorBackgroundViewType backgroundViewType;




#pragma mark - public methods
/**
 *  Show an activity indicator in the center of the screen with a specific type.
 *
 *  @param type Type for the activity indicator to be shown.
 */
- (void)showWithType:(CCIndicatorType)type;

/**
 *  Show an activity indicator in the center of the screen with the dafault type CCIndicatorTypeScalingDots.
 */
- (void)show;

/**
 *  Show with a GIF image.
 *
 *  @param GIFName The GIF's name to be shown.
 */
- (void)showWithGIFName:(NSString *)GIFName;

/**
 *  Display some text before dissmissing the view.
 *
 *  @param text The text to be displayed.
 *  @param delay The amount of time to wait before dismiss the view.
 */
- (void)dismissWithText:(NSString *)text delay:(CGFloat)delay;

/**
 *  Simply dissmiss the view.
 */
- (void)dismiss;

@end
