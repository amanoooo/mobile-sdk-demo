//
//  ColorUtil.h
//  sdk-demo
//
//  Created by hikaru amano on 2019/5/28.
//  Copyright © 2019 hikaru amano. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorUtil : NSObject

#define COLOR_HEX(hexValue,alphaValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue]

#define Font_ls_size(size) [UIFont systemFontOfSize:size]


@end

NS_ASSUME_NONNULL_END
