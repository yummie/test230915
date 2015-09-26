//
//  ViewController.h
//  Sincronize
//
//  Created by Fabio Martinez on 04/05/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface InitialController : BasicViewController{
    FBSDKAccessToken *token;
    FBSDKProfile *profile;

}

- (IBAction)clickBtnFaceBook:(id)sender;
- (IBAction)clickBtnGoogle:(id)sender;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *activitIndicatorYConstraints;
@property (strong, nonatomic) FBSDKAccessToken *token;
@property (strong, nonatomic) FBSDKProfile *profile;

@end

