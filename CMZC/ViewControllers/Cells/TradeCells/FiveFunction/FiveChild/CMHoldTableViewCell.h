//
//  CMHoldTableViewCell.h
//  CMZC
//
//  Created by 财猫 on 16/6/4.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMHoldTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *jumpImage;
- (void)titleName:(NSString *)title introduce:(NSString *)introduce;

@end
