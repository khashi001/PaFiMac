//
//  PaFi.m
//  PaFiMac
//
//  Created by 橋本 久美子 on 2016/07/29.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import "PaFi.h"
#import "chartJSONData.h"

@implementation PaFi
{
    //---------------------------------------------------------------
    //
    // v0.01: PaFi VBA版 0.05版のロジックを移植し新規作成
    //         割愛したもの： drawOXHigh, drawOXLow, エントリー判断, パラメータ入力用UI
    //--------------------------------------------------------------
    
}

static id theSharedPaFi;

+(id)sharedPaFi{
    
    @synchronized(self) {
        if(theSharedPaFi == nil){
            theSharedPaFi = [[self alloc]initWithChartDataArray];
        }
    }
    return theSharedPaFi;
}

-(id)initWithChartDataArray{
    self.chartDataArray = [[NSMutableArray alloc]init];
    
    return (id)self; //selfを返しているのは適当（使わない想定）
}



-(BOOL)updateChangeDetection{
    
    [self setParameters]; //readしたChartDataをもとに各種パラメータ値を設定する。
    [self makeScale];
    
    [self.chartDataArray enumerateObjectsUsingBlock:^(chartJSONData *data, NSUInteger idx, BOOL *stop){
        
        //前日からの価格枠変化状況を検出し、チャートデータに追記する。
        [self detectChange:idx];
        
    }];
    
    return YES;
}



-(void)setParameters{
    
    self.boxMergin = 4;
    self.maxPrice = 0;
    
    chartJSONData *firstJsonData = (chartJSONData *)[self.chartDataArray objectAtIndex:0];
    chartJSONData *lastJsonData = (chartJSONData *)[self.chartDataArray lastObject];
    
    
    self.minPrice = firstJsonData.low;
    [self.chartDataArray enumerateObjectsUsingBlock:^(chartJSONData *data, NSUInteger idx, BOOL *stop){
        if( data.high > self.maxPrice){
            self.maxPrice = data.high;
        }
        if( data.low > self.minPrice){
            self.minPrice = data.high;
        }
    }];
    
    self.startDay = firstJsonData.date;
    self.latestDay = lastJsonData.date;
    
    NSInteger shou; //商
    shou = (self.minPrice / self.boxSize);
    self.minBoxPrice = (double)shou * self.boxSize; //価格の最小値を枠サイズで割り算した商に、枠サイズを掛けると、価格が配置される枠の下限値（価格帯の名前？みたいなもの）が得られる。
    self.minBoxPrice = self.minBoxPrice - (self.boxMergin * self.boxSize); //マージンをとっておく。データの最小値よりもいくらか下の価格帯を最小値としておく。
    
    shou = (self.maxPrice / self.boxSize);
    self.maxBoxPrice = (double)shou * self.boxSize;
    self.maxBoxPrice = self.maxBoxPrice + (self.boxMergin * self.boxSize);
    
    
}

-(NSInteger) getScalePosition:(double)myPrice minimumPrice:(double)minPrice{
    
    NSInteger scalePosision;
    
    scalePosision = ((myPrice - minPrice) / self.boxSize); //価格から最小価格を引いた値を、枠の単位数量で割った商が、何番目の枠かを示す。
    if( scalePosision < 0){
        NSLog(@"getScalePosition Error: position is less than 0");
        scalePosision = 0;
    }
    
    return scalePosision;
    
}

-(void)makeScale{
    
    [self.chartDataArray enumerateObjectsUsingBlock:^(chartJSONData *data, NSUInteger idx, BOOL *stop){
        data.boxPosition = [self getScalePosition:data.close minimumPrice:self.minBoxPrice];
        data.boxPositionLow = [self getScalePosition:data.low minimumPrice:self.minBoxPrice];
        data.boxPositionHigh = [self getScalePosition:data.high minimumPrice:self.minBoxPrice];
//        NSLog(@"debug.");
    }];
    
    self.maxPositionNumber = [self getScalePosition:self.maxBoxPrice minimumPrice:self.minBoxPrice];
    self.minPositionNumber = [self getScalePosition:self.minBoxPrice minimumPrice:self.minBoxPrice];
}
                              




-(void)detectChange:(NSUInteger) indexChartElement{
    //変化検出を行い、結果を self.chartDataArray に格納する
    
    chartJSONData *currentChartData = [self.chartDataArray objectAtIndex:indexChartElement];
    chartJSONData *previousChartData;
    
    if( indexChartElement == 0) {  //先頭エレメント
        currentChartData.boxChangeState = BoxChangeST;
        currentChartData.nextBoxChangeState = BoxChangeS;
        currentChartData.currentTrend = TrendStart;
    }
    else{
        previousChartData = [self.chartDataArray objectAtIndex:(indexChartElement - 1)];
        if( currentChartData.boxPosition < previousChartData.boxPosition){
            currentChartData.boxChangeState = BoxChangeDOWN;
            currentChartData.nextBoxChangeState = currentChartData.boxChangeState;
        }
        else if( currentChartData.boxPosition > previousChartData.boxPosition){
            currentChartData.boxChangeState = BoxChangeUP;
            currentChartData.nextBoxChangeState = currentChartData.boxChangeState;
        }
        else{
            //Box Position(枠の値）に変化が無い場合は、現状維持する
            currentChartData.boxChangeState = previousChartData.nextBoxChangeState;
            currentChartData.nextBoxChangeState = currentChartData.boxChangeState;
        }
    }
    
}


@end
