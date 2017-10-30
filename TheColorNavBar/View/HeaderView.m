//
//  HeaderView.m
//  TheColorNavBar
//
//  Created by zhangming on 2017/10/27.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "HeaderView.h"
#import "SDCycleScrollView.h"


@interface HeaderView()<SDCycleScrollViewDelegate>

@property (strong, nonatomic) SDCycleScrollView *sdView;

@end

@implementation HeaderView

- (SDCycleScrollView *)sdView{
    
    if (!_sdView) {
        
        _sdView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ADHeight) delegate:self placeholderImage:[UIImage imageNamed:@"bg_placeholder"]];
    
        _sdView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        
        _sdView.autoScrollTimeInterval = 4.0f;
    }
    
    return _sdView;
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        [self setUI];
    }
    
    return self;
}

- (void)setUI{
    
    [self addSubview:self.sdView];
    
}

- (void)setImgArr:(NSArray *)imgArr{
    
    self.sdView.imageURLStringsGroup = imgArr;
    //self.sdView.localizationImageNamesGroup = imgArr;
   
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    NSLog(@"点击第%ld张图片",(long)index);
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    if ([self.delegate respondsToSelector:@selector(cycleScrollViewDidScrollViewToIndexforUrl:)]) {
        [self.delegate cycleScrollViewDidScrollViewToIndexforUrl:self.sdView.imageURLStringsGroup[index]];
    }
}


@end
