//
//  NSObject+HHModelGenerate.h
//  HHModelGenerate
//
//  Created by 豫风 on 2017/12/22.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DEEPLEVEL 3//查找类的层级数


static inline NSString *formatString(NSString *format,...){
    va_list args;
    va_start(args, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    return string;
}

@interface NSObject (HHModelGenerate)

/**
 快速生成模型属性
 
 @param sources    数组或字典
 @para  map        替换字段映射
 @para  container  映射对象
 */
+ (void)generateProperty:(id)sources;
+ (void)generateProperty:(id)sources map:(NSDictionary *)map;
+ (void)generateProperty:(id)sources map:(NSDictionary *)map container:(NSDictionary <NSString *,Class>*)container;

@end
