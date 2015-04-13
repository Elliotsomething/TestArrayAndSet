//
//  ViewController.m
//  text1
//
//  Created by 杨浩 on 15/4/13.
//  Copyright (c) 2015年 YH. All rights reserved.
//

#import "ViewController.h"
extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));

static size_t const count = 1000;
static size_t const iterations = 10000;

@interface ViewController ()

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //测试NSMutableArray arrayWithCapacity:和 NSMutableArray array谁的遍历更快；
    
    id object = @"[]";
    CFTimeInterval startTime1 = CACurrentMediaTime();
    {
        for (size_t i = 0; i < iterations; i++) {
            @autoreleasepool {
                NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:count];
                for (size_t j = 0; j < count; j++) {
                    [mutableArray addObject:object];
                }
            }
        }
    }
    CFTimeInterval endTime1 = CACurrentMediaTime();
    NSLog(@"Total Runtime: %g s", endTime1 - startTime1);
    
    CFTimeInterval startTime = CACurrentMediaTime();
    {
        for (size_t i = 0; i < iterations; i++) {
            @autoreleasepool {
                NSMutableArray *mutableArray = [NSMutableArray array];
                for (size_t j = 0; j < count; j++) {
                    [mutableArray addObject:object];
                }
            }
        }
    }
    CFTimeInterval endTime = CACurrentMediaTime();
    NSLog(@"Total Runtime: %g s", endTime - startTime);
    
    
    uint64_t t_0 = dispatch_benchmark(iterations, ^{
        @autoreleasepool {
            NSMutableArray *mutableArray = [NSMutableArray array];
            for (size_t i = 0; i < count; i++) {
                [mutableArray addObject:object];
            }
        }
    });
    NSLog(@"[[NSMutableArray array] addObject:] Avg. Runtime: %llu ns", t_0);
    
    uint64_t t_1 = dispatch_benchmark(iterations, ^{
        @autoreleasepool {
            NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:count];
            for (size_t i = 0; i < count; i++) {
                [mutableArray addObject:object];
            }
        }
    });
    NSLog(@"[[NSMutableArray arrayWithCapacity] addObject:] Avg. Runtime: %llu ns", t_1);
}


-(void)sample{
    
}

-(void)seg1:(NSString *)string seg2:(NSUInteger)num{
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
