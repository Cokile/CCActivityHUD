#import "CCActivityIndicatorView.h"

#define NUMBER_OF_SCALE_DOT 15
#define NUMBER_OF_LEADING_DOT 3
#define DURATION_BASE 0.7

@interface CCActivityIndicatorView ()

@property (strong, nonatomic) CAReplicatorLayer *replicatorLayer;
@property (strong, nonatomic) CALayer *indicatorLayer;
@property (strong, nonatomic) CAShapeLayer *shapeLayer;

@property CCIndicatorType currentTpye;
@end

@implementation CCActivityIndicatorView

#pragma mark - custom accessors
- (void)setColor:(UIColor *)color {
    if (color.CGColor !=_replicatorLayer.backgroundColor) {
        _replicatorLayer.backgroundColor = color.CGColor;
    }
}

- (void)setBorderColor:(UIColor *)borderColor {
    if (borderColor.CGColor != _replicatorLayer.borderColor) {
        _replicatorLayer.borderColor = borderColor.CGColor;
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (borderWidth != _replicatorLayer.borderWidth) {
        _replicatorLayer.borderWidth = borderWidth;
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (cornerRadius != _replicatorLayer.cornerRadius) {
        _replicatorLayer.cornerRadius = cornerRadius;
    }
}

- (void)setAlpha:(CGFloat)alpha {
    if (alpha != _replicatorLayer.opacity) {
        _replicatorLayer.opacity = alpha;
    }
}

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    if (_indicatorLayer && indicatorColor.CGColor != _indicatorLayer.backgroundColor) {
        _indicatorLayer.backgroundColor = indicatorColor.CGColor;
    }
    
    if (_shapeLayer && indicatorColor.CGColor != _shapeLayer.strokeColor) {
        _shapeLayer.strokeColor = indicatorColor.CGColor;
    }
}

#pragma mark - public methods
- (void)showWithType:(CCIndicatorType)type {
    if (!self.superview) {
        self.currentTpye = type;
        [self initializeReplicatorLayer:self.frame];
        [self initializeIndicatoeLayer:self.frame type:type];
        
        [self addAnimation];
        
        [[[UIApplication sharedApplication].windows lastObject] addSubview:self];
        [self.superview bringSubviewToFront:self];
        
        if (self.isTheOnlyActiveView) {
            for (UIView *view in self.superview.subviews) {
                view.userInteractionEnabled = NO;
            }
        }
    }
}

- (void)show {
    [self showWithType:CCIndicatorTypeScalingDots];
}

- (void)dismiss {
    if (self.superview) {
        if (self.isTheOnlyActiveView) {
            for (UIView *view in self.superview.subviews) {
                view.userInteractionEnabled = YES;
            }
        }
        
        [self removeFromSuperview];
    }
}

#pragma mark - life cycle
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - initialization
- (instancetype)init {
    self = [super init];
    
    if (self) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        CGFloat boundsWdith = bounds.size.width;
        CGFloat length = boundsWdith/6;
        self.frame = CGRectMake(boundsWdith/2-length/2, bounds.size.height/2-length/2, length, length);
        
        self.isTheOnlyActiveView = YES;
        
        [self addNotificationObserver];
    }
    
    return self;
}

- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAnimation) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)initializeReplicatorLayer:(CGRect)frame {
    if (!self.replicatorLayer) {
        self.replicatorLayer = [[CAReplicatorLayer alloc] init];
        self.replicatorLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.replicatorLayer.cornerRadius = 10.0;
        self.replicatorLayer.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7].CGColor;
        
        [self.layer addSublayer:self.replicatorLayer];
    }
}

- (void)initializeIndicatoeLayer:(CGRect)frame type:(CCIndicatorType)type {
    self.replicatorLayer.sublayers = nil;
    
    switch (type) {
        case CCIndicatorTypeScalingDots:
            [self initializeScalingDot:frame];
            break;
            
        case CCIndicatorTypeLeadingDots:
            [self initializeLeadingDot:frame];
            break;
            
        case CCIndicatorTypeCircle:
            [self initializeCircle:frame];
            break;
            
        case CCIndicatorTypeArc:
            [self initializeArc:frame];
            break;
    }
}

- (void)initializeScalingDot:(CGRect)frame {
    self.indicatorLayer = [[CALayer alloc] init];
    
    CGFloat length = frame.size.width*18/200;
    
    self.indicatorLayer.frame = CGRectMake(0, 0, length, length);
    self.indicatorLayer.position = CGPointMake(frame.size.width/2, frame.size.height/5);
    self.indicatorLayer.backgroundColor = [UIColor whiteColor].CGColor;
    self.indicatorLayer.cornerRadius = length/2;
    self.indicatorLayer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    
    self.replicatorLayer.instanceCount = NUMBER_OF_SCALE_DOT;
    self.replicatorLayer.instanceDelay = DURATION_BASE*1.2/self.replicatorLayer.instanceCount;
    CGFloat angle = 2*M_PI/NUMBER_OF_SCALE_DOT;
    self.replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 0.1);
    
    [self.replicatorLayer addSublayer:self.indicatorLayer];
}

