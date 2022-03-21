//
//  DropDownMenuCell.h
//  DropDownMenuCell
//
//  Created by Rhea on 2021/7/21.
//

#import <UIKit/UIKit.h>

@interface DropDownMenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (strong, nonatomic) UIColor *selectedBgColor;
@property (strong, nonatomic) UIColor *normalBgColor;

@end
