//
//  SDPaoMaDengView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/12.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDPaoMaDengView.h"
#import "TXScrollLabelView.h"


@interface  SDPaoMaDengView () <TXScrollLabelViewDelegate>
//跑马灯效果
@property (nonatomic, strong) TXScrollLabelView *scrollLabelView;

@end


@implementation SDPaoMaDengView

-(instancetype)initWithFrame:(CGRect)frame andHotArr:(NSArray*)hotArrs{
    if (self = [super initWithFrame:frame]) {
        [self createUIHotArr:hotArrs];
    }
    return self;
}

-(void) createUIHotArr:(NSArray *)arr{
    
    //设置leftImageV
    self.leftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self addSubview:self.leftImageV];
    
     self.scrollLabelView = [TXScrollLabelView scrollWithTextArray:arr type:TXScrollLabelViewTypeFlipNoRepeat velocity:1 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
    /** Step3: 设置代理进行回调 */
    self.scrollLabelView.scrollLabelViewDelegate = self;
    
    /** Step4: 布局(Required) */
    self.scrollLabelView.frame = CGRectMake(40 , 0, self.frame.size.width-40, self.frame.size.height);
    [self addSubview:_scrollLabelView];

    //偏好(Optional), Preference,if you want.
   // self.scrollLabelView.tx_centerX  = [UIScreen mainScreen].bounds.size.width * 0.5;
    self.scrollLabelView.scrollInset = UIEdgeInsetsMake(0, 10 , 0, 10);
    self.scrollLabelView.scrollSpace = 10;
    self.scrollLabelView.font = [UIFont systemFontOfSize:13];
    self.scrollLabelView.textAlignment = NSTextAlignmentCenter;
    self.scrollLabelView.backgroundColor = [UIColor clearColor];
    self.scrollLabelView.scrollTitleColor = [UIColor colorWithHexString:@"#333333"];
    self.scrollLabelView.layer.cornerRadius = 5;
    
    /** Step5: 开始滚动(Start scrolling!) */
    [self.scrollLabelView beginScrolling];
   
}
- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index{
    NSLog(@"%@--%ld",text, index);
}



@end
