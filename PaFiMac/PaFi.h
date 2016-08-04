//
//  PaFi.h
//  PaFiMac
//
//  Created by 橋本 久美子 on 2016/07/29.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaFi : NSObject

@property double pafiBoxSize;
@property NSInteger pafiReversalAmount;

-(void)setInitVariables;

    
-(BOOL)updateChangeDetection;


@property NSMutableArray *chartDataArray;


@end
