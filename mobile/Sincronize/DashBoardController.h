//
//  DashBoardController.h
//  DemoYummie
//
//  Created by Fabio Martinez on 24/09/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "BasicViewController.h"
#import "XLFormViewController.h"
#import "Usuario.h"

@interface DashBoardController : XLFormViewController{
    Usuario *usuarioLogado;
    IBOutlet UIImageView *fotoUsuario;
    IBOutlet UIActivityIndicatorView *activ;


}
@property (strong, nonatomic) Usuario *usuarioLogado;
@property (strong, nonatomic) IBOutlet UIImageView *fotoUsuario;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activ;
- (IBAction)btnSelecionaFoto:(id)sender;

- (IBAction)btnUploadFoto:(id)sender;

@end
