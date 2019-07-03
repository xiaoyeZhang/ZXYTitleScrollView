//
//  ViewController.m
//  ZXYTitleScrollView
//
//  Created by zhangxiaoye on 2019/7/3.
//  Copyright © 2019 zhangxiaoye. All rights reserved.
//

#import "ViewController.h"
#import <TitleScrollView.h>
#import <Masonry/Masonry.h>

#define RGBCOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface ViewController ()

@property (strong, nonatomic) TitleScrollView *titleScrollView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addTitleScrollView];

}


- (void)addTitleScrollView{
    
    NSArray *menuItems = @[@"首页",@"规划设计",@"发展构想",@"发展基金",@"投资案例",@"联盟成员"];
    
    //    self.titleScrollView = [TitleScrollView addTitleScrollViewButtons:menuItems ViewNum:5 ViewFrame:CGRectMake(0, 100, self.view.frame.size.width, 40) otherSettings:^(TitleScrollView * titleScroll) {
    //
    //
    //        titleScroll.tag = 1;
    //
    //        titleScroll.selectIndexPath = @(0);
    //
    //        titleScroll.isLine = NO;
    //
    //        titleScroll.isHideColorLine = YES;
    //
    //        titleScroll.isTitleBg = YES;
    //
    //        titleScroll.backgroundColor = [UIColor redColor];
    //
    //        titleScroll.SelectedColor = RGBCOLOR(130, 78, 1, 1);
    //
    //        titleScroll.NormalColor = RGBCOLOR(255, 255, 255, 1);
    //
    //        titleScroll.TitleBgColor = RGBCOLOR(204, 186, 169, .67);
    //
    //    }];
    
    self.titleScrollView = [[TitleScrollView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40) titleScrollViewButtons:menuItems];
    
    [self.titleScrollView addTitleScrollViewButtons:menuItems ViewNum:5];
    
    self.titleScrollView.SelectedColor = RGBCOLOR(130, 78, 1, 1);
    
    self.titleScrollView.NormalColor = RGBCOLOR(255, 255, 255, 1);
    
    self.titleScrollView.TitleBgColor = RGBCOLOR(204, 186, 169, .67);
    
    self.titleScrollView.backgroundColor = [UIColor redColor];
    
    //    self.titleScrollView.SelectedFontSize = [UIFont systemFontOfSize:16];
    
    self.titleScrollView.tag = 1;
    
    self.titleScrollView.selectIndexPath = @(0);
    
    self.titleScrollView.isLine = NO;
    
    self.titleScrollView.isHideColorLine = YES;
    
    self.titleScrollView.isTitleBg = YES;
    
    self.titleScrollView.selectDelegate = self;
    
    [self.view addSubview:self.titleScrollView];
    
    [self.titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(60);
    }];
    
}

@end
