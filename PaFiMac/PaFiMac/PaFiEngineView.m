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
    [self drawOXonPaFiEngineView];

    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [NSBezierPath strokeLineFromPoint:NSMakePoint(0, 0) toPoint:NSMakePoint(self.xAxisData, 1000)];
    
    [[NSColor blueColor] set];
    NSRectFill(NSMakeRect(200,200,200,200));
}




#pragma mark PaFi Engine

-(void)drawOXonPaFiEngineView{
    
    NSLog(@"%s", __PRETTY_FUNCTION__);

    self.myPaFi = nil;
    
    self.myPaFi = [PaFi sharedPaFi];
    NSArray *chartDataArray = [self.myPaFi getChartDataArray];
    
    
    [self initializeTrendVariables];
    [chartDataArray enumerateObjectsUsingBlock:^(chartJSONData *data, NSUInteger idx, BOOL *stop){
        
        [self drawOXClose:idx chartDataArray:chartDataArray];
        
    }];
    
}




-(void)drawOXClose:(NSUInteger) indexChartElement chartDataArray:(NSArray *)chartDataArray{
    NSLog(@"%s", __PRETTY_FUNCTION__);

    BOOL trendProceeding; //前回と今回で枠番号がトレンド方向に進行したか否か
    
    chartJSONData *currentChartData = [chartDataArray objectAtIndex:indexChartElement];
    
    
    switch(self.currentTrend){
        case TrendStart:
            switch(currentChartData.boxChangeState){
//                    switch(self.nextBoxChangeState){
                case BoxChangeST:
                case BoxChangeS:
                    self.currentTrendBoxPosition = currentChartData.boxPosition;
                    break;
                case BoxChangeUP:
                    [self drawTheLine:self.currentTrendBoxPosition endBoxPosition:currentChartData.boxPosition mode:TrendUpTrend];
                    [self drawDayStr:currentChartData.boxPosition date:currentChartData.date];
                    self.currentTrend = TrendUpTrend;
                    self.currentTrendBoxPosition = currentChartData.boxPosition;
                    break;
                case BoxChangeDOWN:
                    [self drawTheLine:self.currentTrendBoxPosition endBoxPosition:currentChartData.boxPosition mode:TrendUpTrend];
                    [self drawDayStr:currentChartData.boxPosition date:currentChartData.date];
                    self.currentTrend = TrendDown;
                    self.currentTrendBoxPosition = currentChartData.boxPosition;
                    break;
                default:
                    break;
            }
            break;
        case TrendUpTrend:
            switch (currentChartData.boxChangeState) {
                case BoxChangeUP:
                    trendProceeding = [self judgeTrendProceeding:self.currentTrend currentPosition:currentChartData.boxPosition previousPosition:self.currentTrendBoxPosition];
                    if (trendProceeding) { //値がトレンド方向に増えた
                        [self drawTheLine:self.currentTrendBoxPosition endBoxPosition:currentChartData.boxPosition mode:self.currentTrend];
                        [self drawDayStr:currentChartData.boxPosition date:currentChartData.date];
                        self.currentTrendBoxPosition = currentChartData.boxPosition;
                    }
                    break;
                case BoxChangeDOWN:
                    if (labs(currentChartData.boxPosition - self.currentTrendBoxPosition) >= self.myPaFi.reversalAmount){ //転換条件に適合した
                        [self moveToNextColumn];
                        self.currentTrendBoxPosition --; //転換後は１枠下から描く
                        [self drawTheLine:self.currentTrendBoxPosition endBoxPosition:currentChartData.boxPosition mode:TrendDown];
                        [self drawDayStr:currentChartData.boxPosition date:currentChartData.date];
                        self.currentTrendBoxPosition = currentChartData.boxPosition;
                        self.currentTrend = TrendDown;
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
                    trendProceeding = [self judgeTrendProceeding:self.currentTrend currentPosition:currentChartData.boxPosition previousPosition:self.currentTrendBoxPosition];
                    if (trendProceeding) { //値がトレンド方向に増えた
                        [self drawTheLine:self.currentTrendBoxPosition
                           endBoxPosition:currentChartData.boxPosition
                                     mode:self.currentTrend];
                        [self drawDayStr:currentChartData.boxPosition date:currentChartData.date];
                        self.currentTrendBoxPosition = currentChartData.boxPosition;
                    }
                    break;
                case BoxChangeUP:
                    if (labs(currentChartData.boxPosition - self.currentTrendBoxPosition) >= self.myPaFi.reversalAmount){ //転換条件に適合した
                        [self moveToNextColumn];
                        self.currentTrendBoxPosition ++; //転換後は１枠下から描く
                        [self drawTheLine:self.currentTrendBoxPosition
                           endBoxPosition:currentChartData.boxPosition
                                     mode:TrendUpTrend];
                        [self drawDayStr:currentChartData.boxPosition date:currentChartData.date];
                        self.currentTrendBoxPosition = currentChartData.boxPosition;
                        self.currentTrend = TrendUpTrend;
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
    NSLog(@"Next Column");
    
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
    
    NSString *modeString;
    switch (mode) {
        case TrendStart:
            modeString = @"Start";
            break;
        case TrendUpTrend:
            modeString = @"UpTrend";
            break;
        case TrendDown:
            modeString = @"DownTrend";
            break;
        default:
            break;
    }
    NSLog(@"drawTheLine | %ld | From = %ld, To = %ld, %@",self.drawColumn, startBoxPosition,endBoxPosition,modeString);
    
    
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

-(void) initializeTrendVariables{
    
    self.nextBoxChangeState = BoxChangeST;
    self.currentTrend = TrendStart;
    self.currentTrendBoxPosition = 0; //ありえない番号
    
}

@end
