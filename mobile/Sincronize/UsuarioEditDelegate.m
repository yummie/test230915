//
//  UsuarioEditDelegate.m
//  DemoYummie
//
//  Created by Fabio Martinez on 25/09/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "UsuarioEditDelegate.h"
#import "Helper.h"
#import "Usuario.h"

@implementation UsuarioEditDelegate

@synthesize controllerCorrente;



#pragma mark - NSURLConnection Delegate

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    NSDictionary *retornoJson = [NSDictionary alloc];
    NSError* error;
    
    retornoJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if(error){
        NSArray *keys = [error.userInfo allKeys];
        for (NSString *key in keys) {
            NSLog(@"%@ is %@",key, [error.userInfo objectForKey:key]);
        }
    }
    
    if ([retornoJson objectForKey:@"error"]== NO) {
        [Helper hideModal:self.controllerCorrente.view];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Aviso"
                                                            message:@"Dados não Atualizados."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alertView show];
    }else{
        [Helper hideModal:self.controllerCorrente.view];
        [Helper setNSUsuario:self.controllerCorrente.usuarioLogado];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Aviso"
                                                            message:@"Dados Atualizados."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alertView show];
        
        
    }
    
    
}


- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}


@end
