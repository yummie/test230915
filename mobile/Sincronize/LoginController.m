//
//  LoginController.m
//  Sincronize
//
//  Created by Fabio Martinez on 01/08/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "XLForm.h"
#import "LoginController.h"
#import "BasicView.h"
#import "FloatLabeledWithImageEmailFieldCell.h"
#import "CustomCellButton.h"
#import "FloatLabeledTextFieldCell.h"
#import "FloatLabeledWithImagePasswordFieldCell.h"
#import "Helper.h"
#import "UsuarioLoginDelegate.h"

@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[self basicView] setLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializeForm
{
    XLFormDescriptor * form = [XLFormDescriptor formDescriptorWithTitle:@"Custom Rows"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    // Section Ratings
    section = [XLFormSectionDescriptor formSectionWithTitle:Nil];
    [form addFormSection:section];
    
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"dadoEmail" rowType:XLFormRowDescriptorTypeFloatLabeledWithImageEmailField title:@"Email"];
    row.required = YES;
    row.requireMsg = @"Email não pode ser vazio";
    [row addValidator:[XLFormValidator emailValidator]];
    
    [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];

    [section addFormRow:row];
    
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"dadoSenha" rowType:XLFormRowDescriptorTypeFloatLabeledWithImagePasswordField title:@"Senha"];
    row.required = YES;
    row.requireMsg = @"Senha não pode ser vazio";
    [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];

    
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"EmptyRow" rowType:XLFormRowDescriptorTypeText title:nil];
    [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    row.disabled = @YES;
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Button" rowType:XLFormRowDescriptorTypeCustomCellButton title:@"Login"];
    row.action.formSelector = @selector(btnLoginClick:);
    
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    self.form = form;
    self.form.delegate = self;

}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        [self initializeForm];
    }
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initializeForm];
    }
    return self;
}

- (BasicView *)basicView
{
    return (BasicView *)self.view;
}

#pragma mark - Actions
- (IBAction)btnBackClick:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnLoginClick:(XLFormRowDescriptor *)sender {
    
    
    [Helper showModal:self.view titleToShowInMessage:@"Efetuando Login..."];

    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        [Helper hideModal:self.view];
        return;
    }
    
    NSDictionary *dadosForm = [self formValues];

    
    
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{ \"vch_email\": \"%@\", \"vch_senha\": \"%@\"}", dadosForm[@"dadoEmail"],dadosForm[@"dadoSenha"]];
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/login", [Helper getUrlServer]]];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSData* data = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];

    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody: data];
    UsuarioLoginDelegate *usuarioLogin = [[UsuarioLoginDelegate alloc] init];
    usuarioLogin.controllerCorrente = self;
    [NSURLConnection connectionWithRequest:request delegate:usuarioLogin];
    

}



#pragma mark - UITableView - Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.form formRowAtIndex:indexPath].tag isEqualToString:@"EmptyRow"]){
        return 50;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.logoTableVerticalSpaceConstraint.constant = [Helper screenHeight] > 480.0f ? 70 : 5;
    
    switch ([Helper screenHeight]) {
            
            // iPhone 4s
        case 480:
            self.btnForgetTopSpaceConstraint.constant = -90;
            break;
            
            // iPhone 5s
        case 568:
            self.btnForgetTopSpaceConstraint.constant = -110;
            break;
            
            // iPhone 6
        case 667:
            self.btnForgetTopSpaceConstraint.constant = -215;
            break;
            
            // iPhone 6 Plus
        case 736:
            self.btnForgetTopSpaceConstraint.constant = -280;
            break;
            
        default:
            // it's an iPad
            break;
    }
    
}
@end
