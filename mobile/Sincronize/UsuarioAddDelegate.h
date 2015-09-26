//
//  UsuarioAddDelegate.h
//  DemoYummie
//
//  Created by Fabio Martinez on 24/09/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterController.h"

@interface UsuarioAddDelegate : NSURLConnection{
    RegisterController *controllerCorrente;

}

@property(nonatomic,retain) RegisterController *controllerCorrente;


@end
