//
//  DropDownMenuManager.m
//  DropDownMenuManager
//
//  Created by Rhea on 2021/7/22.
//

#import "DropDownMenuManager.h"

@interface DropDownMenuManager()

@property (nonatomic,   weak) UIView *superview;
@property (nonatomic, strong) UIView *backgoundView;
@property (nonatomic,   weak) UIView *menuView;

@end

@implementation DropDownMenuManager

- (void)dealloc {
    _backgoundView = nil;
    _menuView = nil;
}

- (instancetype)initWithSuperview:(UIView*)superview menuView:(UIView*)menuView {
    self = [super init];
    if (self) {
        _superview = superview;
        _menuView = menuView;
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    _backgoundView = [[UIView alloc] init];
    _backgoundView.alpha = 0.0;
    _backgoundView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    _backgoundView.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
    [self.backgoundView addGestureRecognizer:tap];
}

- (void)show {
    if (!self.menuView.superview) {
        if (!self.superview) {
            self.superview = [[UIApplication sharedApplication].windows firstObject];
        }
        self.backgoundView.frame = self.superview.bounds;
        [self.superview addSubview:self.backgoundView];
        [self.superview addSubview:self.menuView];
    }
    
    self.menuView.layer.anchorPoint = CGPointMake(0.5, 0);
    self.menuView.transform = CGAffineTransformMakeScale(1, 0);
    
    [DropDownMenuManager animate:^{
        self.backgoundView.alpha = 0.4;
        self.menuView.alpha = 1.0;
        self.menuView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:NULL];
}

+ (void)animate:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion {
    
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:animations
                     completion:completion];
}

- (void)hide:(BOOL)animated {
    if (!self.superview)
        return;
    if (!animated) {
        [self.backgoundView removeFromSuperview];
        [self.menuView removeFromSuperview];
        if (self.dismissBlock) {
            self.dismissBlock(self);
        }
        return;
    }
    
    self.menuView.transform = CGAffineTransformMakeScale(1, 1);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgoundView.alpha = 0.0;
        self.menuView.alpha = 0.0;
        self.menuView.transform = CGAffineTransformMakeScale(1, 0.001);
    } completion:^(BOOL finished) {
        if (finished) {
            [self.backgoundView removeFromSuperview];
            [self.menuView removeFromSuperview];
        }
    }];
    
    if (self.dismissBlock) {
        self.dismissBlock(self);
    }
}

#pragma mark - UITapGestureRecognizer

- (void)tapGestureRecognizer:(UITapGestureRecognizer*)tap {
    if (self.backgoundTapDismissEnable) {
        [self hide:YES];
        if (self.tapBlock) {
            self.tapBlock(self);
        }
    }
}


@end
