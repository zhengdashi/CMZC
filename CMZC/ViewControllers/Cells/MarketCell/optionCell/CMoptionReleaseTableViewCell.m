//
//  CMoptionReleaseTableViewCell.m
//  CMZC
//
//  Created by 郑浩然 on 17/1/7.
//  Copyright © 2017年 郑浩然. All rights reserved.
//

#import "CMoptionReleaseTableViewCell.h"


@interface CMoptionReleaseTableViewCell () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *optionLab;

@end


@implementation CMoptionReleaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _textView.layer.backgroundColor = [[UIColor clearColor] CGColor];
    _textView.layer.borderColor = [[UIColor cmSomberColor] CGColor];
    _textView.layer.borderWidth = 1.0f;
    _textView.layer.cornerRadius = 8.0f;
    [_textView.layer setMasksToBounds:YES];
    _textView.textColor = [UIColor whiteColor];
    _textView.delegate = self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.block();
    _optionLab.hidden = YES;
}
- (IBAction)releaseBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(cm_optionReleaseRequestData:)]) {
        [self.delegate cm_optionReleaseRequestData:_textView.text];
    }
}

@end
