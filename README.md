
# ZXYTitleScrollView
## PDF文档阅读器,可定位到指定的页码
# 使用ZXYTitleScrollView

三步完成主流App框架搭建：

- 第一步：使用CocoaPods导入ZXYTitleScrollView
- 第二步：初始化TitleScrollView类,同时传入按钮数量和内容
- 第三步（可选）：设置控件模式
- 第四步: 调用点击代理方法

# 第一步：使用CocoaPods导入ZXYTitleScrollView

CocoaPods 导入

在文件 Podfile 中加入以下内容：

pod 'ZXYTitleScrollView'
然后在终端中运行以下命令：

pod install
或者这个命令：
```
禁止升级 CocoaPods 的 spec 仓库，否则会卡在 Analyzing dependencies，非常慢
pod install --verbose --no-repo-update
或者
pod update --verbose --no-repo-update
```
完成后，CocoaPods 会在您的工程根目录下生成一个 .xcworkspace 文件。您需要通过此文件打开您的工程，而不是之前的 .xcodeproj。

# 第二步：初始化TitleScrollView类,同时传入按钮数量和内容

```
TitleScrollView *titleScrollView = [[TitleScrollView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40) titleScrollViewButtons:menuItems];

[titleScrollView addTitleScrollViewButtons:menuItems ViewNum:5];

[self.view addSubview:self.titleScrollView];

[titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {

make.left.right.mas_equalTo(0);
make.height.mas_equalTo(40);
make.top.mas_equalTo(60);
}];

```

# 第三步（可选）：设置控件模式

```

titleScrollView.SelectedColor = RGBCOLOR(130, 78, 1, 1); // 选中时,字体颜色

titleScrollView.NormalColor = RGBCOLOR(255, 255, 255, 1); // 未选中时,字体颜色

titleScrollView.TitleBgColor = RGBCOLOR(204, 186, 169, .67); // 背景颜色

titleScrollView.backgroundColor = [UIColor redColor];

titleScrollView.SelectedFontSize = [UIFont systemFontOfSize:16]; // 选中时,字体大小

titleScrollView.tag = 1; 

titleScrollView.selectIndexPath = @(0);  // 选择第一个

titleScrollView.isLine = NO;  // 是否有竖线相隔 (默认NO)

titleScrollView.isHideColorLine = YES;  // 是否有横线相隔 (默认NO)

titleScrollView.isTitleBg = YES; //是否有背景颜色(默认NO)

titleScrollView.selectDelegate = self; //设置代理



``` 
# 第四步（可选）：调用点击代理方法


```


- (void)titleScrollView:(UIButton *)titleBtn didSelectAtIndexPath:(NSInteger)indexPath{

NSLog(@"按钮标题:%@,按钮Tag:%ld",titleBtn.titleLabel.text,(long)indexPath);
}

``` 
