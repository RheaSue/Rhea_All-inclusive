//
//  IAPTableViewController.m
//  Rhea_All-Inclusive
//
//  Created by Rhea on 2021/7/7.
//

#import "IAPTableViewController.h"
#import "IAPViewModel.h"
#import "IAPObserver.h"
#import "IAPManager.h"
#import "Utilities.h"

@interface IAPTableViewController ()<IAPViewModelDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *restoreButton;
@property (weak, nonatomic) IBOutlet UIView *unlockPrimaryFunctionImage;

@property (weak, nonatomic) IBOutlet UILabel *nonConsumableLabel;
@property (weak, nonatomic) IBOutlet UILabel *nonRenewingSubLabel;

@property (weak, nonatomic) IBOutlet UILabel *nonConsumablePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nonRenewingSubPriceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *nonConsumableStatusImage;
@property (weak, nonatomic) IBOutlet UILabel *nonRenewingSubStatusLabel;

@property (strong, nonatomic) IAPViewModel *viewModel;

@end

@implementation IAPTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewModel = [[IAPViewModel alloc] init];
    _viewModel.delegate = self;
    self.restoreButton.enabled = [IAPObserver sharedInstance].isAuthorizedForPayments;
}

#pragma mark - Actions

- (IBAction)restoreAction:(id)sender {
    NSLog(@"------****** start restore purchases ******------");
    [_viewModel restorePurchases];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _viewModel.model.products.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    SKProduct *product = [_viewModel getProductForItem:indexPath.section];
    
    if (indexPath.section == 0) {
        _nonConsumableLabel.text = product? product.localizedTitle:@"";//@"Primary function";
        _nonConsumablePriceLabel.text = product? [NSString stringWithFormat:@"%@ ", product.regularPrice]:@"";
        
        NSString *imageName = @"";
        if (product) imageName = _viewModel.model.nonConsumeModel.isUnlockExtraFunction?@"heart":@"lock";
        _nonConsumableStatusImage.image = [UIImage imageNamed:imageName];
    } else {
        _nonRenewingSubLabel.text = product? product.localizedTitle:@"";//@"Account Upgrade";
        _nonRenewingSubPriceLabel.text = product? [NSString stringWithFormat:@"%@ /Year", product.regularPrice]:@"";
        
        NSString *remainDays = _viewModel.model.nonRenewModel.nonRenewExpiredDate;
        NSString *remainString = _viewModel.model.nonRenewModel.nonRenewQuantity > 0 ? [NSString stringWithFormat:@"Expired Date:\n%@",remainDays] : @"";
        _nonRenewingSubStatusLabel.text = remainString;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        NSLog(@"------****** 购买一次性商品（非消耗品） ******------");
        
        
    } else {
        NSLog(@"------****** 购买订阅产品（非自动续期） ******------");
    }
    
    SKProduct *product = [_viewModel getProductForItem:indexPath.section];
    
    // loading animation
    
    BOOL result = [_viewModel purchaseProduct:product];
    
    if (!result) NSLog(@"------****** 购买产品结果 失败 ******------");
}

- (void)showAlertForProduct:(SKProduct *)product {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:product.localizedTitle
                                                                   message:product.localizedDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Viewmodel Delegate

- (void)willStartProcess {
    
}

- (void)didFinishProcess {
    
}

- (void)shouldUpdateUI {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf.tableView reloadData];
    });
}

@end
