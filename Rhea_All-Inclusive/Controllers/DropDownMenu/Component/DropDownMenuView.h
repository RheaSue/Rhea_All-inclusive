//
//  DropDownMenuView.h
//  DropDownMenuView
//
//  Created by Rhea on 2021/7/22.
//

#import <UIKit/UIKit.h>
#import "DropDownMenuManager.h"

@interface DropDownMenuView : UIView

@property (nonatomic, weak) DropDownMenuManager *gx_manager;

- (instancetype)initWithFrame:(CGRect)frame withItems:(NSArray *)items;

- (void)showInView:(UIView *)view fromRect:(CGRect)rect backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable tapBlock:(TapBackgroundBlock)tapBlock dismissBlock:(TapBackgroundBlock)dismissBlock;

@end
