//
//  EndViewController.h
//  TTGame
//
//  Created by KayWong on 14/12/15.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EndViewController : UIViewController
@property (nonatomic , weak) id delegate;
@property (nonatomic)   NSInteger level;
@property (nonatomic)   NSInteger score;
- (instancetype)initWithLevel:(NSInteger )level andScore:(NSInteger)score;
@end
