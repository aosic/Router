//
//  DViewController.m
//  RouterExample
//
//  Created by aoxingkui on 2020/7/21.
//  Copyright © 2020 aosic. All rights reserved.
//

#import "DViewController.h"
#import <Router-Swift.h>

@interface DViewController () <AutoRouterable>

@end

@implementation DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
}

+ (NSString * _Nonnull)autoRouterKey {
    return @"router:3006";
}

@end
