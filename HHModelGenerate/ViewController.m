//
//  ViewController.m
//  HHModelGenerate
//
//  Created by 豫风 on 2017/12/22.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+HHModelGenerate.h"
#import "HHModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self testMethod4];
}

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

@end
