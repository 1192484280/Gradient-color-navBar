//
//  ViewController.m
//  TheColorNavBar
//
//  Created by zhangming on 2017/10/27.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,HeaderViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) HeaderView *headerView;
@property (copy, nonatomic) NSArray *imgArr;
@property (weak, nonatomic) UINavigationBar *navBar;
@property (weak, nonatomic) UIImageView *bgImg;
@property (weak, nonatomic) UIVisualEffectView *effectView;

@end

@implementation ViewController

-(NSArray *)imgArr{
    
    if(!_imgArr){
        
        _imgArr = @[@"http://static.damai.cn/mapi/2017/07/10/8d357780-4397-47ae-8e35-c0a864087f01.jpg",@"http://static.damai.cn/mapi/2017-07-04/23fff54f-72c1-4af7-9260-c0a2750e8f8e.jpg",@"http://static.damai.cn/mapi/2017-06-26/17cf714a-df89-42f9-a31c-f1d51418eec8.jpg",@"http://static.damai.cn/mapi/2017-05-12/c182ffb9-3af8-4182-b1bf-018b7fc9e8b6.jpg",@"http://static.damai.cn/mapi/2017-06-26/19b67a4b-2483-4fc0-8221-04c07aa685c0.jpg",@"http://static.damai.cn/mapi/2017-07-03/a2534e9e-b108-40b3-a5ab-754870c30233.jpg"];
    }
    return _imgArr;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = [UIColor clearColor];
        
    }
    return _tableView;
}

-(HeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ADHeight)];
        _headerView.imgArr = self.imgArr;
        _headerView.delegate = self;
    }
    return _headerView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUI];
    [self setNavBar];
    
    
}

- (void)setNavBar{
    
    
    self.navBar = self.navigationController.navigationBar;
    
    
    //取消导航栏最下面的那一条线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
    
    UIBarButtonItem *left = [UIBarButtonItem itemWithImageName:@"my_message" highImageName:@"my" target:self action:@selector(msgClick)];
    
    UIBarButtonItem *right = [UIBarButtonItem itemWithImageName:@"icon_saomiao_normal" highImageName:@"my" target:self action:@selector(scanClick)];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.rightBarButtonItem = right;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [searchBtn setTitle:@"搜索趣事、新闻、iphone" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor colorWithHexString:@"#f9f9f9"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"index_search"] forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.3]];
    searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    searchBtn.width = ScreenWidth * 0.6;
    searchBtn.height = 30;
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.cornerRadius = 4;
    self.navigationItem.titleView = searchBtn;
    
}

- (void)msgClick{
    
    NSLog(@"消息");
}
- (void)scanClick{
    
    NSLog(@"扫描");
}


- (void)setUI{
    
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    return cell;
}

- (void)cycleScrollViewDidScrollViewToIndexforUrl:(NSString *)url
{
    [self.bgImg sd_cancelCurrentAnimationImagesLoad];
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:url]];
    //self.bgImg.image = [UIImage imageNamed:url];
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
