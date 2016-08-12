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

#pragma mark PaFi OX Engine
-(void)drawOXonPaFiEngineView;

#pragma mark Drawing
-(void)drawTheLine:(NSInteger)startBoxPosition endBoxPosition:(NSInteger)endBoxPosition mode:(TrendState)mode;
-(void)drawOneCell:(NSInteger)boxPosition mode:(TrendState)mode;
-(void)drawDayStr:(NSInteger)boxPosition date:(NSString*)date;

#pragma mark Judge Trend Proceeding
-(BOOL)judgeTrendProceeding:(TrendState)currentTrend currentPosition:(NSInteger)currentPosition previousPosition:(NSInteger)previousPosition;
















@end
