//
//  SDK.h
//  sdk-demo
//
//  Created by hikaru amano on 2019/5/27.
//  Copyright © 2019 hikaru amano. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN


@protocol SDKDelegate <NSObject>
@required

-(void)tokenOnResult:(NSString* __nullable)token name: (NSString* __nullable) name;

@end

@interface SDK : NSObject
- (void)getTokenWithName:(NSString *)name andPass: (NSString *) pass andDelegate:(id<SDKDelegate>) delegate;

@end

NS_ASSUME_NONNULL_END
