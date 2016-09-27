//
//  LineFenShiModel.m
//  TestChart
//
//  Created by Ever on 15/12/18.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "EverLineModel.h"
#import "Section.h"
#import "EverChart.h"
#import "EverMacro.h"

@implementation EverLineModel

-(void)drawSerie:(EverChart *)chart serie:(NSMutableDictionary *)serie{
    if([serie objectForKey:@"data"] == nil || [[serie objectForKey:@"data"] count] == 0){
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, YES);
    CGContextSetLineWidth(context, 1.0f);
    
    NSMutableArray *data          = [serie objectForKey:@"data"];
    int            yAxis          = [[serie objectForKey:@"yAxis"] intValue];
    int            section        = [[serie objectForKey:@"section"] intValue];
    UIColor       *color         = [serie objectForKey:@"color"];
    
    Section *sec = [chart.sections objectAtIndex:section];
    
    //设置选中点 竖线以及小球颜色
    //TOOD8
    
    CGContextSetShouldAntialias(context, YES);
    for(int i=chart.rangeFrom;i<chart.rangeTo;i++){
        if(i == data.count-1){
            break;
        }
        if([data objectAtIndex:i] == nil){
            continue;
        }
        if (i<chart.rangeTo-1 && [data objectAtIndex:(i+1)] != nil) {
            float value = [[[data objectAtIndex:i] objectAtIndex:0] floatValue];
            float ix  = sec.frame.origin.x+sec.paddingLeft+(i-chart.rangeFrom)*chart.plotWidth;
            float iNx  = sec.frame.origin.x+sec.paddingLeft+(i+1-chart.rangeFrom)*chart.plotWidth;
            float iy = [chart getLocalY:value withSection:section withAxis:yAxis];
            CGContextSetStrokeColorWithColor(context, color.CGColor);
            CGContextMoveToPoint(context, ix+chart.plotWidth/2, iy);
            
            float y = [chart getLocalY:([[[data objectAtIndex:(i+1)] objectAtIndex:0] floatValue]) withSection:section withAxis:yAxis];
            if(!isnan(y)){
                CGContextAddLineToPoint(context, iNx+chart.plotWidth/2, y);
            }
            
            CGContextStrokePath(context);
        }
    }
    
}

-(void)setValuesForYAxis:(EverChart *)chart serie:(NSDictionary *)serie{
    if([[serie objectForKey:@"data"] count] == 0){
        return;
    }
    
    NSMutableArray *data    = [serie objectForKey:@"data"];
    NSString       *yAxis   = [serie objectForKey:@"yAxis"];
    NSString       *yAxisType   = [serie objectForKey:@"yAxisType"];
    NSString       *section = [serie objectForKey:@"section"];
    
    YAxis *yaxis = [[[chart.sections objectAtIndex:[section intValue]] yAxises] objectAtIndex:[yAxis intValue]];
    if([serie objectForKey:@"decimal"] != nil){
        yaxis.decimal = [[serie objectForKey:@"decimal"] intValue];
    }
    
    float value = [[[data objectAtIndex:chart.rangeFrom] objectAtIndex:0] floatValue];
    
    if(!yaxis.isUsed){
        [yaxis setMax:value];
        [yaxis setMin:value];
        yaxis.isUsed = YES;
    }
    
    //实时价格线:  Y轴区间:昨天收盘价 上下浮动最大涨跌幅； 当前最大涨跌幅 ：（最大/最小 - 昨天收盘价）/ 昨天收盘价
    if ([yAxisType isEqualToString:@"1"]) {
        
        float maxNow = 0,minNow = MAXFLOAT;
        float closeYesterday = [[data[0] objectAtIndex:0] floatValue];
        
        for(int i = 0; i < data.count; i++) {
            NSArray *tmpArray = data[i];
            float now = [tmpArray[0] floatValue];
            if (minNow > now) {
                minNow = now;
            }
            else if (maxNow < now) {
                maxNow = now;
            }
        }
        
        float percentMax = (maxNow - closeYesterday)/closeYesterday;
        float percentMin = (minNow - closeYesterday)/closeYesterday;
        float percent = MAX(fabs(percentMax), fabs(percentMin)) ;
        float maxY = closeYesterday * (1 + percent);
        float minY = closeYesterday * (1 - percent);
        float closeY =closeYesterday+2;
        if (maxY > closeY) {
            [yaxis setMax:maxY];
        } else {
            [yaxis setMax:closeYesterday+2];
        }
        CGFloat closeMinY = closeYesterday-2;
        if (minY < closeMinY) {
            [yaxis setMin:minY];
        } else {
            [yaxis setMin:closeYesterday-2];
        }
        
        
       // NSLog(@"min:%f,max:%f，closeY :%f",minY,maxY,closeYesterday);
        
        return;
    }
    
    for(int i=chart.rangeFrom;i<chart.rangeTo;i++){
        if(i == data.count){
            break;
        }
        if([data objectAtIndex:i] == nil){
            continue;
        }
        
        float value = [[[data objectAtIndex:i] objectAtIndex:0] floatValue];
        if(value > [yaxis max])
            [yaxis setMax:value];
        if(value < [yaxis min])
            [yaxis setMin:value];
    }
}

