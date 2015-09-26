//
//  UsuarioFotoUpLoadDelegate.m
//  DemoYummie
//
//  Created by Fabio Martinez on 25/09/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "UsuarioFotoUpLoadDelegate.h"
#import "Helper.h"

@implementation UsuarioFotoUpLoadDelegate

@synthesize controllerCorrente;


- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    //NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",strData);
    
    NSDictionary *retornoJson = [NSDictionary alloc];
    NSError* error;
    
    retornoJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if(error){
        NSArray *keys = [error.userInfo allKeys];
        for (NSString *key in keys) {
            NSLog(@"%@ is %@",key, [error.userInfo objectForKey:key]);
        }
        [Helper hideModal:self.controllerCorrente.view];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Aviso"
                                                            message:@"Foto não Atualizada."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alertView show];
        return;
    }
    
    if ([retornoJson objectForKey:@"error"]== 1) {
        [Helper hideModal:self.controllerCorrente.view];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Aviso"
                                                            message:@"Foto não Atualizada."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alertView show];
    }else{
        [Helper hideModal:self.controllerCorrente.view];
        self.controllerCorrente.usuarioLogado.urlFoto = [retornoJson objectForKey:@"url_foto"];
        [Helper setNSUsuario:self.controllerCorrente.usuarioLogado];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Aviso"
                                                            message:@"Foto Atualizada."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alertView show];
        
        
    }
    
    
}


- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [Helper hideModal:self.controllerCorrente.view];
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Erro"
                                                        message:@"Tamanho da Foto muito grande."
                                                       delegate:self
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
    [alertView show];
    
    NSString *msg = [NSString stringWithFormat:@"Failed: %@", [error description]];
    NSLog(@"%@",msg);
}

@end
