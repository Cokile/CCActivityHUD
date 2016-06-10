#import "CCActivityHUD.h"
#import "UIImage+animatedGIF.h"
#import "Size.h"

#define DURATION_BASE 0.7
#define TEXT_WIDTH BoundsWidthFor(Screen)/2.5
#define TEXT_FONT_SIZE 14

@interface CCActivityHUD ()

@property (strong, nonatomic) UIView *overlay;
@property (strong, nonatomic) CAReplicatorLayer *replicatorLayer;
@property (strong, nonatomic) CAShapeLayer *indicatorCAShapeLayer;
@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIColor *updatedColor;
@property CCActivityHUDIndicatorType currentTpye;
@property BOOL useIndicator;
@property BOOL useProgress;

@end

@implementation CCActivityHUD

#pragma mark - custom accessors
- (void)setBackColor:(UIColor *)backColor {
    if (backColor !=self.backgroundColor) {
        self.backgroundColor = backColor;
    }
}

- (void)setBorderColor:(UIColor *)borderColor {
    if (borderColor.CGColor != self.layer.borderColor) {
        self.layer.borderColor = borderColor.CGColor;
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (borderWidth != self.layer.borderWidth) {
        self.layer.borderWidth = borderWidth;
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (cornerRadius != self.layer.cornerRadius) {
        self.layer.cornerRadius = cornerRadius;
    }
}

- (void)setIndicatorColor:(UIColor *)indicatorColor {
        self.updatedColor = indicatorColor;
}

- (void)setProgress:(CGFloat)progress {
    if (self.indicatorCAShapeLayer && self.useProgress) {
        if (progress >= 1) {
            self.indicatorCAShapeLayer.strokeEnd = 1;
        } else if (progress <= 0) {
            self.indicatorCAShapeLayer.strokeEnd = 0;
        } else {
            self.indicatorCAShapeLayer.strokeEnd = progress;
        }
    }
}

- (CGFloat)progress {
    if (self.indicatorCAShapeLayer && self.useProgress) {
        return self.indicatorCAShapeLayer.strokeEnd;
    } else {
        return 0.0;
    }
}

#pragma mark - public methods - show the view
- (void)showWithType:(CCActivityHUDIndicatorType)type {
    if (!self.superview) {
        [self initializeReplicatorLayer];
        [self initializeIndicatoeLayerWithType:type];
        self.currentTpye = type;
        self.useIndicator = YES;
        self.useProgress = NO;
        
        // change the indicator color if user do not use the default color.
        // You will confused that why not change the indicator color within the relevant setter,
        // If so, I need to initialize self.indicatorCAShapeLayer in the init method,
        // However, this will cause a problem (or bug) that the animation not works,
        // Meanwhile, when user use GIF instead of provided animation types,
        // the init method will create two useless instances,
        // since showing GIF not rely on self.indicatorCAShapeLayer
        if (self.indicatorCAShapeLayer && self.updatedColor) {
            self.indicatorCAShapeLayer.strokeColor = self.updatedColor.CGColor;
        }
        
        [self communalShowTask];
    }
}

- (void)show {
    [self showWithType:CCActivityHUDIndicatorTypeScalingDots];
}

- (void)showWithGIFName:(NSString *)GIFName {
    if (!self.superview) {
        CGFloat length = ViewFrameWidth/5;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(length, length, length*3, length*3) ];
        self.imageView.layer.cornerRadius = self.self.cornerRadius;
        UIImage *gif = [UIImage animatedImageWithAnimatedGIFURL:[[NSBundle mainBundle] URLForResource:GIFName withExtension:nil]];
        self.imageView.image = gif;
        
        [self addSubview:self.imageView];
        
        self.useIndicator = NO;
        self.useProgress = NO;
        
        [self communalShowTask];
    }
}

- (void)showWithText:(NSString *)text {
    if (!self.superview) {
        CGFloat height = [self heightForText:text]+8;
        self.frame = CGRectMake(0, -height, TEXT_WIDTH, height);
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ViewFrameWidth, ViewFrameHeight)];
        textLabel.numberOfLines = 0;
        textLabel.font = [UIFont systemFontOfSize:TEXT_FONT_SIZE];
        textLabel.textColor = [self inverseColorFor:self.backgroundColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.text = text;
        [self addSubview:textLabel];
        
        [self addShimmeringEffectForLabel:textLabel];
        
        self.useIndicator = NO;
        self.useProgress = NO;
        
        [self communalShowTask];
    }
}

