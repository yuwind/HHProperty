//
//  NSObject+HHModelGenerate.m
//  HHModelGenerate
//
//  Created by 豫风 on 2017/12/22.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import "NSObject+HHModelGenerate.h"

@implementation NSObject (HHModelGenerate)

+ (void)generateProperty:(id)sources
{
    [self generateProperty:sources map:nil];
}
+ (void)generateProperty:(id)sources map:(NSDictionary *)map
{
    [self generateProperty:sources map:map container:nil];
}

+ (void)generateProperty:(id)sources map:(NSDictionary *)map container:(NSDictionary<NSString *,Class> *)container
{
    [self generateProperty:sources path:[self pathExistWithClass:self.class] map:map container:container];
}

+ (void)generateProperty:(id)sources path:(NSString *)path map:(NSDictionary *)map container:(NSDictionary<NSString *,Class> *)container
{
    if (!sources || !path) return;
    if ([sources isKindOfClass:[NSArray class]]) {
        NSArray *array = sources;
        if (array.count && [array.firstObject isKindOfClass:NSString.class]) {
            NSMutableString *string = [NSMutableString string];
            if (map) {
                NSMutableArray *arrayM = map.allKeys.mutableCopy;
                for (NSString *key in array) {
                    if ([arrayM containsObject:key]) {
                        [string appendString:formatString(@"@property (nonatomic, copy) NSString *%@;",map[key])];
                        [string appendString:@"\n"];
                    }else
                    {
                        [string appendString:formatString(@"@property (nonatomic, copy) NSString *%@;",key)];
                        [string appendString:@"\n"];
                    }
                }
                [self executeDeployment:string path:path];
            }else{
                for (NSString *key in array) {
                    [string appendString:formatString(@"@property (nonatomic, copy) NSString *%@;",key)];
                    [string appendString:@"\n"];
                }
                [self executeDeployment:string path:path];
            }
        }else if (array.count && [array.firstObject isKindOfClass:NSDictionary.class]){
            [self generateProperty:array.firstObject path:path map:map container:container];
        }
    }else if ([sources isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = sources;
        NSMutableString *string = [NSMutableString string];
        if (map) {
            NSMutableArray *arrayM = map.allKeys.mutableCopy;
            if (container) {
                NSMutableArray *arrayC = container.allKeys.mutableCopy;
                for (NSString *key in dict.allKeys) {
                    if ([arrayC containsObject:key]) {
                        [arrayC removeObject:key];
                        if ([dict[key] isKindOfClass:[NSDictionary class]] || [dict[key] isKindOfClass:[NSArray class]]) {
                            if ([arrayM containsObject:key]) {
                                [arrayM removeObject:key];
                                [string appendString:formatString(@"@property (nonatomic, strong) %@ *%@;",NSStringFromClass(container[key]),map[key])];
                                [string appendString:@"\n"];
                            }else{
                                [string appendString:formatString(@"@property (nonatomic, strong) %@ *%@;",NSStringFromClass(container[key]),key)];
                                [string appendString:@"\n"];
                            }
                            NSMutableDictionary *reduceMap = [NSMutableDictionary dictionaryWithDictionary:map];
                            [reduceMap removeObjectForKey:key];
                            NSMutableDictionary *reduceContainer = [NSMutableDictionary dictionaryWithDictionary:container];
                            [reduceContainer removeObjectForKey:key];
                            [self generateProperty:dict[key] path:[self pathExistWithClass:container[key]] map:reduceMap.copy container:reduceContainer];
                            
                        }else{
                            if ([arrayM containsObject:key]) {
                                [arrayM removeObject:key];
                                [string appendString:formatString(@"@property (nonatomic, copy) NSString *%@;",map[key])];
                                [string appendString:@"\n"];
                            }else{
                                [string appendString:formatString(@"@property (nonatomic, copy) NSString *%@;",key)];
                                [string appendString:@"\n"];
                            }
                        }
                        
                    }else{//container exclude
                        if ([arrayM containsObject:key]) {
                            [string appendString:formatString(@"@property (nonatomic, copy) NSString *%@;",map[key])];
                            [string appendString:@"\n"];
                        }else{
                            [string appendString:formatString(@"@property (nonatomic, copy) NSString *%@;",key)];
                            [string appendString:@"\n"];
                        }
                    }
                }
                [self executeDeployment:string path:path];
            }else//no container
            {
                for (NSString *key in dict.allKeys) {
                    if ([arrayM containsObject:key]) {
                        [string appendString:formatString(@"@property (nonatomic, copy) NSString *%@;",map[key])];
                        [string appendString:@"\n"];
                    }else
                    {
                        [string appendString:formatString(@"@property (nonatomic, copy) NSString *%@;",key)];
                        [string appendString:@"\n"];
                    }
                }
                [self executeDeployment:string path:path];
            }
        }else//no map
        {
            if (container) {
                NSMutableArray *arrayC = container.allKeys.mutableCopy;
                for (NSString *key in dict.allKeys) {
                    if ([arrayC containsObject:key]) {
                        [arrayC removeObject:key];
                        if ([dict[key] isKindOfClass:[NSDictionary class]] || [dict[key] isKindOfClass:[NSArray class]]) {
                            [string appendString:formatString(@"@property (nonatomic, strong) %@ *%@;",NSStringFromClass(container[key]),key)];
                            [string appendString:@"\n"];
                            NSMutableDictionary *reduceContainer = [NSMutableDictionary dictionaryWithDictionary:container];
                            [reduceContainer removeObjectForKey:key];
                            [self generateProperty:dict[key] path:[self pathExistWithClass:container[key]] map:map container:reduceContainer];
                        }else{
                            [string appendString:formatString(@"@property (nonatomic, copy) NSString *%@;",key)];
                            [string appendString:@"\n"];
                        }
                    }else{
                        [string appendString:formatString(@"@property (nonatomic, copy) NSString *%@;",key)];
                        [string appendString:@"\n"];
                    }
                }
                [self executeDeployment:string path:path];
            }else//no container
            {
                for (NSString *key in dict.allKeys) {
                    [string appendString:formatString(@"@property (nonatomic, copy) NSString *%@;",key)];
                    [string appendString:@"\n"];
                }
                [self executeDeployment:string path:path];
            }
        }
    }
}

+ (void)executeDeployment:(NSMutableString *)result path:(NSString *)path
{
    [result appendString:@"\n"];
    [result appendString:@"@end"];
    NSData *propertyData = [result dataUsingEncoding:(NSUTF8StringEncoding)];
    NSMutableData *fileData = [[NSMutableData alloc] initWithContentsOfFile:path];
    NSRange range = [fileData rangeOfData:[@"@end" dataUsingEncoding:NSUTF8StringEncoding] options:(NSDataSearchBackwards) range:NSMakeRange(0, fileData.length)];
    [fileData replaceBytesInRange:NSMakeRange(range.location, fileData.length - range.location) withBytes:NULL length:0];
    [fileData appendData:propertyData];
    [fileData writeToFile:path atomically:YES];
}

+ (NSString *)pathExistWithClass:(Class)class
{
    NSString *methodPath = formatString(@"%s",__FILE__);
    for (int i = 0; i<DEEPLEVEL; i++) {
        methodPath = methodPath.stringByDeletingLastPathComponent;
        NSArray *subpathArray = [[NSFileManager defaultManager] subpathsAtPath:methodPath];
        for (NSString *subPath in subpathArray) {
            if ([subPath.lastPathComponent isEqualToString:formatString(@"%@.h",NSStringFromClass(class))]) {
                return [methodPath stringByAppendingPathComponent:subPath];
            }
        }
    }
    return nil;
}

@end
