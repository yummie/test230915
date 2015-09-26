//
//  FloatLabeledWithImagePasswordFieldCell.m
//  Sincronize
//
//  Created by Fabio Martinez on 03/08/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "FloatLabeledWithImagePasswordFieldCell.h"

#import "UIView+XLFormAdditions.h"
#import "JVFloatLabeledTextField.h"
#import "NSObject+XLFormAdditions.h"

#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>


NSString * const XLFormRowDescriptorTypeFloatLabeledWithImagePasswordField = @"XLFormRowDescriptorTypeFloatLabeledWithImagePasswordField";

const static CGFloat kHMargin = 15.0f;
const static CGFloat kVMargin = 8.0f;
const static CGFloat kFloatingLabelFontSize = 11.0f;

@interface FloatLabeledWithImagePasswordFieldCell () <UITextFieldDelegate>
@property (nonatomic) JVFloatLabeledTextField * floatLabeledPasswordField;
@end

@implementation FloatLabeledWithImagePasswordFieldCell
@synthesize floatLabeledPasswordField =_floatLabeledPasswordField;
@synthesize lineAfter;

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[FloatLabeledWithImagePasswordFieldCell class] forKey:XLFormRowDescriptorTypeFloatLabeledWithImagePasswordField];
}

-(JVFloatLabeledTextField *)floatLabeledPasswordField
{
    if (_floatLabeledPasswordField) return _floatLabeledPasswordField;
    
    _floatLabeledPasswordField = [JVFloatLabeledTextField autolayoutView];
    _floatLabeledPasswordField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _floatLabeledPasswordField.floatingLabel.font = [UIFont boldSystemFontOfSize:kFloatingLabelFontSize];
    
    _floatLabeledPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return _floatLabeledPasswordField;
}


#pragma mark - XLFormDescriptorCell

-(void)configure
{
    [super configure];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //criando a imagem de usuario
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, self.floatLabeledPasswordField.frame.size.height)];
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, -15, 20, 24)];
    [icon setImage:[UIImage imageNamed:@"Senha.png"]];
    [leftView addSubview:icon];
    
    self.floatLabeledPasswordField.leftView=leftView;
    self.floatLabeledPasswordField.leftViewMode=UITextFieldViewModeAlways;
    
    [self.contentView addSubview:self.floatLabeledPasswordField];
    lineAfter =[[UIView alloc] init];
    [lineAfter setBackgroundColor:[UIColor grayColor]];
    
    lineAfter.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:lineAfter];
    [self.floatLabeledPasswordField setDelegate:self];
    [self.contentView addConstraints:[self layoutConstraints]];
}

-(void)update
{
    [super update];
    
    self.floatLabeledPasswordField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:self.rowDescriptor.title
                                    attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    
    self.floatLabeledPasswordField.text = self.rowDescriptor.value ? [self.rowDescriptor.value displayText] : self.rowDescriptor.noValueDisplayText;
    [self.floatLabeledPasswordField setEnabled:!self.rowDescriptor.isDisabled];
    
    self.floatLabeledPasswordField.floatingLabelTextColor = [UIColor lightGrayColor];
    
    [self.floatLabeledPasswordField setAlpha:((self.rowDescriptor.isDisabled) ? .6 : 1)];
    self.floatLabeledPasswordField.keyboardType = UIKeyboardTypeDefault;
    self.floatLabeledPasswordField.secureTextEntry = YES;
    
}

-(BOOL)formDescriptorCellCanBecomeFirstResponder
{
    return !self.rowDescriptor.isDisabled;
}

-(BOOL)formDescriptorCellBecomeFirstResponder
{
    return [self.floatLabeledPasswordField becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return [self.formViewController textFieldShouldClear:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [self.formViewController textFieldShouldReturn:textField];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return [self.formViewController textFieldShouldBeginEditing:textField];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return [self.formViewController textFieldShouldEndEditing:textField];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self.formViewController textField:textField shouldChangeCharactersInRange:range replacementString:string];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.formViewController textFieldDidBeginEditing:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self textFieldDidChange:textField];
    [self.formViewController textFieldDidEndEditing:textField];
}

-(void)setReturnKeyType:(UIReturnKeyType)returnKeyType
{
    self.floatLabeledPasswordField.returnKeyType = returnKeyType;
}

-(UIReturnKeyType)returnKeyType
{
    return self.floatLabeledPasswordField.returnKeyType;
}

+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 55;
}



-(NSArray *)layoutConstraints
{
    NSMutableArray * result = [[NSMutableArray alloc] init];
    
    NSDictionary * views = @{@"floatLabeledTextField": self.floatLabeledPasswordField};
    NSDictionary *metrics = @{@"hMargin":@(kHMargin),
                              @"vMargin":@(kVMargin)};
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(25)-[floatLabeledTextField]-(hMargin)-|"
                                                                        options:0
                                                                        metrics:metrics
                                                                          views:views]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(vMargin)-[floatLabeledTextField]-(vMargin)-|"
                                                                        options:0
                                                                        metrics:metrics
                                                                          views:views]];
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(25)-[lineAfter]-(25)-|"
                                                                        options:0
                                                                        metrics:metrics
                                                                          views:NSDictionaryOfVariableBindings(lineAfter)]];
    
    [result addObjectsFromArray:[NSLayoutConstraint  constraintsWithVisualFormat:@"V:[lineAfter(==1)]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:NSDictionaryOfVariableBindings(lineAfter)]];
    
    [result addObjectsFromArray:[NSLayoutConstraint  constraintsWithVisualFormat:@"V:|-45-[lineAfter]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:NSDictionaryOfVariableBindings(lineAfter)]];
    
    return result;
}

#pragma mark - Helpers

- (void)textFieldDidChange:(UITextField *)textField
{
    if (self.floatLabeledPasswordField == textField) {
        if ([self.floatLabeledPasswordField.text length] > 0) {
            self.rowDescriptor.value = self.floatLabeledPasswordField.text;
        } else {
            self.rowDescriptor.value = nil;
        }
    }
}



@end
