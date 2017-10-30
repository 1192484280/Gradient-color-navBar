//
//  HeaderView.h
//  TheColorNavBar
//
//  Created by zhangming on 2017/10/27.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderViewDelegate <NSObject>

- (void)cycleScrollViewDidScrollViewToIndexforUrl:(NSString *)url;

@end

@interface HeaderView : UIView

@property (weak, nonatomic) id<HeaderViewDelegate>delegate;

@property (copy, nonatomic) NSArray *imgArr;

@end
