//
//  chartJSONData.h
//  PaFiMac
//
//  Created by 橋本 久美子 on 2016/08/04.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface chartJSONData : NSObject

//チャートから読み出すデータ
@property  NSString *date;
@property double high;
@property double low;
@property double open;
@property double close;

//変化検出情報
//@property NSInteger currentBoxPosition; //終値の枠番号
//@property NSInteger currentBoxPositionHigh; //高値の枠番号
//@property NSInteger currentBoxPositionLow;  //安値の枠番号
@property NSInteger boxPosition; //終値の枠番号
@property NSInteger boxPositionHigh; //高値の枠番号
@property NSInteger boxPositionLow;  //安値の枠番号

@property NSInteger boxChangeState; //前回からの変化状態


//次回への申し送り用
@property NSInteger nextBoxChangeState; //次回はこの変化状態を参考にしてね
@property NSString *currentTrend; //現在のトレンド(start/UpTrend/DownTrend)
@property NSString *currentTrendBoxPosition; //現在のトレンドにおける最新の枠番号。
    //currentBoxPositionとは必ずしも一致しない。たとえばトレンドは変わらないほどの
    //小さい上下変動が起きた場合、その変動内容はこの変数には反映されない。



@end
