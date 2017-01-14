
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CCActivityHUDIndicatorType) {
    CCActivityHUDIndicatorTypeScalingDots,
    CCActivityHUDIndicatorTypeLeadingDots,
    CCActivityHUDIndicatorTypeMinorArc,
    CCActivityHUDIndicatorTypeDynamicArc,
    CCActivityHUDIndicatorTypeArcInCircle,
    CCActivityHUDIndicatorTypeSpringBall,
    CCActivityHUDIndicatorTypeScalingBars,
    CCActivityHUDIndicatorTypeTriangleCircle
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
@property CCActivityHUDDisappearAnimationType disappearAnimationType;

/**
 *  Set the type of the background view.
 */
@property CCActivityHUDOverlayType overlayType;

/**
 *  Set the progress of the task, when the task is completed, the value of progess is 1.
 */
@property (nonatomic) CGFloat progress;




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
 *  Show with the user's custom shape and animation
 *
 *  @param shape     The custom indicator shape. The block use a CAShapeLayer object and a CAReplicatorLayer object to draw the indicator shpae.
 *  @param animation The custom indicator animation. The CAAnimationGroup will apply to the shape.
 */
- (void)showWithShape:(void (^)(CAShapeLayer *, CAReplicatorLayer *))shape
            animationGroup:(void (^)(CAAnimationGroup *))animation;

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
 *  @param shimmering A boolean indicates whether apply a shimmering effect to the text.
 */
- (void)showWithText:(NSString *)text shimmering:(BOOL)shimmering;


/**
 *  Update the text shown by showWithText:shimmering: method.
 *
 *  @param text The text to be updated.
 *  @param shimmering A boolean indicates whether apply a shimmering effect to the text.
 */
- (void)updateText:(NSString *)text shimmering:(BOOL)shimmering;

/**
 *  Show a HUD with a circle progress bar.
 */
- (void)showWithProgress;

/**
 *  Display some text before dissmissing the view.
 *
 *  @param text The text to be displayed.
 *  @param delay The amount of time to wait before dismiss the view.
 *  @param success A boolean indicates to display tick or cross
 *
 */
- (void)dismissWithText:(NSString *)text delay:(CGFloat)delay success:(BOOL)success;

/**
 *  Simply dissmiss the view.
 */
- (void)dismiss;

@end
