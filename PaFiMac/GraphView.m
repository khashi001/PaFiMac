//
//  GraphView.m
//  PaFiMac
//
//  Created by 橋本 久美子 on 2016/08/04.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import "GraphView.h"

@implementation GraphView

//-(id)initWithFrame:(NSRect)frame{
//    
//    self = [super initWithFrame:<#frame#>];
//    if(self){
//        //Initialization code here.
//    }
//    return self;
//}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [NSBezierPath strokeLineFromPoint:NSMakePoint(0, 0) toPoint:NSMakePoint(100, 100)];
    
    NSLog(@"GraphView:drawRect. ここでは描画データセットを元に描画を行います。");
}

-(void)drawOX{
    //本当はここで描画もやりたいんだけど　わからないので drawRectにやらせることにする
    NSLog(@"GraphView:drawOX. ここでは描画データセットの作成をやります。");
}

@end
