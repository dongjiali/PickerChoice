//
//  HNAPickerMacro.h
//  HNA_PickerView
//
//  Created by Curry on 14-4-10.
//  Copyright (c) 2014年 HaiHangHui. All rights reserved.
//

#ifndef HNA_PickerView_HNAPickerMacro_h
#define HNA_PickerView_HNAPickerMacro_h

#define RGBCOLOR(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define RGBACOLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]


#define RED_COLOR        RGBCOLOR(218, 56, 43)          //深红     ---所有红
#define TEXT_COLOR       RGBCOLOR(46, 53, 75)           //所有黑色字  ---深蓝色
#define WHITE_COLOR      RGBCOLOR(249, 249, 249)        //选中的的日期颜色 ---所有白
#define LINE_COLOR [UIColor colorWithWhite:0.80 alpha:1.0]

#define HEADERVIEWHEIGHT 50
#define PICKERVIEWHEIGHT 220

#define ITEM_HEIGHT 44.0
#define ACTIVE_DISTANCE 44.0
#define ZOOM_FACTOR 0.4

#define BAR_SEL_ORIGIN_Y PICKERVIEWHEIGHT/2.0-ITEM_HEIGHT/2.0

#endif
