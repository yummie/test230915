//
//  BasicViewController.m
//  Sincronize
//
//  Created by Fabio Martinez on 27/07/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "BasicViewController.h"


@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BasicView *)basicView
{
    return (BasicView *)self.view;
}

@end
