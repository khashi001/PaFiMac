//
//  chartJSONData.h
//  PaFiMac
//
//  Created by 橋本 久美子 on 2016/08/04.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaFiCommon.h"

@interface chartJSONData : NSObject

#pragma mark Chart JSON Data
@property  NSString *date;
@property double high;
@property double low;
@property double open;
@property double close;


#pragma mark Change Information
@property NSInteger boxPosition; //終値の枠番号
@property NSInteger boxPositionHigh; //高値の枠番号
@property NSInteger boxPositionLow;  //安値の枠番号

@property BoxChangeState boxChangeState; //前回からの変化状態



@end
