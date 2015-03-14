//
//  EndViewController.m
//  TTGame
//
//  Created by KayWong on 14/12/15.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import "EndViewController.h"
#import "AppMacro.h"
@interface EndViewController ()
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (nonatomic, copy) NSString *commentString;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;

@end

@implementation EndViewController
- (instancetype)initWithLevel:(NSInteger )level andScore:(NSInteger)score{
    self = [[super storyboard] instantiateViewControllerWithIdentifier:@"EndViewController"];
    if (self) {
        _level = level;
        _score = score;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.restartButton.layer.borderColor = [REDCOLOR CGColor];
    self.levelLabel.text = [NSString stringWithFormat:@"你闯过了%ld关",(long)self.level];
    self.nameLabel.text = [NSString stringWithFormat:@"获得称号：%@",[self fetchNickNameByScore:self.score]];
    self.commentLabel.text = self.commentString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)restartButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate dismissViewControllerAnimated:NO completion:nil];
    }];
}
- (NSString *)fetchNickNameByScore:(NSInteger)score{
    NSString *nickName;
    if (score>=0 && score<=5) {
        nickName = @"战五渣";
        self.commentString = @"P.S:你是猴子请过来逗比的吗？";
    }else if (score>5 && score<=10){
        nickName = @"十年磨一贱";
        self.commentString = @"P.S:对于你的低智商我竟然无言以对";
    }else if (score>10 && score<=15){
        nickName = @"手残党";
        self.commentString = @"P.S:赶紧去医院治治吧，会好起来的";
    }else if (score>15 && score<=20){
        nickName = @"渐冻人";
        self.commentString = @"P.S:参加冰桶挑战了吧？";
    }else if (score>20 && score<=25){
        nickName = @"呵呵";
        self.commentString = @"P.S:哦";
    }else if (score>25 && score<=30){
        nickName = @"玩得正爽";
        self.commentString = @"P.S:要不，给大爷一个好评？";
    }else if (score>30 && score<=35){
        nickName = @"手长";
        self.commentString = @"P.S:手长，别开枪，是我";
    }else if (score>35 && score<=40){
        nickName = @"补刀高手";
        self.commentString = @"P.S:咔擦，你的手是不是抽筋了？";
    }else if (score>40 && score<=45){
        nickName = @"手哥";
        self.commentString = @"P.S:说吧，你到底留了几手";
    }else if (score>45 && score<=50){
        nickName = @"我是处女座";
        self.commentString = @"P.S:瞧你把屏幕都给戳烂了";
    }else if (score>50){
        nickName = @"加藤鹰之手";
        self.commentString = @"P.S:你的女朋友还好吗？";
    }
    return nickName;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
