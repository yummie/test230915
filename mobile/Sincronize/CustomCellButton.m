//
//  CustomCellButton.m
//  Sincronize
//
//  Created by Fabio Martinez on 30/07/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "CustomCellButton.h"

NSString * const XLFormRowDescriptorTypeCustomCellButton = @"XLFormRowDescriptorTypeCustomCellButton";

@interface CustomCellButton()

@end

@implementation CustomCellButton

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([CustomCellButton class]) forKey:XLFormRowDescriptorTypeCustomCellButton];
}

#pragma mark - XLFormDescriptorCell

- (void)configure
{
    [super configure];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configureButtons];
}

-(void)update
{
    [super update];
    [self updateButtons];
}

#pragma mark - Helpers

-(void)configureButtons
{

}

-(void)updateButtons
{
    [self.btnCell setTitle:self.rowDescriptor.title forState:UIControlStateNormal];
    self.btnCell.titleLabel.font = [UIFont fontWithName:@"Calibri" size:18];
    [self.btnCell addTarget:self.formViewController action:self.rowDescriptor.action.formSelector forControlEvents:UIControlEventTouchUpInside];

}


+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor
{
    return 50;
}
@end