- (void)showWithProgress {
    if (!self.superview) {
        [self initializeReplicatorLayer];
        [self initializeMinorArc];
        
        self.indicatorCAShapeLayer.path = [self arcPathWithStartAngle:-M_PI/2 span:2*M_PI];
        self.indicatorCAShapeLayer.strokeEnd = 0.0;
        
        if (self.indicatorCAShapeLayer && self.updatedColor) {
            self.indicatorCAShapeLayer.strokeColor = self.updatedColor.CGColor;
        }
        
        self.progress = 0.0;
        self.useIndicator = NO;
        self.useProgress = YES;
        
        [self communalShowTask];
    }
}

#pragma mark - public methods - dismiss the view
- (void)dismissWithText:(NSString *)text delay:(CGFloat)delay success:(BOOL)success {
    if (self.superview) {
        [self removeAllSubviews];
        // remove animation or GIF
        if (self.replicatorLayer != nil) {
            [self.replicatorLayer removeFromSuperlayer];
        }
        if (self.imageView != nil) {
            [self.imageView removeFromSuperview];
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = [self originalFrame];
            self.center = BoundsCenterFor(Screen);
        }];
        
        __block CGFloat length = BoundsWidthFor(Screen)/10;
        UIImageView *tickCrossImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewFrameWidth/2-length/2, length/3, length, length)];
        tickCrossImageView.image = [UIImage imageNamed:success?@"tick":@"cross"];
        tickCrossImageView.image = [tickCrossImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        tickCrossImageView.tintColor = [self inverseColorFor:self.backgroundColor];
        [self addSubview:tickCrossImageView];
        
        [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionTransitionFlipFromTop animations:nil completion:nil];
        
        if (text != nil || text.length != 0) {
            [UIView animateWithDuration:0.5 animations:^{
                self.frame = CGRectMake(0, 0, TEXT_WIDTH, FrameOriginY(tickCrossImageView)+FrameHeightFor(tickCrossImageView)+8+[self heightForText:text]+4);
                self.center = BoundsCenterFor(Screen);
                tickCrossImageView.frame = CGRectMake(ViewFrameWidth/2-length/2, length/3, length, length);
                
                UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, FrameOriginY(tickCrossImageView)+FrameHeightFor(tickCrossImageView)+8, ViewFrameWidth, [self heightForText:text])];
                textLabel.numberOfLines = 0;
                textLabel.font = [UIFont systemFontOfSize:TEXT_FONT_SIZE];
                textLabel.textColor = [self inverseColorFor:self.backgroundColor];
                textLabel.textAlignment = NSTextAlignmentCenter;
                textLabel.text = text;
                [self addSubview:textLabel];
            }];
        }
        
        [self addDisappearAnimationWithDelay:delay+0.7];
        
        if (self.isTheOnlyActiveView) {
            for (UIView *view in self.superview.subviews) {
                view.userInteractionEnabled = YES;
            }
        }
    }
}

- (void)dismiss {
    [self dismissWithText:nil delay:0 success:YES];
}

#pragma mark - life cycle
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)removeFromSuperview {
    if (self.overlay != nil) {
        [self.overlay removeFromSuperview];
    }
    
    if (self.imageView != nil) {
        [self.imageView removeFromSuperview];
    }
    
    [self removeAllSubviews];
    
    // change the scale to original if the disappear animation is zoom out
    self.transform = CGAffineTransformIdentity;
    
    self.frame = [self originalFrame];
    
    [super removeFromSuperview];
}

