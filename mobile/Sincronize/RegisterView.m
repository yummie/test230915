//
//  RegisterView.m
//  Sincronize
//
//  Created by Fabio Martinez on 27/07/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView

-(void) setLayout{
    self.lblTitleView.text = NSLocalizedString(@"Cadastro", nil);
    self.lblTitleView.font = [UIFont fontWithName:@"LevenimMT" size:28];
    [super setLayout];
}

@end
