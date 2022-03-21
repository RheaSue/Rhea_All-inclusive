//
//  DropDownMenuManager.h
//  DropDownMenuManager
//
//  Created by Rhea on 2021/7/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^TapBackgroundBlock)(id obj);

@interface DropDownMenuManager : NSObject

/**
 背景
 */
@property (nonatomic, readonly) UIView *backgoundView;

/**
 列表视图
 */
@property (nonatomic, weak, readonly) UIView *menuView;

/**
 背景点击dismiss是否有效，default NO
 */
@property (nonatomic, assign) BOOL backgoundTapDismissEnable;

/**
 点击背景的回调
 */
@property (nonatomic,   copy) TapBackgroundBlock tapBlock;

/**
 dismiss的回调
 */
@property (nonatomic,   copy) TapBackgroundBlock dismissBlock;

- (instancetype)initWithSuperview:(UIView*)superview menuView:(UIView*)menuView;

- (void)show;

- (void)hide:(BOOL)animated;

@end