#pragma mark - initialization
- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.frame = [self originalFrame];
        self.alpha = 0.7;
        self.backgroundColor = [UIColor blackColor];
        self.layer.cornerRadius = 5.0;
        
        self.isTheOnlyActiveView = YES;
    
        self.appearAnimationType = CCActivityHUDAppearAnimationTypeFadeIn;
        self.disappearAnimationType = CCActivityHUDDisappearAnimationTypeFadeOut;
        self.overlay = CCActivityHUDOverlayTypeNone;
        
        [self addNotificationObserver];
    }
    
    return self;
}

- (void)addNotificationObserver {
    // The reason for invoking addAnimation when application enter foreground
    // is that if the application enter background when the activity indicator is animating,
    // the animation will not work when the application re-enter foreground.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAnimation) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)initializeReplicatorLayer {
    self.layer.sublayers = nil;
    
    self.replicatorLayer = [[CAReplicatorLayer alloc] init];
    self.replicatorLayer.frame = CGRectMake(0, 0, ViewFrameWidth, ViewFrameHeight);
    self.replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:self.replicatorLayer];
}

- (void)initializeIndicatoeLayerWithType:(CCActivityHUDIndicatorType)type {
    self.replicatorLayer.sublayers = nil;
    
    switch (type) {
        case CCActivityHUDIndicatorTypeScalingDots:
            [self initializeScalingDots];
            break;
            
        case CCActivityHUDIndicatorTypeLeadingDots:
            [self initializeLeadingDots];
            break;
            
        case CCActivityHUDIndicatorTypeMinorArc:
            [self initializeMinorArc];
            break;
            
        case CCActivityHUDIndicatorTypeDynamicArc:
            [self initializeDynamicArc];
            break;
            
        case CCActivityHUDIndicatorTypeArcInCircle:
            [self initializeArcInCircle];
            break;
    }
}

- (void)initializeScalingDots {
    CGFloat length = ViewFrameWidth*18/200;
    
    self.indicatorCAShapeLayer = [[CAShapeLayer alloc] init];
    self.indicatorCAShapeLayer.backgroundColor = [UIColor whiteColor].CGColor;
    self.indicatorCAShapeLayer.frame = CGRectMake(0, 0, length, length);
    self.indicatorCAShapeLayer.position = CGPointMake(ViewFrameWidth/2, ViewFrameHeight/5);
    self.indicatorCAShapeLayer.cornerRadius = length/2;
    self.indicatorCAShapeLayer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    
    self.replicatorLayer.instanceCount = 15;
    self.replicatorLayer.instanceDelay = DURATION_BASE*1.2/self.replicatorLayer.instanceCount;
    CGFloat angle = 2*M_PI/self.replicatorLayer.instanceCount;
    self.replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 0.1);
    
    [self.replicatorLayer addSublayer:self.indicatorCAShapeLayer];
}

- (void)initializeLeadingDots {
    CGFloat length = ViewFrameWidth*18/200;

    self.indicatorCAShapeLayer = [[CAShapeLayer alloc] init];
    self.indicatorCAShapeLayer.backgroundColor = [UIColor whiteColor].CGColor;
    self.indicatorCAShapeLayer.frame = CGRectMake(0, 0, length, length);
    self.indicatorCAShapeLayer.position = CGPointMake(ViewFrameWidth/2, ViewFrameHeight/5);
    self.indicatorCAShapeLayer.cornerRadius = length/2;
    self.indicatorCAShapeLayer.shouldRasterize = YES;
    self.indicatorCAShapeLayer.rasterizationScale = Screen.scale;
    
    self.replicatorLayer.instanceCount = 3;
    self.replicatorLayer.instanceDelay = 0.08;
    
    [self.replicatorLayer addSublayer:self.indicatorCAShapeLayer];
}

