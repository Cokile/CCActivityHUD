
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CCIndicatorType) {
    CCIndicatorTypeScalingDots,
    CCIndicatorTypeLeadingDots,
    //CCIndicatorTypeCircle,
    //CCIndicatorTypeArc
};



@interface CCActivityIndicatorView : UIView

#pragma mark - properties
/**
 *  Set the backgrond color.
    
    The default color is black.
 */
@property (strong, nonatomic) UIColor *color;

/**
 *  Set the background border color.
 
    The default background color is black.
 */
@property (strong, nonatomic) UIColor *borderColor;

/**
 *  Set the backgrond alpha.
    
    The default value is 0.86.
 */
@property (nonatomic) CGFloat alpha;

/**
 *  Set the backgrond border width.
 
    THe default value is 0.
 */
@property (nonatomic) CGFloat borderWidth;

/**
 *  Set the background corner radius.
 
    The default value is 10.0;
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




#pragma mark - public methods
/**
 *  Convenient initialization
 *
 *  @param frame The frame of the indicator view.
 *  @param type  The type of the indicator view
 *
 *  @return A CCActivityIndicatorView with a designated type
 */
- (id)initWithFrame:(CGRect)frame type:(CCIndicatorType)type;

/**
 *  Show the view in the screen.
 
    Note: Make sure the view is moved to superview before calling this method.
 */
- (void)show;

/**
 *  Dissmiss the view.
 */
- (void)dismiss;

@end
