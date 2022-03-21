//
//  HCDropDownMenu.m
//  HCDropDownMenu
//
//  Created by Rhea on 2021/7/22.
//

#import "HCDropDownMenu.h"
#import <UIKit/UIKit.h>


@interface HCDropDownMenuView : UIView

/**
 *  @method
 *  @brief 隐藏Menu
 *
 *  @param animated 是否有动画
 */
- (void)dismissMenu:(BOOL)animated;

@end

@implementation HCDropDownMenuView {
    UITableView *_contentTableView;
    NSArray *_menuItems;
    NSInteger currentSelectedIndex;
    id selectedItem;
}

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
    }
    return self;
}

- (void)setupFrameInView:(UIView *)view fromRect:(CGRect)fromRect {
    
}

- (void)showMenuInView:(id)view withFrame:(id)frame menuItems:(NSArray *)menuItems {
    _menuItems = menuItems;
}

@end

@interface HCDropDownMenu()

+ (instancetype)sharedMenu;

/// 视图当前是否显示
@property(nonatomic, assign) BOOL isShow;

/// 重置属性
+ (void)reset;

@end

@implementation HCDropDownMenu

+ (void)showMenuInView:(id)view withFrame:(id)frame dataSourceArray:(NSArray *)dataSourceArray {
    
}

@end
