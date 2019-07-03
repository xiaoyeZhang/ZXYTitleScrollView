//
//  TitleScrollView.h
//  BookShow
//
//  Created by zhangxiaoye on 2019/4/30.
//  Copyright © 2019年 zhangxiaoye. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TitleScrollViewDelegate <NSObject>
@optional

- (void)titleScrollView:(UIButton *)titleBtn didSelectAtIndexPath:(NSInteger)indexPath;

@end

@interface TitleScrollView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame titleScrollViewButtons:(NSArray *)buttonsArr;

- (void)SelectBtnColor:(NSString *)message;

/**
 添加按钮

 @param arr 传入的按钮数组
 @param num 一个屏幕一次显示多少个
 */
- (void)addTitleScrollViewButtons:(NSArray *)arr ViewNum:(NSInteger)num;

/**
  添加按钮(利用Block设置其它属性)

 @param arr 传入的按钮数组
 @param num 一个屏幕一次显示多少个
 @param frame view的大小
 @param otherSetting 其他设置
 @return 返回实例对象
 */
+ (TitleScrollView *)addTitleScrollViewButtons:(NSArray *)arr
                              ViewNum:(NSInteger)num
                            ViewFrame:(CGRect)frame 
                       otherSettings:(void (^) (TitleScrollView *titleScroll))otherSetting;


@property (nonatomic, weak) id<TitleScrollViewDelegate> selectDelegate;

@property (nonatomic, copy) NSArray *menuItems;

/**
 默认选择哪一项
 */
@property (nonatomic, assign) id selectIndexPath;

/**
 title按钮之间是否有竖线相隔 (默认NO)
 */
@property (nonatomic, assign) BOOL isLine;

/**
 选中时字体颜色
 */
@property(nonatomic,strong) UIColor  *SelectedColor;
/**
 未选中时字体颜色
 */
@property(nonatomic,strong) UIColor  *NormalColor;

/**
 选中时字体大小
 */
@property(nonatomic,strong) UIFont *SelectedFontSize;

/**
 title按钮下方是否有横线相隔 (默认NO)
 */
@property (nonatomic, assign) BOOL isHideColorLine;

/**
 button按钮下方是否有背景颜色 (默认NO)
 */
@property (nonatomic, assign) BOOL isTitleBg;

/**
 button按钮下方是否有背景
 */
@property (nonatomic, strong) UIColor *TitleBgColor;

@end

NS_ASSUME_NONNULL_END
