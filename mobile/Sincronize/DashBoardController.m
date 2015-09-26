//
//  DashBoardController.m
//  DemoYummie
//
//  Created by Fabio Martinez on 24/09/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "DashBoardController.h"
#import "XLForm.h"
#import "FloatLabeledTextFieldCell.h"
#import "FloatLabeledPasswordFieldCell.h"
#import "FloatLabeledEmailFieldCell.h"
#import "CustomCellButton.h"
#import "UsuarioEditDelegate.h"
#import "UsuarioFotoUpLoadDelegate.h"
#import "Helper.h"
#import "UIImageView+AFNetworking.h"
#import "UIImage+Scale.h"

@interface DashBoardController ()

@end

@implementation DashBoardController

@synthesize usuarioLogado;
@synthesize fotoUsuario;
@synthesize activ;

- (void)viewDidLoad {
    [super viewDidLoad];
    //[[self basicView] setLayout];
    
    if (![self.usuarioLogado.urlFoto isEqualToString:@""]) {
        
        if (self.usuarioLogado.facebookLogin) {

            [self.fotoUsuario setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", self.usuarioLogado.usuarioId]] placeholderImage:[UIImage imageNamed:@"camera.png"]];
        }else{
            [self.activ startAnimating];
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.cetafba-admin.net/servico/app/webroot/img/foto_%@.jpg", self.usuarioLogado.usuarioId]]];
            __weak __typeof(self)weakSelf = self;
            [self.fotoUsuario setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"camera.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                [weakSelf.fotoUsuario setImage:image];
                [weakSelf.activ stopAnimating];

            } failure:nil];
            
            
        }

        
    }
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

#pragma mark metodos de sobrecarga da XLFormViewController

-(void)initializeForm
{
    usuarioLogado = [Helper getNSUsuario];
    XLFormDescriptor * form = [XLFormDescriptor formDescriptorWithTitle:@"Perfil"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    // Section Ratings
    section = [XLFormSectionDescriptor formSectionWithTitle:Nil];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"dadoNome" rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Nome"];
    [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    row.required = YES;
    row.value = usuarioLogado.nome;
    row.requireMsg = @"Nome não pode ser vazio";
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"dadoSobreNome" rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Sobrenome"];
    [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    row.required = YES;
    row.value = usuarioLogado.sobrenome;
    row.requireMsg = @"Sobrenome não pode ser vazio";
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"dadoEmail" rowType:XLFormRowDescriptorTypeFloatLabeledEmailField title:@"Email"];
    [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    row.required = YES;
    row.value = usuarioLogado.email;
    row.requireMsg = @"Email não pode ser vazio";
    [row addValidator:[XLFormValidator emailValidator]];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"dadoSenha" rowType:XLFormRowDescriptorTypeFloatLabeledPasswordField title:@"Senha"];
    [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    row.requireMsg = @"Senha não pode ser vazio";
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"dadoConfirmaSenha" rowType:XLFormRowDescriptorTypeFloatLabeledPasswordField title:@"Confirmação de Senha"];
    [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    row.required = YES;
    row.hidden = @"$dadoSenha==nil";
    row.requireMsg = @"Confirmar senha não pode ser vazio";
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"EmptyRow" rowType:XLFormRowDescriptorTypeText title:nil];
    [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    row.disabled = @YES;
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Button" rowType:XLFormRowDescriptorTypeCustomCellButton title:@"Alterar"];
    row.action.formSelector = @selector(btnUpdateClick:);
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    self.form = form;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)btnUpdateClick:(XLFormRowDescriptor *)sender {

    [Helper showModal:self.view titleToShowInMessage:@"Atualizando..."];
    
    
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        [Helper hideModal:self.view];
        return;
    }
    NSDictionary *dadosForm = [self formValues];
    
    NSString *jsonRequest = @"";
    NSString *nomeCompleto = @"";
    nomeCompleto = [NSString stringWithFormat:@"%@-%@",dadosForm[@"dadoNome"], dadosForm[@"dadoSobreNome"]];
    
    
    //se a senha foi preenchida vou validar o confirmarSenha
    if (dadosForm[@"dadoSenha"] != [NSNull null]) {
        //Vejo se as senhas sao iguais
        if (![dadosForm[@"dadoSenha"] isEqualToString:dadosForm[@"dadoConfirmaSenha"]]) {
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: @"Senha e Confirmar Senha devem ser iguais.",
                                        XLValidationStatusErrorKey: @"024" };
            NSError * erroSenha = [[NSError alloc] initWithDomain:XLFormErrorDomain code:XLFormErrorCodeGen userInfo:userInfo];
            [self showFormValidationError:erroSenha];
            [Helper hideModal:self.view];
            return;
        }
        jsonRequest = [NSString stringWithFormat:@"{\"vch_nome\": \"%@\", \"vch_email\": \"%@\", \"vch_senha\": \"%@\"}",nomeCompleto, dadosForm[@"dadoEmail"],dadosForm[@"dadoSenha"]];
    }else{
        jsonRequest = [NSString stringWithFormat:@"{\"vch_nome\": \"%@\", \"vch_email\": \"%@\"}",nomeCompleto, dadosForm[@"dadoEmail"]];
        
    
    }

    usuarioLogado.nomeCompleto = nomeCompleto;
    usuarioLogado.email = dadosForm[@"dadoEmail"];
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/edit/%@", [Helper getUrlServer],usuarioLogado.usuarioId]];

    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSData* data = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
    
    //NSString *strData = [[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",strData);
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody: data];
    UsuarioEditDelegate *usuarioEdit = [[UsuarioEditDelegate alloc] init];
    usuarioEdit.controllerCorrente = self;
    [NSURLConnection connectionWithRequest:request delegate:usuarioEdit];

}


- (IBAction)btnSelecionaFoto:(id)sender{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:NULL];


}