- (void)initializeLeadingDot:(CGRect)frame {
    self.indicatorLayer = [[CALayer alloc] init];
    
    CGFloat length = frame.size.width*18/200;

    self.indicatorLayer.frame = CGRectMake(0, 0, length, length);
    self.indicatorLayer.position = CGPointMake(frame.size.width/2, frame.size.height/5);
    self.indicatorLayer.backgroundColor = [UIColor whiteColor].CGColor;
    self.indicatorLayer.cornerRadius = length/2;
    self.indicatorLayer.shouldRasterize = YES;
    self.indicatorLayer.rasterizationScale = [UIScreen mainScreen].scale;
    
    self.replicatorLayer.instanceCount = NUMBER_OF_LEADING_DOT;
    self.replicatorLayer.instanceDelay = 0.08;
    
    [self.replicatorLayer addSublayer:self.indicatorLayer];
}

- (void)initializeCircle:(CGRect)frame {
    
    self.shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.shapeLayer.lineWidth = frame.size.width/30;
    
    CGFloat radius = frame.size.width/2 - frame.size.width/5;
    CGFloat x = CGRectGetMidX(self.replicatorLayer.frame);
    CGFloat y = CGRectGetMidY(self.replicatorLayer.frame);
    
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    CGFloat startAngle = -M_PI/2;
    [circlePath addArcWithCenter:CGPointMake(x, y) radius:radius startAngle:startAngle endAngle:startAngle+2*M_PI clockwise:YES];
    self.shapeLayer.path = circlePath.CGPath;
    
    [self.replicatorLayer addSublayer:self.shapeLayer];
}

- (void)initializeArc:(CGRect)frame {
    self.shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.shapeLayer.lineWidth = frame.size.width/24;
    
    CGFloat length = frame.size.width/5;
    self.shapeLayer.frame = CGRectMake(length, length, length*3, length*3);
    
    CGFloat radius = frame.size.width/2 - frame.size.width/5;
    CGFloat x = self.shapeLayer.frame.size.width/2;
    CGFloat y = self.shapeLayer.frame.size.height/2;
    
    UIBezierPath *arcPath = [UIBezierPath bezierPath];
    CGFloat startAngle = -M_PI/4;
    [arcPath addArcWithCenter:CGPointMake(x, y) radius:radius startAngle:startAngle endAngle:startAngle+M_PI/2 clockwise:YES];
    self.shapeLayer.path = arcPath.CGPath;
    
    [self.layer addSublayer:self.shapeLayer];
}

- (void)addAnimation {
    switch (self.currentTpye) {
        case CCIndicatorTypeScalingDots:
            [self.indicatorLayer removeAllAnimations];
            [self addScaleAnimation];
            break;
            
        case CCIndicatorTypeLeadingDots:
            [self.indicatorLayer removeAllAnimations];
            [self addLeadingAnimation];
            break;
            
        case CCIndicatorTypeCircle:
            [self.shapeLayer removeAllAnimations];
            [self addCircleAnimation];
            break;
            
        case CCIndicatorTypeArc:
            [self.shapeLayer removeAllAnimations];
            [self addArcAnimation];
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
    
    [self.indicatorLayer addAnimation:animation forKey:nil];
}

- (void)addLeadingAnimation {
    CGFloat radius = self.replicatorLayer.frame.size.width/2 - self.replicatorLayer.frame.size.width/5;
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
    animationGroup.duration = animation.duration+NUMBER_OF_LEADING_DOT*self.replicatorLayer.instanceDelay+0.06;
    animationGroup.repeatCount = INFINITY;
    animationGroup.animations = @[animation];
    
    [self.indicatorLayer addAnimation:animationGroup forKey:nil];
}

- (void)addCircleAnimation {
    CABasicAnimation *appearAnimation = [[CABasicAnimation alloc] init];
    appearAnimation.keyPath = @"strokeEnd";
    appearAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    appearAnimation.toValue = [NSNumber numberWithFloat:1.0];
    appearAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    appearAnimation.duration = DURATION_BASE*1.8;
    
    CABasicAnimation *disappearAnimation = [[CABasicAnimation alloc] init];
    disappearAnimation.keyPath = @"strokeStart";
    disappearAnimation.beginTime = appearAnimation.duration;
    disappearAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    disappearAnimation.toValue = [NSNumber numberWithFloat:1.0];
    appearAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    disappearAnimation.duration = DURATION_BASE;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = appearAnimation.duration+disappearAnimation.duration;
    animationGroup.repeatCount = INFINITY;
    animationGroup.animations = @[appearAnimation, disappearAnimation];
    
    [self.shapeLayer addAnimation:animationGroup forKey:nil];
    
}

- (void)addArcAnimation {
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    animation.keyPath = @"transform.rotation.z";
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
    animation.duration = DURATION_BASE*1.5;
    animation.repeatCount = INFINITY;
    
    [self.shapeLayer addAnimation:animation forKey:nil];
}

@end
