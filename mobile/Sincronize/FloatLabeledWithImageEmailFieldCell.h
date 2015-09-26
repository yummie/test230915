//
//  FloatLabeledWithImageTextFieldCell.h
//  Sincronize
//
//  Created by Fabio Martinez on 03/08/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "XLFormBaseCell.h"
extern NSString * const XLFormRowDescriptorTypeFloatLabeledWithImageEmailField;

@interface FloatLabeledWithImageEmailFieldCell : XLFormBaseCell
{
    UIView *lineAfter;
    
}
@property (nonatomic, strong) UIView *lineAfter;

@end
