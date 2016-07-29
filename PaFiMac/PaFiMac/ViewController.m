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
    //PaFiにパラメータ値を入力
    
    //PaFiに変化検出を指示
    
    //GraphViewに描画を指示
    NSInteger aaa;
    aaa = 1;
    
    for (NSView *subview in self.view.subviews){
        if([subview.identifier isEqualToString:@"graphView"]){
            NSLog(@"graphView Found!");
            GraphView *graphView = (GraphView *)subview;
            [graphView DrawOX];
        }
        
    }
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
