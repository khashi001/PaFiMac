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
    self.myPaFi = [[PaFi alloc] init];
    [self.myPaFi setInitVariables];
    
    //PaFiにパラメータ値を入力
    
    //PaFiに変化検出を指示
    [self.myPaFi updateChangeDetection];

    //PaFiEngineViewに描画を指示
    for (NSView *subview in self.view.subviews){
        if([subview.identifier isEqualToString:@"paFiEngineView"]){
            PaFiEngineView * paFiEngineView = (PaFiEngineView *)subview;
            paFiEngineView.tempLineLength = 100;
            [paFiEngineView drawOX];
            [paFiEngineView setNeedsDisplay:YES];
        }
        
    }

    
}






- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)drawGraph:(id)sender {
    
    //PaFiに変化検出を指示
    [self.myPaFi updateChangeDetection];
    
    //for Debug
    [self.myPaFi.chartDataArray enumerateObjectsUsingBlock:^(chartJSONData *data, NSUInteger idx, BOOL *stop){
        NSLog(@"\n  index= %lu \n date = %@ \n high = %lf \n low = %lf \n open = %lf \n close = %lf \n",(unsigned long)idx, data.date,data.high,data.low,data.open,data.close);
        
    }];
    
    
//    for(chartJSONData *data in self.myPaFi.chartDataArray){
//        NSLog(@"\n  date = %@ \n high = %lf \n low = %lf \n open = %lf \n close = %lf \n",data.date,data.high,data.low,data.open,data.close);
//    }
    
        //PaFiEngineViewに描画を指示
        for (NSView *subview in self.view.subviews){
            if([subview.identifier isEqualToString:@"paFiEngineView"]){
                NSLog(@"paFiEngineView Found!");
                PaFiEngineView *paFiEngineView = (PaFiEngineView *)subview;
                paFiEngineView.tempLineLength = 500;
                [paFiEngineView drawOX];
                [subview setNeedsDisplay:YES];
        }
    }
}
    
@end
