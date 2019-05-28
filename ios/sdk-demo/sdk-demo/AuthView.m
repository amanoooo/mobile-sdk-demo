//
//  AuthView.m
//  sdk-demo
//
//  Created by hikaru amano on 2019/5/27.
//  Copyright © 2019 hikaru amano. All rights reserved.
//

#import "AuthView.h"


#define ALERT_HEIGHT 358

#define MARGIN_CONTENT 20


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
        UILabel *titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(MARGIN_CONTENT, MARGIN_CONTENT, 200, 22)];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"SDK Title"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 20],NSForegroundColorAttributeName: [UIColor colorWithRed:66/255.0 green:73/255.0 blue:96/255.0 alpha:1.0]}];
        titleLabel.attributedText = string;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.alpha = 1.0;
        
        UIView *line1 = [self rowLineWithX:MARGIN_CONTENT andY: 2 * MARGIN_CONTENT + 22 AndWidth: self.frame.size.width - 2 * MARGIN_CONTENT ];
        
        // name
        UILabel *nameLable =[[UILabel alloc] initWithFrame:CGRectMake(MARGIN_CONTENT, 4 * MARGIN_CONTENT, 200, 20)];
        [nameLable setText: [NSString stringWithFormat:@"Received name: %@", _name]];
        [nameLable setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:18]];
        nameLable.textAlignment = NSTextAlignmentLeft;
        
        // pass
        UILabel *passLable =[[UILabel alloc] initWithFrame:CGRectMake(MARGIN_CONTENT, 6 * MARGIN_CONTENT, 200, 20)];
        [passLable setText: [NSString stringWithFormat:@"Received pass: %@", _pass]];
        [passLable setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:18]];
        passLable.textAlignment = NSTextAlignmentLeft;
        
        [_mainView addSubview: titleLabel];
        [_mainView addSubview: nameLable];
        [_mainView addSubview: passLable];
        [_mainView addSubview: line1];
    }
    return _mainView;
}

-(UIView*)rowLineWithX:(CGFloat) x andY :(CGFloat)y AndWidth :(CGFloat) width {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(x, y, width, 1);
    
    view.layer.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    return view;
}






@end
