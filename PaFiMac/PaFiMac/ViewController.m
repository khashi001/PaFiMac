//
//  ViewController.m
//  PaFiMac
//
//  Created by 橋本 久美子 on 2016/07/29.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import "ViewController.h"
#import "PaFiEngineView.h"
#import "PaFi.h"
#import "chartJSONData.h"

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    
    //PaFiをCreate
    self.myPaFi = [PaFi sharedPaFi];
    


    
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)drawGraph:(id)sender {
    
    //PaFiにパラメータ値を入力
    self.myPaFi.boxSize = [self.myBoxSize.stringValue doubleValue];
    self.myPaFi.reversalAmount = [self.myReversalAmount intValue];
    self.myPaFi.ruleOfDrawOX = @"Close";  //将来は３種類をサポート。いまは１つだけで実装
    
    //poloniex チャートデータを読み込む
    BOOL readResult = [self readChartData];
    NSLog(@"readChartData result = %hhd",readResult);
    //続きはcontinueToPaFiUpdate で行う。
}

-(void)continueToPaFiUpdate{
    
    if(self.myPaFi.chartDataArray == nil || [self.myPaFi.chartDataArray count] == 0){
        NSLog(@"PaFi chartDataArray is empty. Bye.");
    }
    else{
        //PaFiに変化検出を指示
        [self.myPaFi updateChangeDetection];
        
        //PaFiEngineViewに描画を指示
        for (NSView *subview in self.view.subviews){
            if([subview.identifier isEqualToString:@"paFiEngineView"]){
                PaFiEngineView * paFiEngineView = (PaFiEngineView *)subview;
                [paFiEngineView drawOXonPaFiEngineView];
                [paFiEngineView setNeedsDisplay:YES];
            }
            
        }
    }
    
}

-(BOOL)readChartData{
    
    BOOL resultVal = YES;
    
    // PoloniexのAPIを用いてJSONデータを読み出し　self.chartDataArray　に格納する
    NSString *poloniexAPIURL = @"https://poloniex.com/public?command=returnChartData&currencyPair=BTC_ETH&start=1470150000&end=1470276000&period=14400";
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:poloniexAPIURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                NSLog(@"dataTaskWithURL completed.");
                
                if(error == nil){
                    NSError *jsonParseError;
                    NSArray *parsedChartJSONData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonParseError];
                    if (self.myPaFi.chartDataArray.count){
                        //過去のチャート読み取り情報は破棄する
                        [self.myPaFi.chartDataArray removeAllObjects];
                    }
                    
                    for(NSDictionary *object in parsedChartJSONData){
                        chartJSONData *eachChartData = [[chartJSONData alloc]init];
                        eachChartData.date = [object objectForKey:@"date"];
                        eachChartData.high = [[object objectForKey:@"high"] doubleValue];
                        eachChartData.low = [[object objectForKey:@"low"] doubleValue];
                        eachChartData.open = [[object objectForKey:@"open"] doubleValue];
                        eachChartData.close = [[object objectForKey:@"close"] doubleValue];
                        [self.myPaFi.chartDataArray addObject:eachChartData];
                        
                        NSLog(@"%f,%f,%f,%f",eachChartData.high,eachChartData.low,eachChartData.open,eachChartData.close);
                        
                    }
                    
                    [self continueToPaFiUpdate];
                }
                else{
                    NSLog(@"dataTaskWithURL error. %@",error);
                }
                
            }] resume];
    
    if(self.myPaFi.chartDataArray == nil || [self.myPaFi.chartDataArray count]== 0){
        resultVal = NO;
    }
    else{
        resultVal = YES;
    }
    return resultVal;

}



@end