- (void)initializeMinorArc {
    self.indicatorCAShapeLayer = [[CAShapeLayer alloc] init];
    self.indicatorCAShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.indicatorCAShapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.indicatorCAShapeLayer.lineWidth = ViewFrameWidth/24;
    
    CGFloat length = ViewFrameWidth/5;
    self.indicatorCAShapeLayer.frame = CGRectMake(length, length, length*3, length*3);
    
    // Although animation for minor arc do not rely on self.replicatorLayer,
    // I still add it as a sublayer of self.replicatorLayer instead of self.layer,
    // for more convenient management of layers
    // when user show other types of indicator with the same CCActivityIndicatorView instance.
    [self.replicatorLayer addSublayer:self.indicatorCAShapeLayer];
}

- (void)initializeDynamicArc {
    // Use the same same indicatorCAShapeLayer in minor arc
    [self initializeMinorArc];
}

- (void)initializeArcInCircle {
    // Use the same same indicatorCAShapeLayer in minor arc
    [self initializeMinorArc];
}

#pragma mark - background view
- (void)addOverlay {
    switch (self.overlayType) {
        case CCActivityHUDOverlayTypeNone:
            // do nothing
            break;
        
        case CCActivityHUDOverlayTypeBlur:
            [self addBlurOverlay];
            break;
            
        case CCActivityHUDOverlayTypeTransparent:
            [self addTransparentOverlay];
            break;
            
        case CCActivityHUDOverlayTypeShadow:
            [self addShadowOverlay];
            break;
    }
}

- (void)addBlurOverlay {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *overlayView = [[UIVisualEffectView alloc] initWithFrame:BoundsFor(Screen)];
    overlayView.effect = blurEffect;
    self.overlay = overlayView;
                              
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.overlay];
}

- (void)addTransparentOverlay {
    self.overlay = [[UIView alloc] initWithFrame:BoundsFor(Screen)];
    self.overlay.backgroundColor = [UIColor blackColor];
    self.overlay.alpha = self.alpha-.2>0?self.alpha-.2:0.15;
    
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.overlay];
}

- (void)addShadowOverlay {
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    self.layer.shadowOpacity = 0.5;
}

#pragma mark - appear animation
- (void)addAppearAnimation {
    switch (self.appearAnimationType) {
        case CCActivityHUDAppearAnimationTypeSlideFromTop:
            [self addSlideFromTopAppearAnimation];
            break;
            
        case CCActivityHUDAppearAnimationTypeSlideFromBottom:
            [self addSlideFromBottomAppearAnimation];
            break;
            
        case CCActivityHUDAppearAnimationTypeSlideFromLeft:
            [self addSlideFromLeftAppearAnimation];
            break;
            
        case CCActivityHUDAppearAnimationTypeSlideFromRight:
            [self addSlideFromRightAppearAnimation];
            break;
            
        case CCActivityHUDAppearAnimationTypeZoomIn:
            [self addZoomInAppearAnimation];
            break;
            
        case CCActivityHUDAppearAnimationTypeFadeIn:
            [self addFadeInAppearAnimation];
            break;
    }
}

- (void)addFadeInAppearAnimation {
    CGFloat originalAlpha = self.alpha;
    self.alpha = 0.0;
    
    self.center = BoundsCenterFor(Screen);
    
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = originalAlpha;
    } completion:^(BOOL finished) {
        if (finished && self.useIndicator) {
            [self addAnimation];
        }
    }];
}

- (void)addSlideFromTopAppearAnimation {
    self.center = CGPointMake(BoundsCenterXFor(Screen), -ViewFrameHeight);
    
    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.center = BoundsCenterFor(Screen);
    } completion:^(BOOL finished) {
        if (finished && self.useIndicator) {
            [self addAnimation];
        }
    }];
}

- (void)addSlideFromBottomAppearAnimation {
    self.center = CGPointMake(BoundsCenterXFor(Screen), BoundsHeightFor(Screen)+ViewFrameHeight);
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.center = BoundsCenterFor(Screen);
    } completion:^(BOOL finished) {
        if (finished && self.useIndicator) {
            [self addAnimation];
        }
    }];
}

