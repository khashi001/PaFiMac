//
//  PaFiEngineView.m
//  PaFiMac
//
//  Created by Orange Forest on 2016/08/05.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import "PaFiEngineView.h"


@implementation PaFiEngineView


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
        
        [self drawOXClose:idx chartDataArray:chartDataArray];
        
    }];
    
}




-(void)drawOXClose:(NSUInteger) indexChartElement chartDataArray:(NSArray *)chartDataArray{
    
    BOOL trendProceeding; //前回と今回で枠番号がトレンド方向に進行したか否か
    
    chartJSONData *currentChartData = [chartDataArray objectAtIndex:indexChartElement];
    
    
    switch(currentChartData.currentTrend){
        case TrendStart:
            switch(currentChartData.nextBoxChangeState){
                case BoxChangeST:
                case BoxChangeS:
                    currentChartData.currentTrendBoxPosition = currentChartData.boxPosition
                    break;
                case BoxChangeUP:
                    [self drawTheLine:currentChartData.currentTrendBoxPosition:currentChartData.boxPosition:@"UpTrend"];
                    [self drawDayStr:currentChartData.boxPosition:"UpTrend":currentChartData.date];
                    currentChartData.currentTrend = "UpTrend";
                    currentChartData.currentTrendBoxPosition = currentChartData.boxPosition
                    break;
                case BoxChangeDOWN:
                    [self drawTheLine:currentChartData.currentTrendBoxPosition:currentChartData.boxPosition:@"DownTrend"];
                    [self drawDayStr:currentChartData.boxPosition:@"DownTrend":currentChartData.date];
                    currentChartData.currentTrend = "DownTrend";
                    currentChartData.currentTrendBoxPosition = currentChartData.boxPosition
                    break;
                default
                    break;
            }
            break;
        case TrendUpTrend:
        case BoxChangeUP:
            trendProceeding = [self judgeTrendProceeding:currentTrend:currentChartData.boxPosition:currentChartData.currentTrendBoxPosition];
            if (trendProceeding) { //値がトレンド方向に増えた
                [self drawTheLine:currentChartData.currentTrendBoxPosition:currentChartData.boxPosition:currentTrend];
            				[self drawDayStr:currentChartData.boxPosition:"UpTrend":currentChartData.date];
                currentChartData.currentTrendBoxPosition = currentChartData.boxPosition;
            }
            break;
        case BoxChangeDOWN:
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
        case TrendDown:
        case BoxChangeDOWN:
            trendProceeding = [self judgeTrendProceeding:currentTrend:currentChartData.boxPosition:currentChartData.currentTrendBoxPosition];
            if (trendProceeding) { //値がトレンド方向に増えた
                [self drawTheLine:currentChartData.currentTrendBoxPosition:currentChartData.boxPosition:currentTrend];
            				[self drawDayStr:currentChartData.boxPosition:"DownTrend":currentChartData.date];
                currentChartData.currentTrendBoxPosition = currentChartData.boxPosition;
            }
            break;
        case BoxChangeUP:
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
