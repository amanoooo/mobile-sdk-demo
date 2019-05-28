//
//  Api.h
//  sdk-demo
//
//  Created by hikaru amano on 2019/5/28.
//  Copyright © 2019 hikaru amano. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ApiCallBack)(NSDictionary *response);

@interface Api : NSObject


+ (void) fetchDate:(NSString*) name andPass:(NSString*) pass andCb :(ApiCallBack)cb;
@end

NS_ASSUME_NONNULL_END
