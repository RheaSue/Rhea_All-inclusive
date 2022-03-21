//
//  DropDownMenu.m
//  DropDownMenu
//
//  Created by Rhea on 2021/7/21.
//

#import <Foundation/Foundation.h>
#import "DropDownMenu.h"
#import "DropDownMenuCell.h"

#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size

static const CGFloat cellHeight = 30.f;

@interface DropDownMenu()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) id selectedItem;
@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, assign) CGRect rect;
@property (nonatomic, assign) NSInteger currentSelectedIndex;

@property (nonatomic, assign) CGFloat dropDownViewWidth;

@end

@implementation DropDownMenu

- (instancetype)initWithFrame:(CGRect)frame dataSourceArray:(NSArray *)dataSourceArray {
    
    CGRect frameRect = frame;
    CGFloat originalHeight = frame.size.height;
    CGFloat totalHeight = 0.f;
    if (dataSourceArray && dataSourceArray.count > 0) {
        totalHeight = dataSourceArray.count * cellHeight;
        
        if (totalHeight > originalHeight) {
            totalHeight = originalHeight;
        }
    }
    frameRect.size = CGSizeMake(frameRect.size.width, totalHeight);
    CGRect test = frameRect;
    test.size = CGSizeMake(frameRect.size.width, 0);
    
    self = [super initWithFrame:test];
    if (self) {
        _rect = frameRect;
        _isShow = NO;
        _currentSelectedIndex = 0;
        _dataSourceArray = [NSArray arrayWithArray:dataSourceArray];
        _selectedRowBgColor = [UIColor lightGrayColor];
        _normalRowBgColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 16.f;
        self.layer.shadowColor = [UIColor colorWithWhite:1 alpha:0.2].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0.22;
        self.clipsToBounds = NO;
        
        
    }
    return self;
}

#pragma mark - Interface method
- (void)showMenu {
    self.isShow = YES;
}

- (void)hideMenu {
    self.isShow = NO;
}

- (void)setSelectRow:(NSInteger)row {
    if (self.dataSourceArray && self.dataSourceArray.count > row) {
        self.selectedItem = self.dataSourceArray[row];
        self.currentSelectedIndex = row;
    }
}

#pragma mark - Private method
- (void)setIsShow:(BOOL)isShow {
    _isShow = isShow;
    
    [self animateTableView:self.tableView show:_isShow complete:^{
        
    }];
}

- (void)animateTableView:(UITableView *)tableView show:(BOOL)show complete:(void(^)(void))complete {
    if (show) {
        CGRect toFrame = self.rect;
        CGRect toFrame2 = CGRectMake(0, 0, self.rect.size.width, self.rect.size.height);
        
        [UIView animateWithDuration:0.2 animations:^{
            CGRect test = self.frame;
            self.tableView.frame = toFrame2;
            self.frame = toFrame;
            CGRect test2 = self.frame;
        } completion:^(BOOL finished) {
            BOOL b = 1;
//            NSLog(self.frame);
//            NSLog(self.tableView.frame);
        }];
        
    } else {
        CGRect toFrame = CGRectMake(self.rect.origin.x, self.rect.origin.y, self.rect.size.width, 0);
        CGRect toFrame2 = CGRectMake(0, 0, self.rect.size.width, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.tableView.frame = toFrame2;
            self.frame = toFrame;
        } completion:^(BOOL finished) {
            [self.tableView removeFromSuperview];
            if (self.delegate && [self.delegate respondsToSelector:@selector(dropdownMenu:didSelectedRow:)]) {
                [self.delegate dropdownMenu:self didSelectedRow:self.currentSelectedIndex];
            }
        }];
    }
    complete();
}

#pragma mark - Setter
- (void)setDataSourceArray:(NSArray *)dataSourceArray {
    _dataSourceArray = dataSourceArray;
    
    if (_dataSourceArray && dataSourceArray.count > 0) {
        if (_selectedItem && [_dataSourceArray containsObject:_selectedItem]) {
            _currentSelectedIndex = [_dataSourceArray indexOfObject:_selectedItem];
        } else {
            _selectedItem = dataSourceArray[0];
            _currentSelectedIndex = 0;
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor systemPurpleColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = cellHeight;
        tableView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        tableView.tableFooterView = [UIView new];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.clipsToBounds = YES;
        [tableView registerClass:[DropDownMenuCell class] forCellReuseIdentifier:@"DropDownMenuCell"];
        
        if (@available(iOS 15.0, *)) {
            tableView.sectionHeaderTopPadding = 0;
        }
        
        _tableView = tableView;
        
        [self addSubview:_tableView];
        
    }
    return _tableView;
}

- (NSInteger)selectedRow {
    return self.currentSelectedIndex;
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DropDownMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DropDownMenuCell" forIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"wifi %ld", (long)indexPath.row];
    cell.subTitleLabel.text = indexPath.row/2 > 0 ? @"(2.4G)" : @"(5G)";
    cell.selectedBgColor = _selectedRowBgColor;
    cell.normalBgColor = _normalRowBgColor;
    
    [cell setSelected:(indexPath.row == self.currentSelectedIndex)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentSelectedIndex = indexPath.row;
    self.selectedItem = self.dataSourceArray[indexPath.row];
    
    self.isShow = NO;
}

@end
