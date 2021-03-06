//
//  ViewController.h
//  PaFiMac
//
//  Created by 橋本 久美子 on 2016/07/29.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "chartJSONData.h"
#import "PaFi.h"
#import "PaFiEngineView.h"


@interface ViewController : NSViewController

#pragma mark User Defined Parameters
@property (weak) IBOutlet NSTextField *myBoxSize;
@property (weak) IBOutlet NSTextField *myReversalAmount;


- (IBAction)drawGraph:(id)sender;

@property PaFi* myPaFi;


#pragma mark tempolary for debug

@property (weak) IBOutlet NSTextField *xAsisValue;



@end
