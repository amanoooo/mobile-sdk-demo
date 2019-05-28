//
//  SDK.m
//  sdk-demo
//
//  Created by hikaru amano on 2019/5/27.
//  Copyright © 2019 hikaru amano. All rights reserved.
//

#import "SDK.h"
#import "AuthView.h"

@implementation SDK
- (int)getTokenWithName:(NSString *)name andPass: (NSString *) pass {
    NSLog(@"name is %@ pass is %@", name, pass);
    AuthView * authView = [[AuthView alloc] initWithName:name andPass:pass];
    [authView showAuth];
    return 1;
}

@end
