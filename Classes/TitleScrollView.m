//
//  TitleScrollView.m
//  BookShow
//
//  Created by zhangxiaoye on 2019/4/30.
//  Copyright © 2019年 zhangxiaoye. All rights reserved.
//

#import "TitleScrollView.h"
#import <Masonry/Masonry.h>

#define RGBCOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define ZXY_SAFE_BLOCK(BlockName, ...) ({ !BlockName ? nil : BlockName(__VA_ARGS__); })

@interface TitleScrollView ()<UIScrollViewDelegate>

@property (nonatomic ,assign) CGFloat                    Width;
@property (nonatomic ,assign) CGFloat                    Height;
@property (nonatomic, copy) NSArray                     *titleArr;
@property (nonatomic,strong) UIButton                   *button;
@property (nonatomic,assign) CGFloat                         x ;
@property (nonatomic,strong) UILabel                    *ColorLine;

@property (assign, nonatomic) BOOL isShow;

@property (assign, nonatomic) NSInteger selectIndex;

@property (strong, nonatomic) UIButton *selectIndexBtn;

@property (strong, nonatomic) NSMutableArray *SelectTitleArr;

@property (strong, nonatomic) UIView *TitleBgView;

@property (assign, nonatomic) NSInteger ViewNum;//一个屏幕一次显示多少个

@end

@implementation TitleScrollView

- (instancetype)initWithFrame:(CGRect)frame titleScrollViewButtons:(nonnull NSArray *)buttonsArr{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _Width = frame.size.width;

        _Height = frame.origin.y + frame.size.height;
        
        self.SelectTitleArr = [NSMutableArray array];
        
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        
        self.titleArr = buttonsArr;
        
    }
    
    return self;
}

- (void)addTitleScrollViewButtons:(NSArray *)arr ViewNum:(NSInteger)num{
    
    self.ViewNum = num;
    
    self.contentSize = CGSizeMake(_Width/self.ViewNum * [arr count], self.frame.size.height);
    
    for (int i = 0; i < [arr count]; i++) {
        
        _button = [[UIButton alloc]initWithFrame:CGRectMake(_Width/self.ViewNum *i, 0, _Width/self.ViewNum, 38)];
        
        [_button setTitle:arr[i] forState:UIControlStateNormal];
        
        _button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        _button.tag = i;
        
        [_button setTitleColor:self.SelectedColor forState:UIControlStateSelected];
        [_button setTitleColor:self.NormalColor forState:UIControlStateNormal];
        
        [_button addTarget:self action:@selector(turn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_button];

    }
    
    [self addLine];
    
    [self addColorLine];
    
    [self addTitleBgView];

}

+ (TitleScrollView *)addTitleScrollViewButtons:(NSArray *)arr ViewNum:(NSInteger)num ViewFrame:(CGRect)frame otherSettings:(void (^)(TitleScrollView * _Nonnull))otherSetting{
    
    TitleScrollView *titleScroll = [[TitleScrollView alloc] initWithFrame:frame titleScrollViewButtons:arr];
    
    [titleScroll addTitleScrollViewButtons:arr ViewNum:num];

    ZXY_SAFE_BLOCK(otherSetting,titleScroll);

    return titleScroll;
}

- (void)addLine{
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 1, _Width/self.ViewNum * ([self.titleArr count] < self.ViewNum?self.ViewNum:[self.titleArr count]), 1)];
    
    lineLabel.backgroundColor = RGBCOLOR(220, 220, 217, 1);
    
//    [self addSubview:lineLabel];
}

- (void)addColorLine{
    
    self.ColorLine = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 2, 0, 4)];
    
    self.ColorLine.backgroundColor = self.SelectedColor;
    
    [self addSubview:self.ColorLine];
}

- (void)addTitleBgView{
 
    self.TitleBgView = [[UIView alloc] init];
    
    self.TitleBgView.backgroundColor = self.TitleBgColor;
    self.TitleBgView.layer.cornerRadius = 2;
    self.TitleBgView.hidden = YES;

    [self addSubview:self.TitleBgView];
    
    [self sendSubviewToBack:self.TitleBgView];
}

- (void)changeNormalColor{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subView;
            [btn setTitleColor:self.NormalColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        }
    }
}

- (void)setSelectIndexPath:(id)selectIndexPath{
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subView;
            if (btn.tag == [selectIndexPath integerValue]) {
                [self turn:btn];
            }
        }
    }
}

