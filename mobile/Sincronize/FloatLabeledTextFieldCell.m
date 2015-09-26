
#import "FloatLabeledTextFieldCell.h"
#import "UIView+XLFormAdditions.h"
#import "JVFloatLabeledTextField.h"
#import "NSObject+XLFormAdditions.h"

#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>

NSString * const XLFormRowDescriptorTypeFloatLabeledTextField = @"XLFormRowDescriptorTypeFloatLabeledTextField";

const static CGFloat kHMargin = 15.0f;
const static CGFloat kVMargin = 8.0f;
const static CGFloat kFloatingLabelFontSize = 11.0f;

@interface FloatLabeledTextFieldCell () <UITextFieldDelegate>
@property (nonatomic) JVFloatLabeledTextField * floatLabeledTextField;
@end

@implementation FloatLabeledTextFieldCell
@synthesize lineAfter;
@synthesize floatLabeledTextField =_floatLabeledTextField;

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[FloatLabeledTextFieldCell class] forKey:XLFormRowDescriptorTypeFloatLabeledTextField];
}

-(JVFloatLabeledTextField *)floatLabeledTextField
{
    if (_floatLabeledTextField) return _floatLabeledTextField;
    
    _floatLabeledTextField = [JVFloatLabeledTextField autolayoutView];
    _floatLabeledTextField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _floatLabeledTextField.floatingLabel.font = [UIFont boldSystemFontOfSize:kFloatingLabelFontSize];

    _floatLabeledTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return _floatLabeledTextField;
}

#pragma mark - XLFormDescriptorCell

-(void)configure
{
    [super configure];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.contentView addSubview:self.floatLabeledTextField];
    
    
    lineAfter =[[UIView alloc] init];
    //[lineAfter setBackgroundColor:[UIColor colorWithRed:132.0f green:134.0f blue:136.0f alpha:1.0f]];
    [lineAfter setBackgroundColor:[UIColor grayColor]];

    lineAfter.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:lineAfter];

    
    [self.floatLabeledTextField setDelegate:self];
    [self.contentView addConstraints:[self layoutConstraints]];

}

-(void)update
{
    [super update];
    
    self.floatLabeledTextField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:self.rowDescriptor.title
                                    attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    
    self.floatLabeledTextField.text = self.rowDescriptor.value ? [self.rowDescriptor.value displayText] : self.rowDescriptor.noValueDisplayText;
    [self.floatLabeledTextField setEnabled:!self.rowDescriptor.isDisabled];
    
    self.floatLabeledTextField.floatingLabelTextColor = [UIColor lightGrayColor];
    
    [self.floatLabeledTextField setAlpha:((self.rowDescriptor.isDisabled) ? .6 : 1)];
    self.floatLabeledTextField.keyboardType = UIKeyboardTypeDefault;


}

-(BOOL)formDescriptorCellCanBecomeFirstResponder
{
    return !self.rowDescriptor.isDisabled;
}

-(BOOL)formDescriptorCellBecomeFirstResponder
{
    return [self.floatLabeledTextField becomeFirstResponder];
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
    self.floatLabeledTextField.returnKeyType = returnKeyType;
}

-(UIReturnKeyType)returnKeyType
{
    return self.floatLabeledTextField.returnKeyType;
}

+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 55;
}



-(NSArray *)layoutConstraints
{
    NSMutableArray * result = [[NSMutableArray alloc] init];

    NSDictionary * views = @{@"floatLabeledTextField": self.floatLabeledTextField};
    NSDictionary *metrics = @{@"hMargin":@(kHMargin),
                              @"vMargin":@(kVMargin)};
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(45)-[floatLabeledTextField]-(hMargin)-|"
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
    if (self.floatLabeledTextField == textField) {
        if ([self.floatLabeledTextField.text length] > 0) {
            self.rowDescriptor.value = self.floatLabeledTextField.text;
        } else {
            self.rowDescriptor.value = nil;
        }
    }
}



@end
