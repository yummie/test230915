//
//  FloatLabelPasswordFieldCell.h
//  Sincronize
//
//  Created by Fabio Martinez on 30/07/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "XLFormBaseCell.h"

extern NSString * const XLFormRowDescriptorTypeFloatLabeledPasswordField;

@interface FloatLabeledPasswordFieldCell : XLFormBaseCell{
    UIView *lineAfter;
}
@property (nonatomic, strong) UIView *lineAfter;

@end