-(void)setLabel:(EverChart *)chart label:(NSMutableArray *)label forSerie:(NSMutableDictionary *) serie{
    if([serie objectForKey:@"data"] == nil || [[serie objectForKey:@"data"] count] == 0){
        return;
    }
    //TOOD3
    NSMutableArray *data          = [serie objectForKey:@"data"];
   
    NSString       *yAxisType     = [serie objectForKey:@"yAxisType"];
    UIColor       *color         = [serie objectForKey:@"color"];
    NSString *format = @"";
    
    if(chart.selectedIndex!=-1 && chart.selectedIndex < data.count && [data objectAtIndex:chart.selectedIndex]!=nil){
        float value = [[[data objectAtIndex:chart.selectedIndex] objectAtIndex:0] floatValue];
        
        if ([yAxisType isEqualToString:@"1"]) {
            
            float closeYesterday = [[[data objectAtIndex:chart.selectedIndex] objectAtIndex:1] floatValue];
            UIColor *lblColor = [UIColor grayColor];
            
            if (value < closeYesterday) { //下跌
                lblColor = kFenShiDownColor;
            }
            else if(value > closeYesterday){ //上涨
                lblColor = kFenShiUpColor;
            }
            else{ //持平
                lblColor = kFenShiEqualColor;
            }
            //TOOD4
            //实时价格标签
            
            
        }else {
            
            NSString *text = [NSString stringWithFormat:format,value];
            
            NSDictionary *tmp = @{@"text":text,@"color":color};
            [label addObject:tmp];

        }
        
    }
}

-(void)drawTips:(EverChart *)chart serie:(NSMutableDictionary *)serie{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, NO);
    CGContextSetLineWidth(context, 1.0f);
    
    NSMutableArray *data          = [serie objectForKey:@"data"];
    NSString       *type          = [serie objectForKey:@"type"];
    int            section        = [[serie objectForKey:@"section"] intValue];
    NSMutableArray *category      = [serie objectForKey:@"category"];
    Section *sec = [chart.sections objectAtIndex:section];
    
    if([type isEqualToString:kFenShiLine]){
        for(int i=chart.rangeFrom;i<chart.rangeTo;i++){
            if(i == data.count){
                break;
            }
            if([data objectAtIndex:i] == nil){
                continue;
            }
            
            float ix  = sec.frame.origin.x+sec.paddingLeft+(i-chart.rangeFrom)*chart.plotWidth;
            
            if(i == chart.selectedIndex && chart.selectedIndex < data.count && [data objectAtIndex:chart.selectedIndex]!=nil){
                
                NSString *tipsText = [NSString stringWithFormat:@"%@",[category objectAtIndex:chart.selectedIndex]];
                
                CGContextSetShouldAntialias(context, YES);
                CGContextSetStrokeColorWithColor(context, kYFontColor.CGColor);
                CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
                
                CGSize size = [tipsText sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:kYFontSizeFenShi]}];
                
                int x = ix+chart.plotWidth/2;
                int y = sec.frame.origin.y+sec.paddingTop;
                if(x+size.width > sec.frame.size.width+sec.frame.origin.x){
                    x= x-(size.width+4);
                }
                CGContextFillRect (context, CGRectMake (x, y, size.width+4,size.height+2));
                UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, size.width+4,size.height+2) cornerRadius:4];
                CGContextAddPath(context, path.CGPath);
                CGContextStrokePath(context);
                
                [tipsText drawAtPoint:CGPointMake(x+2,y+1) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:kYFontSizeFenShi]}];
                CGContextSetShouldAntialias(context, NO);
                
                
            }
        }
    }
    
}

@end
