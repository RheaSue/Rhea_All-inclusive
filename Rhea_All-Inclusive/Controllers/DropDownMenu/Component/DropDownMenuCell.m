//
//  DropDownMenuCell.m
//  DropDownMenuCell
//
//  Created by Rhea on 2021/7/21.
//

#import "DropDownMenuCell.h"

@interface DropDownMenuCell()

@end

@implementation DropDownMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    UIView *selectedBgView = [[UIView alloc] initWithFrame:self.bounds];
    selectedBgView.backgroundColor = selected ? _selectedBgColor:_normalBgColor;
    self.selectedBackgroundView = selectedBgView;
}

@end
