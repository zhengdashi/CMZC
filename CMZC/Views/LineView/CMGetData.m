//
//  CMGetData.m
//  CMZC
//
//  Created by 财猫 on 16/5/9.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMGetData.h"

@implementation CMGetData

-(instancetype)init{
    self = [super init];
    if (self){
        self.isFinish = NO;
        self.maxValue = 0;
        self.minValue = CGFLOAT_MAX;
        self.volMaxValue = 0;
        self.volMinValue = CGFLOAT_MAX;
    }
    return  self;
}


-(instancetype)initWithUrl:(NSString*)url{
    if (self) {
        // 取缓存的每天数据
        NSArray *tempArray = (NSArray*)GetDataFromNSUserDefaults(@"daydatas");
        if (tempArray.count>0) {
            self.dayDatas = tempArray;
        }
        //测试 先注销
        NSArray *lines = (NSArray*)GetDataFromNSUserDefaults([NSString stringWithFormat:@"%@",url]);
        if (lines.count>0) {
            //缓存中有数据
            [self changeData:lines];
        }else{
            //请求数据
            [CMRequestAPI cm_marketFetchProductKlineDayCode:@"2001" productUrl:url success:^(NSArray *klineDayArr) {
                self.status.text = @"";
                if ([self.req_type isEqualToString:@"d"]) {
                    self.dayDatas = lines;
                    SaveDataToNSUserDefaults(klineDayArr, @"daydatas");
                }
                SaveDataToNSUserDefaults(klineDayArr, [NSString stringWithFormat:@"%@",url]);
                
                [self changeData:klineDayArr];
                self.isFinish = YES;
            } fail:^(NSError *error) {
                MyLog(@"请求日k失败了");
            }];
            
        }
    }
    return self;
 }

    
-(void)changeData:(NSArray*)lines{
    NSMutableArray *data =[[NSMutableArray alloc] init];
    NSMutableArray *category =[[NSMutableArray alloc] init];
    NSArray *newArray = lines;
    newArray = [newArray objectsAtIndexes:[[NSIndexSet alloc] initWithIndexesInRange:
                                           NSMakeRange(0, self.kCount>=newArray.count?newArray.count:self.kCount)]]; // 只要前面指定的数据
    //NSLog(@"lines:%@",newArray);
    NSInteger idx;
    int MA5=5,MA10=10,MA20=20; // 均线统计
    for (idx = newArray.count-1; idx > 0; idx--) {
        NSString *line = [newArray objectAtIndex:idx];
        if([line isEqualToString:@""]){
            continue;
        }
        NSArray   *arr = [line componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        // 收盘价的最小值和最大值
        if ([[arr objectAtIndex:2] floatValue]>self.maxValue) {
            self.maxValue = [[arr objectAtIndex:2] floatValue];
        }
        if ([[arr objectAtIndex:3] floatValue]<self.minValue) {
            self.minValue = [[arr objectAtIndex:3] floatValue];
        }
        // 成交量的最大值最小值
        if ([[arr objectAtIndex:5] floatValue]>self.volMaxValue) {
            self.volMaxValue = [[arr objectAtIndex:5] floatValue];
        }
        if ([[arr objectAtIndex:5] floatValue]<self.volMinValue) {
            self.volMinValue = [[arr objectAtIndex:5] floatValue];
        }
        NSMutableArray *item =[[NSMutableArray alloc] init];
        [item addObject:[arr objectAtIndex:1]]; // open 开盘价
        [item addObject:[arr objectAtIndex:2]]; // high 最高
        [item addObject:[arr objectAtIndex:3]]; // low 最低
        [item addObject:[arr objectAtIndex:4]]; // close 收盘
        [item addObject:[arr objectAtIndex:5]]; // volume 成交量
        CGFloat idxLocation = [lines indexOfObject:line];
        // MA5
        [item addObject:[NSNumber numberWithFloat:[self sumArrayWithData:lines andRange:NSMakeRange(idxLocation, MA5)]]]; // 前五日收盘价平均值
        // MA10
        [item addObject:[NSNumber numberWithFloat:[self sumArrayWithData:lines andRange:NSMakeRange(idxLocation, MA10)]]]; // 前十日收盘价平均值
        // MA20
        [item addObject:[NSNumber numberWithFloat:[self sumArrayWithData:lines andRange:NSMakeRange(idxLocation, MA20)]]]; // 前二十日收盘价平均值
        // 前面二十个数据不要了，因为只是用来画均线的
        [category addObject:[arr objectAtIndex:0]]; // date
        [data addObject:item];
    }
    if(data.count==0){
        self.status.text = @"Error!";
        return;
    }
    
    self.data = data; // Open,High,Low,Close,Adj Close,Volume
    self.category = category; // Date
    
}
-(CGFloat)sumArrayWithData:(NSArray*)data andRange:(NSRange)range{
    CGFloat value = 0;
    if (data.count - range.location>range.length) {
        NSArray *newArray = [data objectsAtIndexes:[[NSIndexSet alloc] initWithIndexesInRange:range]];
        for (NSString *item in newArray) {
            NSArray *arr = [item componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
            value += [[arr objectAtIndex:4] floatValue];
        }
        if (value>0) {
            value = value / newArray.count;
        }
    }
    return value;
}
@end
