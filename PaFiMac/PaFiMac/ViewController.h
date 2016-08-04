//
//  ViewController.h
//  PaFiMac
//
//  Created by 橋本 久美子 on 2016/07/29.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GraphView.h"
#import "PaFi.h"


@interface ViewController : NSViewController

@property (weak) IBOutlet NSTextField *myBoxSize;


@property (weak) IBOutlet NSTextField *myReversalAmount;


- (IBAction)drawGraph:(id)sender;

@property PaFi* myPaFi;



@end
