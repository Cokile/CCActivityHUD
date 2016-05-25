#import "CCActivityIndicatorView.h"

#define NUMBER_OF_DOT 15
#define DURATION 1.5

@interface CCActivityIndicatorView ()

@property (strong, nonatomic) CAReplicatorLayer *replicatorLayer;
@property (strong, nonatomic) CALayer *dotLayer;
@property (strong, nonatomic) CABasicAnimation *shrinkAnimation;

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
    _dotLayer.backgroundColor = indicatorColor.CGColor;
}

- (void)setIndicatorBorderColor:(UIColor *)indicatorBorderColor {
    _dotLayer.borderColor = indicatorBorderColor.CGColor;
}

#pragma mark - public methods
- (void)show {
    if (self.superview) {
        [self.superview bringSubviewToFront:self];
        
        [self addShrink];
        
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
    self = [super initWithFrame:frame];
    
    if (self) {
        self.isTheOnlyActiveView = YES;
        
        [self addNotificationObserver];
        
        [self initializeReplicatorLayer:frame];
        
        [self initializeDot:frame];
    }
    
    return self;
}

- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addShrink) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)initializeReplicatorLayer:(CGRect)frame {
    self.replicatorLayer = [[CAReplicatorLayer alloc] init];
    self.replicatorLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.replicatorLayer.cornerRadius = 10.0;
    self.replicatorLayer.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.86].CGColor;
    
    self.replicatorLayer.instanceDelay = DURATION/NUMBER_OF_DOT;
    self.replicatorLayer.instanceCount = NUMBER_OF_DOT;
    CGFloat angle = 2*M_PI/NUMBER_OF_DOT;
    self.replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 0.1);
    
    [self.layer addSublayer:self.replicatorLayer];
}

- (void)initializeDot:(CGRect)frame {
    CGFloat width = frame.size.width*14/200;
    
    self.dotLayer = [[CALayer alloc] init];
    self.dotLayer.frame = CGRectMake(0, 0, width, width);
    self.dotLayer.position = CGPointMake(frame.size.width/2, frame.size.height/5);
    self.dotLayer.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
    self.dotLayer.borderColor = [UIColor whiteColor].CGColor;
    self.dotLayer.borderWidth = 1.0;
    self.dotLayer.cornerRadius = 1.5;
    self.dotLayer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    
    [self.replicatorLayer addSublayer:self.dotLayer];
    
    self.shrinkAnimation = [[CABasicAnimation alloc] init];
}

- (void)addShrink {
    self.shrinkAnimation.keyPath  = @"transform.scale";
    self.shrinkAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    self.shrinkAnimation.toValue = [NSNumber numberWithFloat:0.1];
    self.shrinkAnimation.duration = DURATION;
    self.shrinkAnimation.repeatCount = INFINITY;
    
    [self.dotLayer addAnimation:self.shrinkAnimation forKey:nil];
}

@end
