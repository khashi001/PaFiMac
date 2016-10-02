//
//  PaFiEngineView.h
//  PaFiMac
//
//  Created by Orange Forest on 2016/08/05.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "chartJSONData.h"
#import "PaFiCommon.h"
#import "PaFi.h"


@interface PaFiEngineView : NSView


//PaFi本体。ここから描画のための情報を取得する。
@property PaFi *myPaFi;

//OXの列。トレンド転換のたびに増えていく。
@property NSInteger drawColumn;

#pragma mark Message to the Next Detection
@property BoxChangeState nextBoxChangeState; //次回はこの変化状態を参考にしてね。
@property TrendState currentTrend; //現在のトレンド(start/UpTrend/DownTrend)。
@property NSInteger currentTrendBoxPosition; //現在のトレンドにおける最新の枠番号。
//currentBoxPositionとは必ずしも一致しない。たとえばトレンドは変わらないほどの
//小さい上下変動が起きた場合、その変動内容はこの変数には反映されない。
-(void) initializeTrendVariables;


#pragma mark PaFi OX Engine
-(void)drawOXonPaFiEngineView;

#pragma mark Drawing
-(void)drawTheLine:(NSInteger)startBoxPosition endBoxPosition:(NSInteger)endBoxPosition mode:(TrendState)mode;
-(void)drawOneCell:(NSInteger)boxPosition mode:(TrendState)mode;
-(void)drawDayStr:(NSInteger)boxPosition date:(NSString*)date;

#pragma mark Judge Trend Proceeding
-(BOOL)judgeTrendProceeding:(TrendState)currentTrend currentPosition:(NSInteger)currentPosition previousPosition:(NSInteger)previousPosition;

#pragma mark tempolary for debug
@property NSInteger xAxisData;















@end
