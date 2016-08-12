//
//  PaFi.h
//  PaFiMac
//
//  Created by 橋本 久美子 on 2016/07/29.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaFiCommon.h"


@interface PaFi : NSObject

#pragma mark User Defined Parameter
@property double boxSize; //枠のサイズ
@property NSInteger reversalAmount; //転換枠数
@property NSString *ruleOfDrawOX;//描画ルール


#pragma mark Internal Parameter
@property double maxBoxPrice, minBoxPrice; //枠の値の最小値と最大値
@property NSInteger maxPositionNumber, minPositionNumber; //枠番号の最小値と最大値
@property double maxPrice, minPrice; //価格の最小値と最大値

@property NSString *startDay; //初日
@property NSString *latestDay; //最終日

@property NSInteger boxMergin; //描画の見た目を良くするために枠を少し多くとる

#pragma mark Shared Instance
+(id)sharedPaFi;

#pragma mark PaFi Engine
-(BOOL)updateChangeDetection;

#pragma mark Chart JSON Data
@property NSMutableArray *chartDataArray;


@end