- (void)addSlideFromLeftAppearAnimation {
    self.center = CGPointMake(-ViewFrameWidth, BoundsCenterYFor(Screen));
    
    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.center = BoundsCenterFor(Screen);
    } completion:^(BOOL finished) {
        if (finished && self.useIndicator) {
            [self addAnimation];
        }
    }];
}

- (void)addSlideFromRightAppearAnimation {
    self.center = CGPointMake(BoundsWidthFor(Screen)+ViewFrameWidth, BoundsCenterYFor(Screen));
    
    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.center = BoundsCenterFor(Screen);
    } completion:^(BOOL finished) {
        if (finished && self.useIndicator) {
            [self addAnimation];
        }
    }];
}

- (void)addZoomInAppearAnimation {
    self.center = BoundsCenterFor(Screen);
    
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    [UIView animateWithDuration:0.15 animations:^{
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.transform = CGAffineTransformIdentity;
                
                if (finished && self.useIndicator) {
                    [self addAnimation];
                }
            }];
        }];
    }];
}

#pragma mark - activity animation
- (void)addAnimation {
    [self.indicatorCAShapeLayer removeAllAnimations];
    switch (self.currentTpye) {
        case CCActivityHUDIndicatorTypeScalingDots:
            [self addScaleAnimation];
            break;
            
        case CCActivityHUDIndicatorTypeLeadingDots:
            [self addLeadingAnimation];
            break;
            
        case CCActivityHUDIndicatorTypeMinorArc:
            [self addMinorArcAnimation];
            break;
            
        case CCActivityHUDIndicatorTypeDynamicArc:
            [self addDynamicArcAnimation];
            break;
            
        case CCActivityHUDIndicatorTypeArcInCircle:
            [self addArcInCircleAnimation];
            break;
    }
}

- (void)addScaleAnimation {
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    animation.keyPath  = @"transform.scale";
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.1];
    animation.duration = DURATION_BASE*1.2;
    animation.repeatCount = INFINITY;
    
    [self.indicatorCAShapeLayer addAnimation:animation forKey:nil];
}

- (void)addLeadingAnimation {
    CGFloat radius = FrameWidthFor(self.replicatorLayer)/2 - FrameWidthFor(self.replicatorLayer)/5;
    CGFloat x = CGRectGetMidX(self.replicatorLayer.frame);
    CGFloat y = CGRectGetMidY(self.replicatorLayer.frame);
    CGFloat startAngle = -M_PI/2;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(x, y) radius:radius startAngle:startAngle endAngle:startAngle+M_PI*2 clockwise:YES];
    
    CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
    animation.keyPath = @"position";
    animation.path = bezierPath.CGPath;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = DURATION_BASE;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = animation.duration+self.replicatorLayer.instanceCount*self.replicatorLayer.instanceDelay+0.06;
    animationGroup.repeatCount = INFINITY;
    animationGroup.animations = @[animation];
    
    [self.indicatorCAShapeLayer addAnimation:animationGroup forKey:nil];
}

- (void)addMinorArcAnimation {
    self.indicatorCAShapeLayer.path = [self arcPathWithStartAngle:-M_PI/4 span:M_PI/2];
    
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    animation.keyPath = @"transform.rotation.z";
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
    animation.duration = DURATION_BASE*1.5;
    animation.repeatCount = INFINITY;
    
    [self.indicatorCAShapeLayer addAnimation:animation forKey:nil];
}

