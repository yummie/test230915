//
//  UsuarioFotoUpLoadDelegate.h
//  DemoYummie
//
//  Created by Fabio Martinez on 25/09/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DashBoardController.h"

@interface UsuarioFotoUpLoadDelegate : NSURLConnection{

       DashBoardController *controllerCorrente;
}


@property(nonatomic,retain) DashBoardController *controllerCorrente;

@end
