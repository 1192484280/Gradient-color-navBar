# Gradient-color-navBar
跟着广告滚动渐变色navbar

最近看到hongxin的仿大麦项目，受益匪浅，在此摘出导航栏随着顶部广告滚动渐变色的navbar细解一下。

![image](https://github.com/1192484280/Gradient-color-navBar/blob/master/show.gif)


1.首先将需要用到图片加载处理SDWebImage和广告循环类SDCycleScrollView两个文件导入项目。


2.为了简单化，将类扩展文件Extension加入项目，这个文件中含有btn，view，color的扩展方法


3.自定义tableview的headerView，写入广告滚动视图。并且创建他的代理方法(当广告滚动到下一张时实现)

```
- (void)cycleScrollViewDidScrollViewToIndexforUrl:(NSString *)url;
```

4.controller里面

4_1.创建tableview。

4_2.创背景变色视图，注意：这个变色视图一定要在tableView下面，所以这里用了[self.view insertSubview:bgImg atIndex:0];

```
[self.view addSubview:self.tableView];

UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, ScreenWidth + 10, ADHeight + 10)];
bgImg.centerX = ScreenWidth / 2;
bgImg.image = [UIImage imageNamed:self.imgArr[0]];
bgImg.contentMode = UIViewContentModeScaleAspectFill;
[bgImg sd_setImageWithURL:self.imgArr[0]];
[self.view insertSubview:bgImg atIndex:0];

UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
effectView.frame = bgImg.bounds;
[bgImg addSubview:effectView];
self.effectView = effectView;

UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVBAR_HEIGHT)];
maskView.backgroundColor = [[UIColor colorWithHexString:@"#e2f9444"] colorWithAlphaComponent:0];
[self.view insertSubview:maskView atIndex:1];
self.bgImg = bgImg;
```

4_3.实现headerView代理方法(实现导航栏随广告滚动变色效果)
```
- (void)cycleScrollViewDidScrollViewToIndexforUrl:(NSString *)url
{
[self.bgImg sd_cancelCurrentAnimationImagesLoad];
[self.bgImg sd_setImageWithURL:[NSURL URLWithString:url]];
//self.bgImg.image = [UIImage imageNamed:url];
}
```

6.实现scrollView代理方法（实现导航栏上隐下现效果）
```
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
CGFloat offsetY = scrollView.contentOffset.y;
CGFloat alpha = offsetY / 100;

[self.navBar setBackgroundImage:[UIImage imageWithColor:[BASECOLOR colorWithAlphaComponent:alpha] size:CGSizeMake(ScreenWidth, NAVBAR_HEIGHT)] forBarMetrics:UIBarMetricsDefault];

CGFloat H = ScreenWidth / 16 * 9 + 10 - offsetY;

if (offsetY > 0) {
H = ScreenWidth / 16 * 9 + 10;
}
self.bgImg.frame = CGRectMake(-5, -5, ScreenWidth + 10, H);
self.effectView.frame = self.bgImg.bounds;
}
```