- (void)turn:(UIButton*)sender{
    
    [self scrollColor:sender];
    
    [self adjustButtonPosition:sender];
    
    [self changeNormalColor];
    
    if (self.menuItems.count > 0) {
        
        if (self.isShow) {
            
            if ([self.SelectTitleArr.lastObject isEqual:sender]) {
                                
            }else{
                
                [self.SelectTitleArr removeAllObjects];
                
                [self.SelectTitleArr addObject:sender];
                
                [sender setTitleColor:self.SelectedColor forState:UIControlStateNormal];
                
                if (self.SelectedFontSize) {
                    [sender.titleLabel setFont:self.SelectedFontSize];
                }
                
                self.selectIndex = sender.tag;
                
                self.isShow = YES;
            }
            
        }else{
            
            [sender setTitleColor:self.SelectedColor forState:UIControlStateNormal];
           
            if (self.SelectedFontSize) {
                [sender.titleLabel setFont:self.SelectedFontSize];
            }
            
            [self.SelectTitleArr addObject:sender];
            
            self.selectIndex = sender.tag;
            
            self.isShow = YES;
        }
        
    }else{
        
        [sender setTitleColor:self.SelectedColor forState:UIControlStateNormal];
        if (self.SelectedFontSize) {
            [sender.titleLabel setFont:self.SelectedFontSize];
        }
    }
    
    if (self.selectDelegate && [self.selectDelegate respondsToSelector:@selector(titleScrollView:didSelectAtIndexPath:)]) {

        [self.selectDelegate titleScrollView:sender didSelectAtIndexPath:sender.tag];
    }
    
}

- (void)setSelectBtnColor:(NSInteger )index{
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subView;
            if (btn.tag == index) {
                btn.selected = YES;
            }else{
                btn.selected = NO;
                
            }
        }
    }
}

- (void)SelectBtnColor:(NSString *)message{
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subView;
            if ([btn.titleLabel.text isEqualToString:message]) {
                
                [self setSelectBtnColor:btn.tag];
                
                [self adjustButtonPosition:btn];
                
            }else{
                
            }
        }
    }
}

- (void)scrollColor:(UIButton *)sender{
    
    CGFloat previous = ( self->_Width/self.ViewNum - [self titleSize:self->_titleArr[sender.tag]].width ) / 2;
    
    CGFloat y = 0;
    
    y = (self->_Width/self.ViewNum) * sender.tag + previous;
    
    self.ColorLine.frame = CGRectMake(y , self.frame.size.height - 2, [self titleSize:self->_titleArr[sender.tag]].width, 2);
    
    self.TitleBgView.frame = CGRectMake(y - 4,
                                        (self.frame.size.height - [self titleSize:self->_titleArr[sender.tag]].height - 8) / 2, [self titleSize:self->_titleArr[sender.tag]].width + 8, [self titleSize:self->_titleArr[sender.tag]].height + 8);
}

- (void)adjustButtonPosition:(UIButton *)sender{
    
    if ([self.titleArr count] > self.ViewNum) {
        
        CGFloat offsetX = sender.center.x - _Width / 2;
        
        if (offsetX < 0) {
            offsetX = 0;
        }
        
        if (offsetX > (self.contentSize.width - self.bounds.size.width)) {
            offsetX = self.contentSize.width - self.bounds.size.width;
        }
        
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        
    }else{
        
    }
    
}

- (CGSize)titleSize:(NSString *)title{
    
    NSDictionary *attr = @{
                           NSFontAttributeName: [UIFont systemFontOfSize:16],  //设置字体
                           };
    
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    
    return titleSize;
}

- (void)setIsLine:(BOOL)isLine{
    
    if (isLine) {
        for (int i = 1; i < [self.titleArr count]; i++) {
            
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(_Width/self.ViewNum * i, self.frame.size.height /3, 1, self.frame.size.height /3)];
            
            line.backgroundColor = RGBCOLOR(204, 204,204, 1);
            
            [self addSubview:line];
            
        }
    }
    
}

- (void)setTitleBgColor:(UIColor *)TitleBgColor{
    
    _TitleBgColor = TitleBgColor;

    self.TitleBgView.backgroundColor = TitleBgColor;
    
}

- (void)setSelectedColor:(UIColor *)SelectedColor{
    
    _SelectedColor = SelectedColor;
    
    self.ColorLine.backgroundColor = SelectedColor;
    
}

- (void)setIsHideColorLine:(BOOL)isHideColorLine{

    if (isHideColorLine) {

        self.ColorLine.hidden = YES;

    }else{

        self.ColorLine.hidden = NO;
    }
}

- (void)setIsTitleBg:(BOOL)isTitleBg{
    
    if (isTitleBg) {
        
        self.TitleBgView.hidden = NO;
        
    }else{
        self.TitleBgView.hidden = YES;

    }
}

@end
