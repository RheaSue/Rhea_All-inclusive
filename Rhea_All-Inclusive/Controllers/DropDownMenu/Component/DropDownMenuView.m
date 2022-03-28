//
//  DropDownMenuView.m
//  DropDownMenuView
//
//  Created by Rhea on 2021/7/22.
//

#import "DropDownMenuView.h"
#import <objc/runtime.h>

static const CGFloat cellHeight = 30.f;

@interface DropDownMenuView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *items;
//@property (nonatomic, strong) DropDownMenuManager *gx_manager;

@end

@implementation DropDownMenuView

static const char DP_MANAGER = '\0';
- (void)setDp_manager:(DropDownMenuManager *)dp_manager {
    objc_setAssociatedObject(self, &DP_MANAGER, dp_manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DropDownMenuManager *)dp_manager {
    return objc_getAssociatedObject(self, &DP_MANAGER);
}

- (instancetype)initWithFrame:(CGRect)frame withItems:(NSArray *)items;
{
    CGRect frameRect = frame;
    CGFloat originalHeight = frame.size.height;
    CGFloat totalHeight = 0.f;
    if (items && items.count > 0) {
        totalHeight = items.count * cellHeight;
        
        if (totalHeight > originalHeight) {
            totalHeight = originalHeight;
        }
    }
    frameRect.size = CGSizeMake(frameRect.size.width, totalHeight);
    CGRect test = frameRect;
    test.size = CGSizeMake(frameRect.size.width, 0);
    
    self = [super initWithFrame:frameRect];
    if (self) {
        _items = items;
        [self createSubviews];
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)showInView:(UIView *)view fromRect:(CGRect)rect backgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable tapBlock:(TapBackgroundBlock)tapBlock dismissBlock:(TapBackgroundBlock)dismissBlock {
    DropDownMenuManager *manager = [[DropDownMenuManager alloc] initWithSuperview:view menuView:self];
    manager.backgoundTapDismissEnable = YES;
    manager.tapBlock = tapBlock;
    manager.dismissBlock = dismissBlock;
    [manager show];
    self.dp_manager = manager;
}

- (void)hideToView {
    [self hideToView:YES];
}

- (void)hideToView:(BOOL)animated {
    if (self.dp_manager) {
        [self.dp_manager hide:animated];
    }
}

- (void)createSubviews {
    self.backgroundColor = [UIColor lightGrayColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    self.tableView.rowHeight = 30.0;
    self.tableView.estimatedRowHeight = 0.0;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.layer.cornerRadius = 20;
    [self addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"ITEM %02ld",indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"test test");
}

@end
