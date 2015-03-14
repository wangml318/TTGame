//
//  TTWelcomeViewController.m
//  TTGame
//
//  Created by KayWong on 14/12/14.
//  Copyright (c) 2014年 MaMaWang. All rights reserved.
//

#import "TTWelcomeViewController.h"
#import "TTTimerHelper.h"
#import "AppMacro.h"
#import "UIImage+ImageEffects.h"
#import "UIImageView+LBBlurredImage.h"
#import <UIImage+BlurredFrame.h>
@interface TTWelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *colorButton;
@property (weak, nonatomic) IBOutlet UIButton *numberButton;

@end

@implementation TTWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.backgroundImageView.image = [UIImage imageNamed:@"3.jpg"];
//    [self.backgroundImageView setImageToBlur:self.backgroundImageView.image completionBlock:nil];
    
    self.view.backgroundColor = YELLOWCOLOR;
    self.colorButton.layer.borderColor = [REDCOLOR CGColor];
    self.numberButton.layer.borderColor = [REDCOLOR CGColor];


//    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    lable.text=@"asdasdsadasdasd";
//    [self.view addSubview:lable];
//    [[TTTimerHelper shareInstance] countDownWithTimeInterval:30.0 andViewController:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
