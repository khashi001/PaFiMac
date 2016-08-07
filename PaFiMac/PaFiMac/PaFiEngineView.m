//
//  PaFiEngineView.m
//  PaFiMac
//
//  Created by Orange Forest on 2016/08/05.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import "PaFiEngineView.h"


@implementation PaFiEngineView

typedef NS_ENUM(NSInteger, BoxChangeState) {
    BoxChangeST = 0, //"start"
    BoxChangeS = 1,  //"S"
    BoxChangeUP = 2,  //"U"
    BoxChangeDOWN = 3,  //"D"
};

typedef NS_ENUM(NSInteger, TrendState) {
    TrendStart = 0,
    TrendUpTrend = 1,
    TrendDown = 2,
};

#pragma mark Graphic
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [NSBezierPath strokeLineFromPoint:NSMakePoint(0, 0) toPoint:NSMakePoint(100, 100)];
    
    NSLog(@"PaFiEngineView:drawRect. ここでは描画データセットを元に描画を行います。");
}


#pragma mark PaFi Engine

-(void)drawOXonPaFiEngineView:(NSArray *)chartDataArray{
    
    [chartDataArray enumerateObjectsUsingBlock:^(chartJSONData *data, NSUInteger idx, BOOL *stop){
        
        [self drawOXClose:idx];
        
    }];
    
}




-(void)drawOXClose:(NSUInteger) indexChartElement{
    
    BOOL trendProceeding; //前回と今回で枠番号がトレンド方向に進行したか否か
    
    chartJSONData *currentChartData = [self.chartDataArray objectAtIndex:indexChartElement]);
    
    
    switch(currentChartData.currentTrend){
        case "start"
            switch(currentChartData.nextBoxChangeState){
                case "ST"
                case "S"
                    currentChartData.currentTrendBoxPosition = currentChartData.boxPosition
                    break;
                case "U"
                    [self drawTheLine:currentChartData.currentTrendBoxPosition:currentChartData.boxPosition:@"UpTrend"];
                    [self drawDayStr:currentChartData.boxPosition:"UpTrend":currentChartData.date];
                    currentChartData.currentTrend = "UpTrend";
                    currentChartData.currentTrendBoxPosition = currentChartData.boxPosition
                    break;
                case "D"
                    [self drawTheLine:currentChartData.currentTrendBoxPosition:currentChartData.boxPosition:@"DownTrend"];
                    [self drawDayStr:currentChartData.boxPosition:@"DownTrend":currentChartData.date];
                    currentChartData.currentTrend = "DownTrend";
                    currentChartData.currentTrendBoxPosition = currentChartData.boxPosition
                    break;
                default
                    break;
            }
            break;
        case "UpTrend"
        case "U"
            trendProceeding = [self judgeTrendProceeding:currentTrend:currentChartData.boxPosition:currentChartData.currentTrendBoxPosition];
            if (trendProceeding) { //値がトレンド方向に増えた
                [self drawTheLine:currentChartData.currentTrendBoxPosition:currentChartData.boxPosition:currentTrend];
            				[self drawDayStr:currentChartData.boxPosition:"UpTrend":currentChartData.date];
                currentChartData.currentTrendBoxPosition = currentChartData.boxPosition;
            }
            break;
        case "D"
            if (abs(currentChartData.boxPosition - currentChartData.currentTrendBoxPosition) >= self.myPaFi.reversalAmount){ //転換条件に適合した
                [self moveToNextColumn];
                currentChartData.currentTrendBoxPosition --; //転換後は１枠下から描く
                [self drawTheLine:currentChartData.currentTrendBoxPosition:currentChartData.boxPosition:@"DownTrend"];
                [self drawDayStr:currentChartData.boxPosition:@"DownTrend":currentChartData.date];
                currentChartData.currentTrendBoxPosition = currentChartData.boxPosition;
                currentChartData.currentTrend = "DownTrend";
            }
            else{
                //なにもしない
            }
            break;
        default
            break;
            break;
        case "DownTrend"
        case "D"
            trendProceeding = [self judgeTrendProceeding:currentTrend:currentChartData.boxPosition:currentChartData.currentTrendBoxPosition];
            if (trendProceeding) { //値がトレンド方向に増えた
                [self drawTheLine:currentChartData.currentTrendBoxPosition:currentChartData.boxPosition:currentTrend];
            				[self drawDayStr:currentChartData.boxPosition:"DownTrend":currentChartData.date];
                currentChartData.currentTrendBoxPosition = currentChartData.boxPosition;
            }
            break;
        case "U"
            if (abs(currentChartData.boxPosition - currentChartData.currentTrendBoxPosition) >= self.myPaFi.reversalAmount){ //転換条件に適合した
                [self moveToNextColumn];
                currentChartData.currentTrendBoxPosition ++; //転換後は１枠下から描く
                [self drawTheLine:currentChartData.currentTrendBoxPosition:currentChartData.boxPosition:@"UpTrend"];
                [self drawDayStr:currentChartData.boxPosition:@"UpTrend":currentChartData.date];
                currentChartData.currentTrendBoxPosition = currentChartData.boxPosition;
                currentChartData.currentTrend = "UpTrend";
            }
            else{
                //なにもしない
            }
            break;
        default
            //ありえない
            break;
            break;
            
    }
    
}


-(void)moveToNextColumn{
    
    self.drawColumn++;
    
}


-(BOOL)judgeTrendProceeding:(NSString *)currentTrend currentPosition:(NSInteger)currentPosition previousPosition:(NSInteger)previousPosition{
    
    //トレンドが継続している場合のために、前回からトレンド方向に進んだか否かを判断する
    trendProceeding = NO;
    switch(currentTrend){
        case @"UpTrend":
            if( currentPosition > previousPosition){
                judgeTrendProceeding = YES;
            }
            break;
        case @"DownTrend":
            if( currentPosition < previousPosition){
                judgeTrendProceeding = YES;
            }
            break;
    }
    
}


-(void)drawTheLine:(NSInteger)startBoxPosition endBoxPosition:(NSInteger)endBoxPosition mode:(NSString *)mode{
    
    NSinteger count;
    for(count=startBoxPosition; count<=endBoxPosition ; count++){
        [self drawOneCell:count:mode];
    }
}

-(void)drawOneCell:(NSInteger)boxPosition mode:(NSString*)mode{
    //boxPositionの位置を座標に変換し、modeで指定された印(OX)を描く。
}

-(void)drawDayStr:(NSInteger)boxPosition mode:(NSString*)date{
    //boxPositionのすぐ近くに、dateの日付を描く。
}

@end
