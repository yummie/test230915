//
//  InitialView.m
//  Sincronize
//
//  Created by Fabio Martinez on 24/07/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "InitialView.h"


@implementation InitialView



-(void) setLayout{
    self.lblLogarCom.text = NSLocalizedString(@"Logar com", nil);
    self.lblLogarCom.font = [UIFont fontWithName:@"Calibri" size:18];
    
    self.lblOu.text = NSLocalizedString(@"ou", nil);
    self.lblOu.font = [UIFont fontWithName:@"Calibri" size:18];


    [self.btnLogin setTitle:NSLocalizedString(@"Logar", nil) forState:UIControlStateNormal];
    self.btnLogin.titleLabel.font = [UIFont fontWithName:@"Calibri" size:15];
    
    self.btnFacebook.titleLabel.font = [UIFont fontWithName:@"FacebookLetterFaces" size:18];
    
    
    //configurando btnRegister
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    UIFont *font1 = [UIFont fontWithName:@"Calibri" size:18];
    NSDictionary *dict1 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                            NSFontAttributeName:font1,
                            NSParagraphStyleAttributeName:style}; // Added line

    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] init];
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:NSLocalizedString(@"Criar Conta", nil)   attributes:dict1]];
    [self.btnRegister setAttributedTitle:attString forState:UIControlStateNormal];
    [[self.btnRegister titleLabel] setNumberOfLines:0];
    [[self.btnRegister titleLabel] setLineBreakMode:NSLineBreakByWordWrapping];

    [super setLayout];

}


@end
