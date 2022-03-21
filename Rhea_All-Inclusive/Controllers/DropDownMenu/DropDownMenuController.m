//
//  DropDownMenuController.m
//  DropDownMenuController
//
//  Created by Rhea on 2021/7/21.
//

#import "DropDownMenuController.h"
#import "DropDownMenu.h"
#import "DropDownMenuView.h"

@interface DropDownMenuController ()<DropDownMenuDelegate>

@property (weak, nonatomic) IBOutlet UILabel *tapTextLabel;

@property (strong, nonatomic) DropDownMenu *menu;

@property (strong, nonatomic) DropDownMenuView *menuView;
@end

@implementation DropDownMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
//    _menu = [[DropDownMenu alloc] initWithFrame:CGRectMake(20, 300, 350, 200) dataSourceArray:array];
//    _menu.delegate = self;
//    _menu.backgroundColor = [UIColor systemCyanColor];
//    _menu.selectedRowBgColor = [UIColor redColor];
//    _menu.normalRowBgColor = [UIColor systemBlueColor];
//    [self.view addSubview:_menu];
    
    
}

- (IBAction)labelTapAction:(id)sender {
    NSLog(@"tap tap tap");
    
//    [_menu showMenu];
//    CGRect test = _menu.frame;
    NSArray *array = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
    DropDownMenuView *menu = [[DropDownMenuView alloc] initWithFrame:CGRectMake(0, 400, 300, 600) withItems:array];
    [menu showInView:self.view fromRect:CGRectMake(0, 400, 300, 600) backgoundTapDismissEnable:YES tapBlock:nil dismissBlock:nil];
}

- (void)dropdownMenu:(DropDownMenu *)menu didSelectedRow:(NSInteger)row {
    
}

@end
