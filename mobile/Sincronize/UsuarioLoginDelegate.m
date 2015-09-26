//
//  UsuarioLoginDelegate.m
//  DemoYummie
//
//  Created by Fabio Martinez on 25/09/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "UsuarioLoginDelegate.h"
#import "Helper.h"
@implementation UsuarioLoginDelegate

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
    
    if ([[retornoJson objectForKey:@"error"] integerValue] == 0) {
        
        Usuario *usuarioLogado = [[Usuario alloc] init];
        
        usuarioLogado.nomeCompleto = [retornoJson objectForKey:@"vch_nome"];
        usuarioLogado.email = [retornoJson objectForKey:@"vch_email"];
        usuarioLogado.usuarioId = [retornoJson objectForKey:@"id"];
        if ([retornoJson objectForKey:@"vch_foto"] != [NSNull null]) {
            usuarioLogado.urlFoto = [retornoJson objectForKey:@"vch_foto"];
        }else{
            usuarioLogado.urlFoto = @"";        
        }
        usuarioLogado.lat = [[retornoJson objectForKey:@"flt_lat"] floatValue];
        usuarioLogado.lng = [[retornoJson objectForKey:@"flt_lng"] floatValue];
        usuarioLogado.facebookLogin = NO;
        
        
        [Helper hideModal:self.controllerCorrente.view];
        [Helper setNSUsuario:usuarioLogado];
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DashBoardControllerID"];
        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self.controllerCorrente presentViewController:vc animated:YES completion:NULL];
        
    }else{
        [Helper hideModal:self.controllerCorrente.view];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Aviso"
                                                            message:@"Usuario ou Senha Incorreto."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alertView show];

        
    }
    
    
}


- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}


@end
