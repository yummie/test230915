//
//  UsuarioAddDelegate.m
//  DemoYummie
//
//  Created by Fabio Martinez on 24/09/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "UsuarioAddDelegate.h"
#import <UIKit/UIKit.h>
#import "Helper.h"


@implementation UsuarioAddDelegate

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
                                                            message:@"Cadastro não realizado."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alertView show];
    }else{
        [Helper hideModal:self.controllerCorrente.view];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Aviso"
                                                            message:@"Cadastro realizado."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alertView show];
        //apagando dados do formulario
        [self.controllerCorrente.form.formSections enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            XLFormSectionDescriptor* sectionDescriptor = (XLFormSectionDescriptor*)obj;
            [sectionDescriptor.formRows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                XLFormRowDescriptor* row = (XLFormRowDescriptor*)obj;
                row.value = nil;
                [self.controllerCorrente reloadFormRow:row];
            }];
        }];

    }
   
    
}


- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
}


@end
