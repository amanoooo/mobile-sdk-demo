//
//  AuthView.h
//  sdk-demo
//
//  Created by hikaru amano on 2019/5/27.
//  Copyright © 2019 hikaru amano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthView : UIView


@property NSString *name;
@property NSString *pass;
@property(nonatomic) UIView *alertView;
@property(nonatomic) UIView *mainView;
@property(nonatomic) id<SDKDelegate> delegate;


- (instancetype) initWithName:(NSString *) name andPass:(NSString *) pass andDelegate:(id<SDKDelegate>) delegate;

- (void)showAuth;


@end


NS_ASSUME_NONNULL_END
