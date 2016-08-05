//
//  PaFi.h
//  PaFiMac
//
//  Created by 橋本 久美子 on 2016/07/29.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaFi : NSObject

@property double boxSize;

@property NSInteger reversalAmount;


@property double maxBoxPrice, minBoxPrice; //枠の値の最小値と最大値
@property NSInteger maxPositionNumber, minPositionNumber; //枠番号の最小値と最大値
@property double maxPrice, minPrice; //価格の最小値と最大値

@property NSString *ruleOfDrawOX;//描画ルール

@property NSString *startDay;
@property NSString *latestDay;


-(void)setInitVariables;

    
-(BOOL)updateChangeDetection;


// チャートのJSONデータ
@property NSMutableArray *chartDataArray;



@end
