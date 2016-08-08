//
//  PaFiCommon.h
//  PaFiMac
//
//  Created by Orange Forest on 2016/08/08.
//  Copyright © 2016年 Orange Forest. All rights reserved.
//

#ifndef PaFiCommon_h
#define PaFiCommon_h

typedef NS_ENUM(NSInteger, BoxChangeState) {
    BoxChangeST = 0, //"ST"
    BoxChangeS = 1,  //"S"
    BoxChangeUP = 2,  //"U"
    BoxChangeDOWN = 3,  //"D"
};

typedef NS_ENUM(NSInteger, TrendState) {
    TrendStart = 0,
    TrendUpTrend = 1,
    TrendDown = 2,
};



#endif /* PaFiCommon_h */
