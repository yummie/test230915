//
//  LoginView.m
//  Sincronize
//
//  Created by Fabio Martinez on 01/08/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView





-(void) setLayout{

    CGRect rect=CGRectMake(0, 0, 158, 170);
    
    [self.btnBack setBounds:rect];
    
    
    
    //configurando btnForgetPassword
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    UIFont *font1 = [UIFont fontWithName:@"Calibri" size:18];
    NSDictionary *dict1 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                            NSFontAttributeName:font1,
                            NSParagraphStyleAttributeName:style}; // Added line
    
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] init];
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:NSLocalizedString(@"forget Password", nil)   attributes:dict1]];
    [self.btnForgetPassword setAttributedTitle:attString forState:UIControlStateNormal];
    [[self.btnForgetPassword titleLabel] setNumberOfLines:0];
    [[self.btnForgetPassword titleLabel] setLineBreakMode:NSLineBreakByWordWrapping];

    [super setLayout];
}

@end
