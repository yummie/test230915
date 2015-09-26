//
//  RegisterController.m
//  Sincronize
//
//  Created by Fabio Martinez on 27/07/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "RegisterController.h"
#import "BasicView.h"
#import "XLForm.h"
#import "FloatLabeledTextFieldCell.h"
#import "FloatLabeledPasswordFieldCell.h"
#import "FloatLabeledEmailFieldCell.h"
#import "CustomCellButton.h"
#import "Helper.h"
#import "UsuarioAddDelegate.h"


@interface RegisterController ()
- (IBAction)btnBackClick:(id)sender;

@end

@implementation RegisterController
     CLLocationManager *locationManager;
     CLLocation *currentLocation;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self basicView] setLayout];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    locationManager = [[CLLocationManager alloc]init]; // initializing locationManager
    
    locationManager.delegate = self; // we set the delegate of locationManager to self.
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    

    
    
    NSUInteger code = [CLLocationManager authorizationStatus];
    if (code == kCLAuthorizationStatusNotDetermined && ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
        // choose one request according to your business.
        if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
            [locationManager requestAlwaysAuthorization];
        } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
            [locationManager  requestWhenInUseAuthorization];
        } else {
            NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
        }
    }
    [locationManager startUpdatingLocation];  //requesting location updates

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark metodos de sobrecarga da XLFormViewController

-(void)initializeForm
{
    XLFormDescriptor * form = [XLFormDescriptor formDescriptorWithTitle:@"Custom Rows"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    // Section Ratings
    section = [XLFormSectionDescriptor formSectionWithTitle:Nil];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"dadoNome" rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Nome"];
    [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    row.required = YES;
    row.requireMsg = @"Nome não pode ser vazio";
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"dadoSobreNome" rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Sobrenome"];
    [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    row.required = YES;
    row.requireMsg = @"Sobrenome não pode ser vazio";
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"dadoEmail" rowType:XLFormRowDescriptorTypeFloatLabeledEmailField title:@"Email"];
    [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    row.required = YES;
    row.requireMsg = @"Email não pode ser vazio";
    [row addValidator:[XLFormValidator emailValidator]];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"dadoSenha" rowType:XLFormRowDescriptorTypeFloatLabeledPasswordField title:@"Senha"];
    [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    row.required = YES;
    row.requireMsg = @"Senha não pode ser vazio";
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"dadoConfirmaSenha" rowType:XLFormRowDescriptorTypeFloatLabeledPasswordField title:@"Confirmação de Senha"];
    [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    row.required = YES;
    row.requireMsg = @"Confirmar senha não pode ser vazio";
    [section addFormRow:row];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"EmptyRow" rowType:XLFormRowDescriptorTypeText title:nil];
    [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    row.disabled = @YES;
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Button" rowType:XLFormRowDescriptorTypeCustomCellButton title:@"Cadastrar"];
        row.action.formSelector = @selector(btnRegisterClick:);
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    self.form = form;
}


#pragma mark - Helper
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

- (IBAction)btnRegisterClick:(XLFormRowDescriptor *)sender {
    [Helper showModal:self.view titleToShowInMessage:@"Carregando..."];

    
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        [Helper hideModal:self.view];
        return;
    }
    NSDictionary *dadosForm = [self formValues];
    //Vejo se as senhas sao iguais
    if (![dadosForm[@"dadoSenha"] isEqualToString:dadosForm[@"dadoConfirmaSenha"]]) {
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: @"Senha e Confirmar Senha devem ser iguais.",
                                    XLValidationStatusErrorKey: @"024" };
        NSError * erroSenha = [[NSError alloc] initWithDomain:XLFormErrorDomain code:XLFormErrorCodeGen userInfo:userInfo];
        [self showFormValidationError:erroSenha];
        [Helper hideModal:self.view];
        return;
    }
    
    NSString *lat = @"";
    NSString *lng = @"";
    NSString *nomeCompleto = @"";
    
    nomeCompleto = [NSString stringWithFormat:@"%@-%@",dadosForm[@"dadoNome"], dadosForm[@"dadoSobreNome"]];
    if (currentLocation != nil) {
        lat = [NSString stringWithFormat:@"%.8f",currentLocation.coordinate.latitude];
        lng = [NSString stringWithFormat:@"%.8f",currentLocation.coordinate.longitude];
    }else{
        lat = @"0";
        lng = @"0";
    }
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"vch_nome\": \"%@\", \"vch_email\": \"%@\", \"vch_senha\": \"%@\", \"flt_lat\": \"%@\", \"flt_lng\": \"%@\"}",nomeCompleto, dadosForm[@"dadoEmail"],dadosForm[@"dadoSenha"],lat, lng];
    

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/add", [Helper getUrlServer]]];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];

    NSData* data = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];

    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody: data];
    UsuarioAddDelegate *usuarioAdd = [[UsuarioAddDelegate alloc] init];
    usuarioAdd.controllerCorrente = self;
    [NSURLConnection connectionWithRequest:request delegate:usuarioAdd];
    
    
}

- (IBAction)btnBackClick:(id)sender {
    
    [locationManager stopUpdatingHeading];
    [locationManager stopUpdatingLocation];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView - Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.form formRowAtIndex:indexPath].tag isEqualToString:@"EmptyRow"]){
        //return 50;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Aviso" message:@"Você optou por não permitir que o aplicativo use sua localização." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    currentLocation = newLocation;
}

@end