- (void)addDynamicArcAnimation {
    self.indicatorCAShapeLayer.path = [self arcPathWithStartAngle:-M_PI/2 span:2*M_PI];
    
    CABasicAnimation *strokeEndAnimation = [[CABasicAnimation alloc] init];
    strokeEndAnimation.keyPath = @"strokeEnd";
    strokeEndAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    strokeEndAnimation.toValue = [NSNumber numberWithFloat:1.0];
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeEndAnimation.duration = DURATION_BASE*2;
    
    CABasicAnimation *strokeStartAnimation = [[CABasicAnimation alloc] init];
    strokeStartAnimation.keyPath = @"strokeStart";
    strokeStartAnimation.beginTime =strokeEndAnimation.duration/4;
    strokeStartAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    strokeStartAnimation.toValue = [NSNumber numberWithFloat:1.0];
    strokeStartAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeStartAnimation.duration = strokeEndAnimation.duration;
    
    CABasicAnimation *rotationAnimation = [[CABasicAnimation alloc] init];
    rotationAnimation.keyPath = @"transform.rotation.z";
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2*M_PI];
    rotationAnimation.duration = 2*strokeEndAnimation.duration;
    rotationAnimation.repeatCount = INFINITY;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = strokeEndAnimation.duration+strokeStartAnimation.beginTime;
    animationGroup.repeatCount = INFINITY;
    animationGroup.animations = @[strokeEndAnimation, strokeStartAnimation];
    
    [self.indicatorCAShapeLayer addAnimation:animationGroup forKey:nil];
    [self.indicatorCAShapeLayer addAnimation:rotationAnimation forKey:nil];
}

- (void)addArcInCircleAnimation {
    CAShapeLayer *circleShapeLayer = [[CAShapeLayer alloc] init];
    circleShapeLayer.strokeColor = self.indicatorCAShapeLayer.strokeColor;
    circleShapeLayer.fillColor = [UIColor clearColor].CGColor;
    circleShapeLayer.opacity = self.indicatorCAShapeLayer.opacity-0.8;
    circleShapeLayer.lineWidth = ViewFrameWidth/24;
    circleShapeLayer.path = [self arcPathWithStartAngle:-M_PI span:2*M_PI];
    
    CGFloat length = ViewFrameWidth/5;
    circleShapeLayer.frame = CGRectMake(length, length, length*3, length*3);
    [self.replicatorLayer insertSublayer:circleShapeLayer above:self.indicatorCAShapeLayer];
    
    
    self.indicatorCAShapeLayer.path = [self arcPathWithStartAngle:-M_PI/2 span:M_PI/3];
    
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    animation.keyPath = @"transform.rotation.z";
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
    animation.duration = DURATION_BASE*1.5;
    animation.repeatCount = INFINITY;
    
    [self.indicatorCAShapeLayer addAnimation:animation forKey:nil];
}

#pragma mark - disappeat animation
- (void)addDisappearAnimationWithDelay:(CGFloat)delay {
    switch (self.disappearAnimationType) {
        case CCActivityHUDDisappearAnimationTypeSlideToTop:
            [self addSlideToTopDissappearAnimationWithDelay:delay];
            break;
            
        case CCActivityHUDDisappearAnimationTypeSlideToBottom:
            [self addSlideToBottomDissappearAnimationWithDelay:delay];
            break;
            
        case CCActivityHUDDisappearAnimationTypeSlideToLeft:
            [self addSlideToLeftDissappearAnimationWithDelay:delay];
            break;
            
        case CCActivityHUDDisappearAnimationTypeSlideToRight:
            [self addSlideToRightDissappearAnimationWithDelay:delay];
            break;
            
        case CCActivityHUDDisappearAnimationTypeZoomOut:
            [self addZoomOutDisappearAnimationWithDelay:delay];
            break;
            
        case CCActivityHUDDisappearAnimationTypeFadeOut:
            [self addFadeOutDisappearAnimationWithDelay:delay];
            break;
    }
}

- (void)addFadeOutDisappearAnimationWithDelay:(CGFloat)delay {
    CGFloat originalAlpha = self.alpha;
    
    [UIView animateWithDuration:0.35 delay:delay options:kNilOptions  animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.alpha = originalAlpha;
        [self removeFromSuperview];
    }];
}

