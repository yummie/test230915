//
//  Usuario.m
//  DemoYummie
//
//  Created by Fabio Martinez on 25/09/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "Usuario.h"

@implementation Usuario
@synthesize usuarioId;
@synthesize nomeCompleto;
@synthesize nome;
@synthesize sobrenome;
@synthesize urlFoto;
@synthesize lat;
@synthesize lng;
@synthesize email;
@synthesize facebookLogin;


- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.nome forKey:@"nome"];
    [encoder encodeObject:self.sobrenome forKey:@"sobrenome"];
    [encoder encodeObject:self.nomeCompleto forKey:@"nomeCompleto"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.usuarioId forKey:@"usuarioId"];
    [encoder encodeObject:self.urlFoto forKey:@"urlFoto"];
    [encoder encodeFloat:self.lat forKey:@"lat"];
    [encoder encodeFloat:self.lng forKey:@"lng"];
    [encoder encodeBool:self.facebookLogin forKey:@"facebookLogin"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.nome = [decoder decodeObjectForKey:@"nome"];
        self.sobrenome = [decoder decodeObjectForKey:@"sobrenome"];
        self.nomeCompleto = [decoder decodeObjectForKey:@"nomeCompleto"];
        self.lat = [decoder decodeFloatForKey:@"lat"];
        self.lng = [decoder decodeFloatForKey:@"lng"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.usuarioId = [decoder decodeObjectForKey:@"usuarioId"];
        self.urlFoto = [decoder decodeObjectForKey:@"urlFoto"];
        self.facebookLogin = [decoder decodeBoolForKey:@"facebookLogin"];
    }
    return self;
}



- (NSString *)nome {
    if (nomeCompleto) {
        return [[nomeCompleto componentsSeparatedByString:@"-"] firstObject];
    }
    
    return nil;
}

- (NSString *)sobrenome {
    if (nomeCompleto) {
        return [[nomeCompleto componentsSeparatedByString:@"-"] lastObject];
    }
    
    return nil;
}

@end
