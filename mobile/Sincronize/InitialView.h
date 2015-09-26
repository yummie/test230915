//
//  InitialView.h
//  Sincronize
//
//  Created by Fabio Martinez on 24/07/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicView.h"

@interface InitialView : BasicView

@property (strong, nonatomic) IBOutlet UILabel *lblLogarCom;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UILabel *lblOu;
@property (strong, nonatomic) IBOutlet UIButton *btnFacebook;
@property (strong, nonatomic) IBOutlet UIButton *btnRegister;


@end
