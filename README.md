

**说明：**
>简单易用的工具类，根据网络请求的数据自动导入模型属性，可以自定义字段，支持嵌套模型，告别每次都需要手动输入属性，减少输入错误。

**使用方法：**
>1、创建模型，如：HHModel、Hello、Word、为用户自定义模型。
>2、调用如下类方法创建属性方法`generateProperty`
>3、运行你的程序，你会发现模型属性已经出现

**包含方法：**
```objc
NSObject+HHModelGenerate.h
/**
 快速生成模型属性
 
 @param sources    数组或字典
 @para  map        替换字段映射
 @para  container  映射对象
 */
+ (void)generateProperty:(id)sources;
+ (void)generateProperty:(id)sources map:(NSDictionary *)map;
+ (void)generateProperty:(id)sources map:(NSDictionary *)map container:(NSDictionary <NSString *,Class>*)container;
```

**1、数组包含属性：**
```objc
- (void)testMethod1
{
    NSArray *array =
    @[
      @"perporty1",
      @"perporty2",
      @"perporty3",
      ];
    [HHModel generateProperty:array];
}
```

**2、数组包含字典：**
```objc
- (void)testMethod2
{
    NSArray *array =
    @[
      @{
          @"property1":@"hi",
          @"property2":@"hi",
        },
      @{
          @"property1":@"nihao",
          @"property2":@"nihao",
        }
      ];
    [HHModel generateProperty:array];
}
```
**3、字典包含数组：**
```objc
- (void)testMethod3
{
    NSDictionary *dict =
    @{
      @"a1":@[
          @{
              @"helloProperty1":@"hi",
              @"helloProperty2":@"hi",
              },
          ],
      };
    [HHModel generateProperty:dict map:@{@"a1":@"helloModel"} container:@{@"a1":Hello.class}];
}
```
**4、嵌套属性：**
```objc
- (void)testMethod4
{
    NSDictionary *dict =
    @{
      @"hello":@{
              @"helloProperty1":@"hi",
              @"helloProperty2":@"hi",
              },
      @"word":@[
              @{
                  @"wordProperty1":@"hi"
                  }
              ],
      @"c":@"hi",
      @"d":@"hi"
      };
    [HHModel generateProperty:dict map:@{@"hello":@"helloModel",@"word":@"wordModelArray"} container:@{@"hello":Hello.class,@"word":Word.class}];
}
```

**Demo下载地址：**
[HHModelGenerate](https://github.com/yuwind/HHModelGenerate)


