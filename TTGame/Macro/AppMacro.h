//
//  AppMacro.h
//  TTGame
//
//  Created by MrWang on 14/12/5.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//
#import <UIKit/UIKit.h>
#ifndef TTGame_AppMacro_h
#define TTGame_AppMacro_h

#define MAINSCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define MAINSCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width

#define YELLOWCOLOR         [UIColor colorWithRed:(254.0 / 255.0) green:(234.0 / 255.0) blue:(192.0 / 255.0) alpha:1]
#define REDCOLOR            [UIColor colorWithRed:(236.0 / 255.0) green:(23.0 / 255.0) blue:(98.0 / 255.0) alpha:1]
#define RANDOMCOLOR            [UIColor colorWithRed:(arc4random() % 255 / 255.0) green:(arc4random() % 255 / 255.0) blue:(arc4random() % 255 / 255.0) alpha:1]

#define RGBCOLOR(r, g, b)         [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1]

#endif
