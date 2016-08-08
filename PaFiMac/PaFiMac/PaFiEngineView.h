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


@property PaFi *myPaFi; //シングルトン対応未実施

@property NSInteger drawColumn; //OXの列。トレンド転換のたびに増えていく。

-(void)drawOXonPaFiEngineView:(NSArray *)chartDataArray;

-(void)drawTheLine:(NSInteger)startBoxPosition endBoxPosition:(NSInteger)endBoxPosition mode:(TrendState)mode;

-(void)drawOneCell:(NSInteger)boxPosition mode:(TrendState)mode;

-(void)drawDayStr:(NSInteger)boxPosition date:(NSString*)date;

-(BOOL)judgeTrendProceeding:(TrendState)currentTrend currentPosition:(NSInteger)currentPosition previousPosition:(NSInteger)previousPosition;
















@end
