//
//  FloatLabelPasswordFieldCell.h
//  Sincronize
//
//  Created by Fabio Martinez on 29/07/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//
#import "XLFormBaseCell.h"

extern NSString * const XLFormRowDescriptorTypeFloatLabeledTextField;

@interface FloatLabeledTextFieldCell : XLFormBaseCell{
    UIView *lineAfter;

}
@property (nonatomic, strong) UIView *lineAfter;


@end
