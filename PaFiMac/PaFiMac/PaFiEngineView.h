//
//  PaFiEngineView.h
//  PaFiMac
//
//  Created by Orange Forest on 2016/08/05.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "chartJSONData.h"
#import "PaFi.h"


@interface PaFiEngineView : NSView

@property CGFloat tempLineLength;

@property PaFi *myPaFi; //シングルトン対応未実施

@property NSInteger drawColumn; //OXの列。トレンド転換のたびに増えていく。

-(void)drawOX;

@end
