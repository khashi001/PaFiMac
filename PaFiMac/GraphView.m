//
//  GraphView.m
//  PaFiMac
//
//  Created by 橋本 久美子 on 2016/07/29.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import "GraphView.h"

@implementation GraphView


- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}
- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    [NSBezierPath strokeLineFromPoint:NSMakePoint(0,0)
                              toPoint:NSMakePoint(100,200)]; //ここを追加
//    [NSBezierPath strokeLineFromPoint:NSMakePoint(0,400)
//                              toPoint:NSMakePoint(100,200)]; //ここを追加
}


-(void)DrawOX{
    // Drawing code here.
    [NSBezierPath strokeLineFromPoint:NSMakePoint(0,400)
                              toPoint:NSMakePoint(100,200)]; //ここを追加

    
}



@end
