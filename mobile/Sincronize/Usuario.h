//
//  Usuario.h
//  DemoYummie
//
//  Created by Fabio Martinez on 25/09/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Usuario : NSObject{
    NSString *usuarioId;
    NSString *nomeCompleto;
    NSString *nome;
    NSString *sobrenome;
    NSString *email;
    NSString *urlFoto;
    float lat;
    float lng;
    BOOL facebookLogin;
    
}

@property (nonatomic,retain) NSString *usuarioId;
@property (nonatomic, retain) NSString *nome;
@property (nonatomic, retain) NSString *sobrenome;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *nomeCompleto;
@property (nonatomic, retain) NSString *urlFoto;
@property (nonatomic) float lat;
@property (nonatomic) float lng;
@property (nonatomic) BOOL facebookLogin;

@end
