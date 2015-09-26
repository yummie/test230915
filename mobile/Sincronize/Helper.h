//
//  Helper.h
//  Sincronize
//
//  Created by Fabio Martinez on 24/07/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Usuario.h"


@interface Helper : NSObject{
    
    UIView *modal;
    
}

@property(nonatomic, retain) UIView *modal;

+ (NSString *) getDeviceByScreenHeight:(NSNumber *)height;
+ (NSString *) assinadorUrl:(NSString *)url;
+ (NSString *) criptoString:(NSString *)str;
+ (NSString *) md5:(NSString *)str;
+ (BOOL) isIPad;
+ (BOOL) isIPhone;
+ (int) screenHeight;
+ (int) screenWidth;
+ (void)hideModal:(UIView*)viewAtual;
+ (void)showModal:(UIView*)viewAtual titleToShowInMessage:(NSString*)title;
+ (void)changeModelMessage:(UIView*)viewAtual titleToChange:(NSString*)title;
- (BOOL) hasNetwork;
- (BOOL) hasWiFi;
+(NSString*)getUrlServer;
+(Usuario *)getNSUsuario;
+(void)setNSUsuario:(Usuario *)usuario;
+ (NSString *)stringWithUUID;

@end
