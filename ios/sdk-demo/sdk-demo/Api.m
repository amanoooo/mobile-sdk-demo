//
//  Api.m
//  sdk-demo
//
//  Created by hikaru amano on 2019/5/28.
//  Copyright © 2019 hikaru amano. All rights reserved.
//

#import "Api.h"


#define ENDPOINT @"https://util.online"
//#define ENDPOINT @"http://218.168.168.59:3000"


@implementation Api


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



+(void)httpUrl:(NSString*)url method:(NSString*)method params:(NSDictionary*)params callBack:(ApiCallBack)callBack{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", ENDPOINT, url];
    // 1. URL
    NSURL *uri = [NSURL URLWithString:urlStr];
    
    // 2. 请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:uri];

    request.HTTPMethod = method;
    
    NSString *jsonString;
    
    // ? 数据体
    if (params != nil) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        if (!jsonData) {
            NSLog(@"%@",error);
        }else{
            jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    
    if(jsonString != nil) {
        // 将字符串转换成数据
        request.HTTPBody = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    // 3. 连接,异步
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError == nil) {
            // 网络请求结束之后执行!
            // 将Data转换成字符串
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *resJson = [Api dictionaryWithJsonString:str];

            if (callBack) {
                callBack(resJson);
            }
            
//            NSLog(@"%@ %@", str, [NSThread currentThread]);
        }
    }];
}

+ (void) fetchDate:(NSString*) name andPass:(NSString*) pass andCb :(ApiCallBack)cb {
    [Api httpUrl:[NSString stringWithFormat:@"/sdk?name=%@&pass=%@", name, pass] method:@"GET" params:nil callBack:cb];
}

@end