- (IBAction)btnUploadFoto:(id)sender{

    [Helper showModal:self.view titleToShowInMessage:@"Enviando Foto..."];
    
    UIImage *scaledImage = [self.fotoUsuario.image scaleToSize:CGSizeMake(100.0f, 100.0f)];

    
    NSData *imageData = UIImagePNGRepresentation(scaledImage);
    NSString *urlString = [NSString stringWithFormat:@"%@/saveFoto/%@",[Helper getUrlServer], self.usuarioLogado.usuarioId];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:30];
    [request setHTTPMethod:@"POST"];

    NSString *boundary = [[Helper stringWithUUID] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSMutableData *httpBody = [NSMutableData data];
    [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    
    NSString *contentDisposition = nil;
    NSString *fileName = [NSString stringWithFormat:@"foto_%@.jpg", usuarioLogado.usuarioId];
    contentDisposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"data[Usuario][foto]\"; filename=\"%@\"\r\n", fileName];
    [httpBody appendData:[contentDisposition dataUsingEncoding:NSUTF8StringEncoding]];
    

    NSString *contentType = [NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", @"image/jpeg"];
    [httpBody appendData:[contentType dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:imageData];
    [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", (long)httpBody.length] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:httpBody];
    
    
    UsuarioFotoUpLoadDelegate *usuarioFileUpload = [[UsuarioFotoUpLoadDelegate alloc] init];
    usuarioFileUpload.controllerCorrente = self;
    [NSURLConnection connectionWithRequest:request delegate:usuarioFileUpload];
    
    /*
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    NSData *imageData = UIImagePNGRepresentation(self.fotoUsuario.image);
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"unique-consistent-string";
    
    NSString *fileName = [NSString stringWithFormat:@"foto_%@.png", usuarioLogado.usuarioId];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"_method"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", @"POST"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"data[Usuario][foto]\"; filename=\"%@\";\r\n", fileName] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];

    
    UsuarioFotoUpLoadDelegate *usuarioFileUpload = [[UsuarioFotoUpLoadDelegate alloc] init];
    usuarioFileUpload.controllerCorrente = self;
    [NSURLConnection connectionWithRequest:request delegate:usuarioFileUpload];
*/
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


#pragma mark - UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    
    [self.fotoUsuario setImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIButton * btnUploadImagem = (UIButton *)[self.view viewWithTag:10];
    [btnUploadImagem setHidden:NO];

  
    
}
@end
