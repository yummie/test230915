//
//  LoginController.h
//  Sincronize
//
//  Created by Fabio Martinez on 01/08/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "XLFormViewController.h"
#import "BasicViewController.h"

@interface LoginController : XLFormViewController

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logoTableVerticalSpaceConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *btnForgetTopSpaceConstraint;
- (IBAction)btnBackClick:(id)sender;

@end
