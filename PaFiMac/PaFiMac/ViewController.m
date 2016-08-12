//
//  ViewController.m
//  PaFiMac
//
//  Created by 橋本 久美子 on 2016/07/29.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import "ViewController.h"
#import "PaFiEngineView.h"
#import "PaFi.h"
#import "chartJSONData.h"

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    
    //PaFiをCreate
    self.myPaFi = [PaFi sharedPaFi];
    


    
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)drawGraph:(id)sender {
    
    //PaFiにパラメータ値を入力
    self.myPaFi.boxSize = [self.myBoxSize.stringValue doubleValue];
    self.myPaFi.reversalAmount = [self.myReversalAmount intValue];
    self.myPaFi.ruleOfDrawOX = @"Close";  //将来は３種類をサポート。いまは１つだけで実装
    
    //PaFiに変化検出を指示
    [self.myPaFi updateChangeDetection];
    
    //PaFiEngineViewに描画を指示
    for (NSView *subview in self.view.subviews){
        if([subview.identifier isEqualToString:@"paFiEngineView"]){
            PaFiEngineView * paFiEngineView = (PaFiEngineView *)subview;
            [paFiEngineView drawOXonPaFiEngineView];
            [paFiEngineView setNeedsDisplay:YES];
        }
        
    }

}

@end
