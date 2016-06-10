
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CCActivityHUDIndicatorType) {
    CCActivityHUDIndicatorTypeScalingDots,
    CCActivityHUDIndicatorTypeLeadingDots,
    CCActivityHUDIndicatorTypeMinorArc,
    CCActivityHUDIndicatorTypeDynamicArc,
    CCActivityHUDIndicatorTypeArcInCircle
};

typedef NS_ENUM(NSInteger, CCActivityHUDAppearAnimationType) {
    CCActivityHUDAppearAnimationTypeSlideFromTop,
    CCActivityHUDAppearAnimationTypeSlideFromBottom,
    CCActivityHUDAppearAnimationTypeSlideFromLeft,
    CCActivityHUDAppearAnimationTypeSlideFromRight,
    CCActivityHUDAppearAnimationTypeZoomIn,
    CCActivityHUDAppearAnimationTypeFadeIn
};

typedef NS_ENUM(NSInteger, CCActivityHUDDisappearAnimationType) {
    CCActivityHUDDisappearAnimationTypeSlideToTop,
    CCActivityHUDDisappearAnimationTypeSlideToBottom,
    CCActivityHUDDisappearAnimationTypeSlideToLeft,
    CCActivityHUDDisappearAnimationTypeSlideToRight,
    CCActivityHUDDisappearAnimationTypeZoomOut,
    CCActivityHUDDisappearAnimationTypeFadeOut
};

typedef NS_ENUM(NSInteger, CCActivityHUDOverlayType) {
    CCActivityHUDOverlayTypeNone,
    CCActivityHUDOverlayTypeBlur,
    CCActivityHUDOverlayTypeTransparent,
    CCActivityHUDOverlayTypeShadow
};


@interface CCActivityHUD : UIView

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
@property CCActivityHUDAppearAnimationType appearAnimationType;

/**
 *  Set the animation about how the activity indicator to disappear from the screen.
 */
@property CCActivityHUDAppearAnimationType disappearAnimationType;

/**
 *  Set the type of the background view.
 */
@property CCActivityHUDOverlayType overlayType;




#pragma mark - public methods
/**
 *  Show a HUD in the center of the screen with a specific indicator animation type.
 *
 *  @param type Type for the activity indicator to be shown.
 */
- (void)showWithType:(CCActivityHUDIndicatorType)type;

/**
 *  Show an activity indicator in the center of the screen with the dafault type CCIndicatorTypeScalingDots.
 */
- (void)show;

/**
 *  Show a HUD in the center of the screen with a GIF image.
 *
 *  @param GIFName The GIF's name to be shown.
 */
- (void)showWithGIFName:(NSString *)GIFName;

/**
 *  Show a HUD in the center of the screen with text.
 *
 *  @param text     The text to be shown.
 */
- (void)showWithText:(NSString *)text;

/**
 *  Display some text before dissmissing the view.
 *
 *  @param text The text to be displayed.
 *  @param delay The amount of time to wait before dismiss the view.
 *  @param flip A boolean indicates whether the view will draw vertically flip animation before displaying text.
 *
 *         Note: If you set flip to YES, the value of delay should contain 0.8 second for flip animation.
 */
- (void)dismissWithText:(NSString *)text delay:(CGFloat)delay flip:(BOOL)flip;

/**
 *  Simply dissmiss the view.
 */
- (void)dismiss;

@end