- (void)addSlideToTopDissappearAnimationWithDelay:(CGFloat)delay {
    [UIView animateWithDuration:0.25 delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.center = CGPointMake(BoundsCenterXFor(Screen), -ViewFrameHeight);
    } completion:^(BOOL finished) {
         [self removeFromSuperview];
    }];
}
- (void)addSlideToBottomDissappearAnimationWithDelay:(CGFloat)delay {
    [UIView animateWithDuration:0.25 delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.center = CGPointMake(BoundsCenterXFor(Screen), BoundsHeightFor(Screen)+ViewFrameHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)addSlideToLeftDissappearAnimationWithDelay:(CGFloat)delay {
    [UIView animateWithDuration:0.15 delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.center = CGPointMake(-ViewFrameWidth, BoundsCenterYFor(Screen));
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)addSlideToRightDissappearAnimationWithDelay:(CGFloat)delay {
    [UIView animateWithDuration:0.15 delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.center = CGPointMake(BoundsWidthFor(Screen)+ViewFrameWidth, BoundsCenterYFor(Screen));
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)addZoomOutDisappearAnimationWithDelay:(CGFloat)delay {
    [UIView animateWithDuration:0.15 delay:delay options:kNilOptions animations:^{
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.01, 0.01);;
                
                [self removeFromSuperview];
            }];
        }];
    }];
}

#pragma mark - helper methods
- (CGRect)originalFrame {
    CGFloat length = BoundsWidthFor(Screen)/6;
    return CGRectMake(-2*length, -2*length, length, length);
}

- (void)removeAllSubviews {
    if (self.subviews.count > 0) {
        for (UIView *sub in self.subviews) {
            [sub removeFromSuperview];
        }
    }
}

- (void)communalShowTask {
    [self addOverlay];
    
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self];
    [self.superview bringSubviewToFront:self];
    
    [self addAppearAnimation];
    
    if (self.isTheOnlyActiveView) {
        for (UIView *view in self.superview.subviews) {
            view.userInteractionEnabled = NO;
        }
    }
}

- (UIColor *)inverseColorFor:(UIColor *)color {
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:1.-r green:1.-g blue:1.-b alpha:a];
}

- (CGPathRef)arcPathWithStartAngle:(CGFloat)startAngle span:(CGFloat)span {
    CGFloat radius = ViewFrameWidth/2 - ViewFrameWidth/5;
    CGFloat x = FrameWidthFor(self.indicatorCAShapeLayer)/2;
    CGFloat y = FrameHeightFor(self.indicatorCAShapeLayer)/2;
    
    UIBezierPath *arcPath = [UIBezierPath bezierPath];
    [arcPath addArcWithCenter:CGPointMake(x, y) radius:radius startAngle:startAngle endAngle:startAngle+span clockwise:YES];
    return arcPath.CGPath;
}

- (CGFloat)heightForText:(NSString *)text{
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:TEXT_FONT_SIZE]}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){TEXT_WIDTH, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    return ceil(rect.size.height);
}

- (void)addShimmeringEffectForLabel:(UILabel *)label {
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    gradientMask.frame = label.bounds;
    CGFloat gradientSize = FrameWidthFor(label)/6 / FrameWidthFor(label);
    UIColor *gradient = [UIColor colorWithWhite:1.0f alpha:0.4];
    NSArray *startLocations = @[[NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:(gradientSize / 2)], [NSNumber numberWithFloat:gradientSize]];
    NSArray *endLocations = @[[NSNumber numberWithFloat:(1.0f - gradientSize)], [NSNumber numberWithFloat:(1.0f -(gradientSize / 2))], [NSNumber numberWithFloat:1.0f]];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    
    gradientMask.colors = @[(id)gradient.CGColor, (id)[UIColor whiteColor].CGColor, (id)gradient.CGColor];
    gradientMask.locations = startLocations;
    gradientMask.startPoint = CGPointMake(0 - (gradientSize * 2), .5);
    gradientMask.endPoint = CGPointMake(1 + gradientSize, .5);
    
    label.layer.mask = gradientMask;
    
    animation.fromValue = startLocations;
    animation.toValue = endLocations;
    animation.repeatCount = INFINITY;
    animation.duration  = 0.007*TEXT_WIDTH;
    
    [gradientMask addAnimation:animation forKey:nil];
}

@end
