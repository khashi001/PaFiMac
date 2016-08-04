//
//  ViewController.m
//  PaFiMac
//
//  Created by 橋本 久美子 on 2016/07/29.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    
    //PaFiをCreate
    self.myPaFi = [PaFi alloc];init;
    
    //PaFiにパラメータ値を入力
    
    //PaFiに変化検出を指示

    //GraphViewに描画を指示
    for (NSView *subview in self.view.subviews){
        if([subview.identifier isEqualToString:@"graphView"]){
            GraphView * graphView = (GraphView *)subview;
            graphView.tempLineLength = 100;
            
        }
        
    }

    
}






- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)drawGraph:(id)sender {
    //GraphViewに描画を指示
    for (NSView *subview in self.view.subviews){
        if([subview.identifier isEqualToString:@"graphView"]){
            NSLog(@"graphView Found!");
            GraphView *graphView = (GraphView *)subview;
            graphView.tempLineLength = 500;
            [subview setNeedsDisplay:NO];
            
        }
        
    }
}
@end
