//
//  DropDownMenu.h
//  DropDownMenu
//
//  Created by Rhea on 2021/7/21.
//

#import <UIKit/UIKit.h>

@class DropDownMenu;

@protocol DropDownMenuDelegate <NSObject>

@optional
- (void)dropdownMenu:(DropDownMenu *)menu didSelectedRow:(NSInteger)row;

@end

@interface DropDownMenu : UIView <UITableViewDataSource, UITableViewDelegate>

/**
 下拉列表数据源
 */
@property (nonatomic, strong) NSArray *dataSourceArray;

@property (nonatomic, weak) id<DropDownMenuDelegate> delegate;

/**
 已选中行
 */
@property (nonatomic, assign, readonly) NSInteger selectedRow;

/**
 已选中行背景色
 */
@property (nonatomic, strong) UIColor *selectedRowBgColor;

/**
 未选中行背景色
 */
@property (nonatomic, strong) UIColor *normalRowBgColor;

/**
 设置选择行
 
 @param row 选择的行，若大于或等于dataSource的count，则无效。
 */
- (void)setSelectRow:(NSInteger)row;

- (void)showMenu;

/**
 初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame dataSourceArray:(NSArray *)dataSourceArray;

@end

