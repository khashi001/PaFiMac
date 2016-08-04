//
//  PaFi.m
//  PaFiMac
//
//  Created by 橋本 久美子 on 2016/07/29.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import "PaFi.h"

@implementation PaFi


-(BOOL)updateChangeDetection{
    
    [self readChartData];
    
    [self writeChangedData];
    
    NSLog(@"updateChangeDetection called.");
    
    return YES;
}


-(void)readChartData{
    // チャートデータ.JSONからデータを読み出す
}

-(void)writeChangedData{
    //変化データをJSONとして書き出す
    
}

@end
