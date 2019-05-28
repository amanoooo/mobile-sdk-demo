//
//  AuthView.m
//  sdk-demo
//
//  Created by hikaru amano on 2019/5/27.
//  Copyright © 2019 hikaru amano. All rights reserved.
//

#import "AuthView.h"
#import "ColorUtil.h"
#import "Api.h"

#define ALERT_HEIGHT 358

#define MARGIN 20


@implementation AuthView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithName:(NSString *)name andPass:(NSString *)pass{
    self = [super init];
    if (self) {
        _name = name;
        _pass = pass;
        _alertView = [[UIView alloc] init];

        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor =  [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 5.0;
        float y = self.frame.size.height - ALERT_HEIGHT;
        _alertView.frame = CGRectMake(0, 0, self.frame.size.width, ALERT_HEIGHT);
        [self addSubview: self.alertView];
        [_alertView addSubview: self.mainView];
    }
    return self;
}

#pragma mark - 展示弹窗
- (void)showAuth{
    NSLog(@"show auth self name is %@, pass is %@", _name, _pass);
    
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];

    CGRect rc = self.alertView.frame;
    rc.origin.y = self.frame.size.height;
    self.alertView.frame = rc;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear         animations:^{
        CGRect rcc = self.alertView.frame;
        rcc.origin.y = self.frame.size.height - ALERT_HEIGHT;
        self.alertView.frame = rcc;
    } completion:^(BOOL finished) {
            NSLog(@"animation over");
    }];
//        self.loadingView.alpha = 1;
//        self.mobileHomeView.alpha = 0;
}

#pragma mark - 主界面
// 手机号显示的View
-(UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.alertView.frame), CGRectGetHeight(self.alertView.frame) - 15)];
        
        // title
        UILabel *titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(MARGIN, MARGIN, 200, 22)];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"SDK Title"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 20],NSForegroundColorAttributeName: [UIColor colorWithRed:66/255.0 green:73/255.0 blue:96/255.0 alpha:1.0]}];
        titleLabel.attributedText = string;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.alpha = 1.0;
        
        UIView *line1 = [self rowLineWithX:MARGIN andY: 2 * MARGIN + 22 AndWidth: self.frame.size.width - 2 * MARGIN ];
        
        // name
        UILabel *nameLable =[[UILabel alloc] initWithFrame:CGRectMake(MARGIN, 4 * MARGIN, 200, 20)];
        [nameLable setText: [NSString stringWithFormat:@"Received name: %@", _name]];
        [nameLable setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:18]];
        nameLable.textAlignment = NSTextAlignmentLeft;
        
        // pass
        UILabel *passLable =[[UILabel alloc] initWithFrame:CGRectMake(MARGIN, 6 * MARGIN, 200, 20)];
        [passLable setText: [NSString stringWithFormat:@"Received pass: %@", _pass]];
        [passLable setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:18]];
        passLable.textAlignment = NSTextAlignmentLeft;
        
        
        [_mainView addSubview: titleLabel];
        [_mainView addSubview: nameLable];
        [_mainView addSubview: passLable];
        [_mainView addSubview: line1];
        [_mainView addSubview: self.buttonView];
        
        
        
    }
    return _mainView;
}

- (UIView*) rowLineWithX:(CGFloat) x andY :(CGFloat)y AndWidth :(CGFloat) width {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(x, y, width, 1);
    
    view.layer.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    return view;
}

- (UIView*) buttonView {
    // 底部两个按钮
    float btnH = 40;
    float btnW = (self.frame.size.width - 20 - 2 * MARGIN) / 2.0;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, ALERT_HEIGHT-MARGIN-btnH, self.frame.size.width, btnH)];
    [view addSubview: [self getCustomBtn:true title:@"取消" action:@selector(cancel:) target:self frame:CGRectMake(MARGIN, 0, btnW, btnH)]];
    [view addSubview: [self getCustomBtn:false title:@"确认" action:@selector(confirm:) target:self frame:CGRectMake(self.frame.size.width - MARGIN - btnW, 0, btnW, btnH)]];
    return view;
}

#pragma mark - 自定义按钮白色和绿色的按钮
-(UIButton*)getCustomBtn:(BOOL)isWhite title:(NSString*)title action:(SEL)action target:(id)target frame:(CGRect)frame {
    int titeColor = 0x424960;
    int bgColor = 0xFFFFFF;
    if (!isWhite) {
        titeColor = 0xFFFFFF;
        bgColor = 0x424960;
    }
    UIButton *custBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    custBtn.backgroundColor = COLOR_HEX(bgColor, 1.0f);
    
//    [custBtn setContentMode:UIViewContentModeScaleToFill];
    [custBtn.layer setShadowOffset:CGSizeMake(2, 5)];
    [custBtn.layer setShadowColor:[[UIColor grayColor] CGColor]];
    [custBtn.layer setShadowOpacity:0.5];
    custBtn.frame = frame;
    custBtn.layer.cornerRadius = 4;
    custBtn.titleLabel.font = Font_ls_size(18);
    [custBtn setTitleColor:COLOR_HEX(titeColor, 1.0f) forState:UIControlStateNormal];
    [custBtn setTitleColor:COLOR_HEX(titeColor, 0.6f) forState:UIControlStateHighlighted];
    [custBtn setTitle:title forState:UIControlStateNormal];
    [custBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return custBtn;
}


-(void)cancel:(UIButton *)sender {
    NSLog(@"on cancel click");
}
-(void)confirm:(UIButton *)sender {
    NSLog(@"on confirm click");
    [Api fetchDate:_name andPass: _pass andCb: ^(NSDictionary *res ){
        NSLog(@"response i: %@", res);
    }];
}




@end
