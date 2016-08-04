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

-(void)setInitVariables{
    self.chartDataArray = [[NSMutableArray alloc]init];

}


-(BOOL)updateChangeDetection{
    
    [self readChartData];
    
    [self writeChangedData];
    
    NSLog(@"updateChangeDetection called.");
    
    return YES;
}


-(void)readChartData{
    // PoloniexのAPIを用いてJSONデータを読み出す
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


-(void)writeChangedData{
    //変化データをJSONとして書き出す

}

@end
