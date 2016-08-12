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
    
    [self drawOXonPaFiEngineView];
}


#pragma mark PaFi Engine

-(void)drawOXonPaFiEngineView{
    
    self.myPaFi = [PaFi sharedPaFi];
    NSArray *chartDataArray = self.myPaFi.chartDataArray;
    
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
                    currentChartData.currentTrendBoxPosition = currentChartData.boxPosition;
                    break;
                case BoxChangeUP:
                    [self drawTheLine:currentChartData.currentTrendBoxPosition endBoxPosition:currentChartData.boxPosition mode:TrendUpTrend];
                    [self drawDayStr:currentChartData.boxPosition date:currentChartData.date];
                    currentChartData.currentTrend = TrendUpTrend;
                    currentChartData.currentTrendBoxPosition = currentChartData.boxPosition;
                    break;
                case BoxChangeDOWN:
                    [self drawTheLine:currentChartData.currentTrendBoxPosition endBoxPosition:currentChartData.boxPosition mode:TrendUpTrend];
                    [self drawDayStr:currentChartData.boxPosition date:currentChartData.date];
                    currentChartData.currentTrend = TrendDown;
                    currentChartData.currentTrendBoxPosition = currentChartData.boxPosition;
                    break;
                default:
                    break;
            }
            break;
        case TrendUpTrend:
            switch (currentChartData.boxChangeState) {
                case BoxChangeUP:
                    trendProceeding = [self judgeTrendProceeding:currentChartData.currentTrend currentPosition:currentChartData.boxPosition previousPosition:currentChartData.currentTrendBoxPosition];
                    if (trendProceeding) { //値がトレンド方向に増えた
                        [self drawTheLine:currentChartData.currentTrendBoxPosition endBoxPosition:currentChartData.boxPosition mode:currentChartData.currentTrend];
                        [self drawDayStr:currentChartData.boxPosition date:currentChartData.date];
                        currentChartData.currentTrendBoxPosition = currentChartData.boxPosition;
                    }
                    break;
                case BoxChangeDOWN:
                    if (labs(currentChartData.boxPosition - currentChartData.currentTrendBoxPosition) >= self.myPaFi.reversalAmount){ //転換条件に適合した
                        [self moveToNextColumn];
                        currentChartData.currentTrendBoxPosition --; //転換後は１枠下から描く
                        [self drawTheLine:currentChartData.currentTrendBoxPosition endBoxPosition:currentChartData.boxPosition mode:TrendDown];
                        [self drawDayStr:currentChartData.boxPosition date:currentChartData.date];
                        currentChartData.currentTrendBoxPosition = currentChartData.boxPosition;
                        currentChartData.currentTrend = TrendDown;
                    }
                    else{
                        //なにもしない
                    }
                    break;
                default:
                    break;
            }
            break;
        case TrendDown:
            switch (currentChartData.boxChangeState){
                case BoxChangeDOWN:
                    trendProceeding = [self judgeTrendProceeding:currentChartData.currentTrend currentPosition:currentChartData.boxPosition previousPosition:currentChartData.currentTrendBoxPosition];
                    if (trendProceeding) { //値がトレンド方向に増えた
                        [self drawTheLine:currentChartData.currentTrendBoxPosition
                           endBoxPosition:currentChartData.boxPosition
                                     mode:currentChartData.currentTrend];
                        [self drawDayStr:currentChartData.boxPosition date:currentChartData.date];
                        currentChartData.currentTrendBoxPosition = currentChartData.boxPosition;
                    }
                    break;
                case BoxChangeUP:
                    if (labs(currentChartData.boxPosition - currentChartData.currentTrendBoxPosition) >= self.myPaFi.reversalAmount){ //転換条件に適合した
                        [self moveToNextColumn];
                        currentChartData.currentTrendBoxPosition ++; //転換後は１枠下から描く
                        [self drawTheLine:currentChartData.currentTrendBoxPosition
                           endBoxPosition:currentChartData.boxPosition
                                     mode:TrendUpTrend];
                        [self drawDayStr:currentChartData.boxPosition date:currentChartData.date];
                        currentChartData.currentTrendBoxPosition = currentChartData.boxPosition;
                        currentChartData.currentTrend = TrendUpTrend;
                    }
                    else{
                        //なにもしない
                    }
                    break;
                default:
                    //ありえない
                    break;
            }
            break;
            
    }
    
}


-(void)moveToNextColumn{
    
    self.drawColumn++;
    
}


-(BOOL)judgeTrendProceeding:(TrendState)currentTrend currentPosition:(NSInteger)currentPosition previousPosition:(NSInteger)previousPosition{
    
    //トレンドが継続している場合のために、前回からトレンド方向に進んだか否かを判断する
    BOOL result = NO;
    switch(currentTrend){
        case TrendUpTrend:
            if( currentPosition > previousPosition){
                result = YES;
            }
            break;
        case TrendDown:
            if( currentPosition < previousPosition){
                result = YES;
            }
            break;
        default:
            result = NO; //ありえない
            break;
    }
    
    return result;
    
}

-(void)drawTheLine:(NSInteger)startBoxPosition endBoxPosition:(NSInteger)endBoxPosition mode:(TrendState)mode{
    
    NSInteger count;
    for(count=startBoxPosition; count<=endBoxPosition ; count++){
        [self drawOneCell:count mode:mode];
    }
}

-(void)drawOneCell:(NSInteger)boxPosition mode:(TrendState)mode{
    //boxPositionの位置を座標に変換し、modeで指定された印(OX)を描く。
}

-(void)drawDayStr:(NSInteger)boxPosition date:(NSString*)date{
    //boxPositionのすぐ近くに、dateの日付を描く。
}

@end
