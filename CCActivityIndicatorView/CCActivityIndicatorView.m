#import "CCActivityIndicatorView.h"

#define NUMBER_OF_SCALE_DOT 15
#define NUMBER_OF_LEADING_DOT 3
#define DURATION 0.7

@interface CCActivityIndicatorView ()

@property (strong, nonatomic) CAReplicatorLayer *replicatorLayer;
@property (strong, nonatomic) CALayer *indicatorLayer;

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
    _indicatorLayer.backgroundColor = indicatorColor.CGColor;
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
    self.indicatorLayer = [[CALayer alloc] init];
    self.indicatorLayer.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
    
    switch (type) {
        case CCIndicatorTypeScalingDots:
            [self initializeScalingDot:frame];
            break;
            
        case CCIndicatorTypeLeadingDots:
            [self initializeLeadingDot:frame];
            break;
            
        case CCIndicatorTypeCircle:
            
            //break;
            
        case CCIndicatorTypeArc:
            
            //break;
            
        default:
            NSLog(@"You are adding unsupproted type.");
            break;
    }
}

- (void)initializeScalingDot:(CGRect)frame {
    CGFloat width = frame.size.width*14/200;
    
    self.indicatorLayer.frame = CGRectMake(0, 0, width, width);
    self.indicatorLayer.position = CGPointMake(frame.size.width/2, frame.size.height/5);
    self.indicatorLayer.borderColor = [UIColor whiteColor].CGColor;
    self.indicatorLayer.borderWidth = 1.0;
    self.indicatorLayer.cornerRadius = 1.5;
    self.indicatorLayer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    
    self.replicatorLayer.instanceCount = NUMBER_OF_SCALE_DOT;
    self.replicatorLayer.instanceDelay = DURATION/self.replicatorLayer.instanceCount;
    CGFloat angle = 2*M_PI/NUMBER_OF_SCALE_DOT;
    self.replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 0.1);
    
    [self.replicatorLayer addSublayer:self.indicatorLayer];
}

- (void)initializeLeadingDot:(CGRect)frame {
    CGFloat width = frame.size.width*18/200;

    self.indicatorLayer.frame = CGRectMake(0, 0, width, width);
    self.indicatorLayer.position = CGPointMake(frame.size.width/2, frame.size.height/5);
    self.indicatorLayer.cornerRadius = width/2;
    self.indicatorLayer.shouldRasterize = YES;
    self.indicatorLayer.rasterizationScale = [UIScreen mainScreen].scale;
    
    self.replicatorLayer.instanceCount = NUMBER_OF_LEADING_DOT;
    self.replicatorLayer.instanceDelay = 0.08;
    
    [self.replicatorLayer addSublayer:self.indicatorLayer];
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
            
            //break;
            
        case CCIndicatorTypeArc:
            
            //break;
            
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
    animation.duration = DURATION;
    animation.repeatCount = INFINITY;
    
    [self.indicatorLayer addAnimation:animation forKey:nil];
}

- (void)addLeadingAnimation {
    CGFloat startAngle = -M_PI/2;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:self.replicatorLayer.frame.size.width/2-self.replicatorLayer.frame.size.height/5 startAngle:startAngle endAngle:startAngle+M_PI*2 clockwise:YES];
    
    CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
    animation.keyPath = @"position";
    animation.path = bezierPath.CGPath;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = DURATION;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = animation.duration+NUMBER_OF_LEADING_DOT*self.replicatorLayer.instanceDelay+0.06;
    animationGroup.repeatCount = INFINITY;
    animationGroup.animations = @[animation];
    
    [self.indicatorLayer addAnimation:animationGroup forKey:nil];
}

@end
