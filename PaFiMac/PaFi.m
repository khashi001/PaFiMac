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

-(void)setInitVariables{ //自身のまっさらな状態をつくるだけ
    self.chartDataArray = [[NSMutableArray alloc]init];
    
}


-(BOOL)updateChangeDetection{
    
    [self readChartData];
    [self setParameters]; //readしたChartDataをもとに各種パラメータ値を設定する。
    [self makeScale];
    
    [self.chartDataArray enumerateObjectsUsingBlock:^(chartJSONData *data, NSUInteger idx, BOOL *stop){
        
        //前日からの価格枠変化状況を検出し、チャートデータに追記する。
        [self detectChange:idx];
        
    }];
    
    
    return YES;
}


-(void)readChartData{
    // PoloniexのAPIを用いてJSONデータを読み出し　self.chartDataArray　に格納する
    NSString *poloniexAPIURL = @"https://poloniex.com/public?command=returnChartData&currencyPair=BTC_ETH&start=1470150000&end=1470276000&period=14400";
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:poloniexAPIURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                NSLog(@"dataTaskWithURL completed.");
                
                NSError *jsonParseError;
                NSArray *parsedChartJSONData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonParseError];
                if (self.chartDataArray.count){
                    //過去のチャート読み取り情報は破棄する
                    [self.chartDataArray removeAllObjects];
                }
                
                for(NSDictionary *object in parsedChartJSONData){
                    chartJSONData *eachChartData = [[chartJSONData alloc]init];
                    eachChartData.date = [object objectForKey:@"date"];
                    eachChartData.high = [[object objectForKey:@"high"] doubleValue];
                    eachChartData.low = [[object objectForKey:@"low"] doubleValue];
                    eachChartData.open = [[object objectForKey:@"open"] doubleValue];
                    eachChartData.close = [[object objectForKey:@"close"] doubleValue];
                    [self.chartDataArray addObject:eachChartData];
                    
                }
                
                
            }] resume];
    
}

-(void)setParameters{
    
    self.boxSize = 0.02;
    self.reversalAmount = 3;
    
    self.ruleOfDrawOX = @"Close";
    
    self.maxPrice = 0;
    self.minPrice = [self.chartDataArray objectAtIndex:0 ].low;
    [self.myPaFi.chartDataArray enumerateObjectsUsingBlock:^(chartJSONData *data, NSUInteger idx, BOOL *stop){
        if( data.high > maxPrice){
            _maxPrice = data.high;
        }
        if( data.low > minPrice){
            _minPrice = data.high;
        }
    }];
    
    self.startDay = [self.myPaFi.chartDataArray objectAtIndex:0].date;
    self.latestDay = [self.myPaFi.chartDataArray lastObject].date;
    
    NSInteger shou;
    shou = (minPrice / boxSize);
    self.minBoxPrice = (double)show * boxSize; //価格の最小値を枠サイズで割り算した商に、枠サイズを掛けると、価格が配置される枠の下限値（価格帯の名前？みたいなもの）が得られる。
    self.minBoxPrice = minBoxPrice - (boxMergin * boxSize) //マージンをとっておく。データの最小値よりもいくらか下の価格帯を最小値としておく。
    
    shou = (maxPrice / boxSize);
    self.maxBoxPrice = show * boxSize
    self.maxBoxPrice = maxBoxPrice + (BoxMergin * boxSize)
    
    
    
}

-(void)makeScale{
    
    [self.myPaFi.chartDataArray enumerateObjectsUsingBlock:^(chartJSONData *data, NSUInteger idx, BOOL *stop){
        currentBoxPosition = [self getScalePosition:data.close:minBoxPrice)];
        currentBoxPositionLow = [self getScalePosition:data.low:minBoxPrice)];
        currentBoxPositionHigh = [self getScalePosition:data.high:minBoxPrice)];
        NSLog(@"debug.");
    }];
    
    maxPositionNumber = [self getScalePosition:maxBoxPrice:minBoxPrice);
                         minPositionNumber = [self getScalePosition:minBoxPrice:minBoxPrice);
                                              }
                                              
                                              
                                              
                                              -(void)detectChange{
                                                  //変化検出を行い、結果を self.chartDataArray に格納する
                                                  
                                                  
                                              }
                                              
                                              -(void)detectChange:(NSUInteger) indexChartElement){
                                                  
                                                  chartJSONData *currentChartData = [self.chartDataArray objectAtIndex:indexChartElement]);
                                                  chartJSONData *previousChartData;
                                                  
                                                  if( indexChartElement == 0) {  //先頭エレメント
                                                      currentChartData.boxChangeState = @"ST";
                                                      currentChartData.nextBoxChangeState = @"S";
                                                      currentChartData.currentTrend = @"start";
                                                  }
                                                  else{
                                                      previousChartData = [self.chartDataArray objectAtIndex:(indexChartElement - 1)];
                                                      if( currentChartData.boxPosition < previousChartData.boxPosition){
                                                          currentChartData.boxChangeState = "D";
                                                          currentChartData.nextBoxChangeState = currentChartData.boxChangeState;
                                                      }
                                                      else if( currentChartData.boxPosition > previousChartData.boxPosition){
                                                          currentChartData.boxChangeState = "U";
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
