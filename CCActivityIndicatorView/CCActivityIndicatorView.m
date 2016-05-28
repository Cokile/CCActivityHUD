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

#pragma mark - setter
- (void)setColor:(UIColor *)color {
    _replicatorLayer.backgroundColor = color.CGColor;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _replicatorLayer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _replicatorLayer.borderWidth = borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _replicatorLayer.cornerRadius = cornerRadius;
}

- (void)setAlpha:(CGFloat)alpha {
    _replicatorLayer.opacity = alpha;
}

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    if (_indicatorLayer) {
        _indicatorLayer.backgroundColor = indicatorColor.CGColor;
    }
    
    if (_shapeLayer) {
        _shapeLayer.strokeColor = indicatorColor.CGColor;
    }
}

#pragma mark - public methods
- (id)initWithFrame:(CGRect)frame type:(CCIndicatorType)type {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.isTheOnlyActiveView = YES;
        self.currentTpye = type;
        
        [self addNotificationObserver];
        
        [self initializeReplicatorLayer:frame];
        
        [self initializeIndicatoeLayer:frame type:type];
    }
    
    return self;
}

- (void)show {
    if (self.superview) {
        [self.superview bringSubviewToFront:self];
        
        [self addAnimation];
        
        if (self.isTheOnlyActiveView) {
            for (UIView *view in self.superview.subviews) {
                view.userInteractionEnabled = NO;
            }
        }
    }
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
- (id)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame type:CCIndicatorTypeScalingDots];
    return self;
}

- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAnimation) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)initializeReplicatorLayer:(CGRect)frame {
    self.replicatorLayer = [[CAReplicatorLayer alloc] init];
    self.replicatorLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.replicatorLayer.cornerRadius = 10.0;
    self.replicatorLayer.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.86].CGColor;
    
    [self.layer addSublayer:self.replicatorLayer];
}

- (void)initializeIndicatoeLayer:(CGRect)frame type:(CCIndicatorType)type {
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
            
        default:
            NSLog(@"You are adding unsupproted type.");
            break;
    }
}

- (void)initializeScalingDot:(CGRect)frame {
    self.indicatorLayer = [[CALayer alloc] init];
    
    CGFloat length = frame.size.width*18/200;
    
    self.indicatorLayer.frame = CGRectMake(0, 0, length, length);
    self.indicatorLayer.position = CGPointMake(frame.size.width/2, frame.size.height/5);
    self.indicatorLayer.backgroundColor = [UIColor whiteColor].CGColor;
    self.indicatorLayer.borderWidth = 1.0;
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
    self.shapeLayer.lineWidth = 4.0;
    
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
    self.shapeLayer.lineWidth = 5.0;
    
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
            [self addScaleAnimation];
            break;
            
        case CCIndicatorTypeLeadingDots:
            [self addLeadingAnimation];
            break;
        
        case CCIndicatorTypeCircle:
            [self addCircleAnimation];
            break;
            
        case CCIndicatorTypeArc:
            [self addArcAnimation];
            break;
            
        default:
            NSLog(@"You are showing unsupported type.");
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
    CABasicAnimation *animationAppear = [[CABasicAnimation alloc] init];
    animationAppear.keyPath = @"strokeEnd";
    animationAppear.fromValue = [NSNumber numberWithFloat:0.0];
    animationAppear.toValue = [NSNumber numberWithFloat:1.0];
    animationAppear.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animationAppear.duration = DURATION_BASE*1.8;
    
    CABasicAnimation *animationDisappear = [[CABasicAnimation alloc] init];
    animationDisappear.keyPath = @"strokeStart";
    animationDisappear.beginTime = animationAppear.duration;
    animationDisappear.fromValue = [NSNumber numberWithFloat:0.0];
    animationDisappear.toValue = [NSNumber numberWithFloat:1.0];
    animationAppear.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animationDisappear.duration = DURATION_BASE;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = animationAppear.duration+animationDisappear.duration;
    animationGroup.repeatCount = INFINITY;
    animationGroup.animations = @[animationAppear, animationDisappear];
    
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
