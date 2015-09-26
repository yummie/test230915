//
//  UsuarioLoginDelegate.h
//  DemoYummie
//
//  Created by Fabio Martinez on 25/09/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginController.h"

@interface UsuarioLoginDelegate : NSURLConnection{
    LoginController *controllerCorrente;
}

@property(nonatomic,retain) LoginController *controllerCorrente;

@end
