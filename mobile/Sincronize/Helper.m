//
//  Helper.m
//  Sincronize
//
//  Created by Fabio Martinez on 24/07/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "Helper.h"
#import "Base64.h"
#import <CommonCrypto/CommonDigest.h>

#define TAGMODAL  4204
#define TAGLABEL  4205

@implementation Helper

@synthesize modal;


+ (NSString *)getDeviceByScreenHeight:(NSNumber *)height {
    BOOL isRetina = NO;
    NSMutableString *device = [NSMutableString new];
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        isRetina = [[UIScreen mainScreen] scale] == 2.0 ? YES : NO;
    }
    
    if ([self isIPhone]) {
        [device appendString:@"iPhone"];
        
        switch (height.integerValue)
        {
            case 568:
                [device appendString:@"5"];
                break;
            case 667:
                [device appendString:@"6"];
                break;
            case 736:
                [device appendString:@"6Plus"];
                break;
            default:
                [device appendString:@"4"];
                break;
        }
    }
    else {
        [device appendString:@"iPad"];
        if (isRetina && ([height isEqualToNumber:@1024])) {
            [device appendString:@"Retina"];
        }
    }
    
    return [NSString stringWithString:device];
}


+ (NSString*)assinadorUrl:(NSString *)url{
    NSString *segredo = @"glubglub";
    int ttl = 900;
    long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
    long expira = currentTime + ttl;
    NSString *urlCompleta = [NSString stringWithFormat:@"//app/secure2%@",url];
    //NSString *urlCompleta = [NSString stringWithFormat:@"/correiodigital/app/apitest%@",url];
    
    NSString *dados = [NSString stringWithFormat:@"%@%@%ld",segredo,urlCompleta,expira];
    NSString *base64str = [Helper criptoString:dados];
    
    base64str = [base64str stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    base64str = [base64str stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    
    base64str = [base64str stringByReplacingOccurrencesOfString:@"="  withString:@""];
    NSString *urlRetorno = [NSString stringWithFormat:@"http://www.sincronize.net%@?st=%@&e=%ld",urlCompleta,base64str,expira];
    return urlRetorno;
    
}

+ (NSString *) md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

//funcao aplica md5 e depois converte para base 64
+(NSString *) criptoString:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    
    NSData* data = [NSData dataWithBytes:(const void *)result length:sizeof(unsigned char)*16];
    return [data base64EncodedString];
    
}

+ (BOOL) isIPad {
    BOOL iPad = NO;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        iPad = YES;
    }
    return iPad;
}

+ (BOOL) isIPhone {
    BOOL iPhone = NO;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        iPhone = YES;
    }
    return iPhone;
}

+(int) screenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}

+(int) screenWidth{
    return [UIScreen mainScreen].bounds.size.width;
}

- (BOOL) hasNetwork {

    return YES;
}

- (BOOL) hasWiFi {

    return YES;
}

+(void)showModal:(UIView*)viewAtual titleToShowInMessage:(NSString*)title{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    int numberOfFrames = 29;
    
    NSMutableArray *imagesArray = [NSMutableArray arrayWithCapacity:numberOfFrames];
    
    for (int i=0; numberOfFrames > i; ++i){
        [imagesArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"l_%d.png", i]]];
    }
    
    UIImageView *animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55,10,40,40)];
    animationImageView.animationImages = imagesArray;
    animationImageView.animationDuration = 1.2;

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;



    //view principal que vai ser o overlayer
    UIView *viewContainer = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.screenWidth, self.screenHeight)];
    [viewContainer setBackgroundColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:0.5]];
    viewContainer.tag = TAGMODAL;
    [viewAtual addSubview:viewContainer];//adicionando minha view na tela corrente
    
    UIImageView *imageViewModal = [[UIImageView alloc] init];
    UIImage *imagemBGModal = [[UIImage alloc] init];
    imagemBGModal = [UIImage imageNamed:@"modal_load"];
    CGRect frame = imageViewModal.frame;
    frame.size.height = imagemBGModal.size.height;
    frame.size.width = imagemBGModal.size.width;
    imageViewModal.frame = frame;
    

    [imageViewModal setTranslatesAutoresizingMaskIntoConstraints:NO];

    imageViewModal.image = imagemBGModal;
    
    //criando label para exibir texto
    UILabel *lblMsg = [[UILabel alloc] initWithFrame:CGRectMake(5, 60, imagemBGModal.size.width -10, 40)];
    [lblMsg setBackgroundColor:[UIColor clearColor]];
    lblMsg.font = [UIFont fontWithName:@"Calibri" size:16];
    lblMsg.textColor = [UIColor whiteColor];
    lblMsg.lineBreakMode = NSLineBreakByWordWrapping;
    lblMsg.numberOfLines = 2;
    lblMsg.textAlignment = NSTextAlignmentCenter;
    lblMsg.tag = TAGLABEL;
    [lblMsg setText:title];
    [imageViewModal addSubview:lblMsg];
    
    
    [viewContainer addSubview:imageViewModal];//adicionamdo a view da modal na viewConteiner que tem a layer
    
    //alinhamento horizontal
    [viewContainer addConstraint:[NSLayoutConstraint constraintWithItem:imageViewModal
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:viewContainer
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    //alinhamento vertical
    [viewContainer addConstraint:[NSLayoutConstraint constraintWithItem:imageViewModal
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:viewContainer
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [imageViewModal addSubview:animationImageView];//adicionando a animacao
    
    [animationImageView startAnimating];//iniciando anaimacao
    
}

+(void)hideModal:(UIView*)viewAtual{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIView * viewModal = (UIView *)[viewAtual viewWithTag:TAGMODAL];
    [viewModal removeFromSuperview];
}

+(void)changeModelMessage:(UIView*)viewAtual titleToChange:(NSString*)title{
    UILabel * lblTitle = (UILabel *)[viewAtual viewWithTag:TAGLABEL];
    lblTitle.text = title;
}

+(NSString*)getUrlServer{

        return @"http://www.cetafba-admin.net/servico/usuarios";
    
}

+(Usuario *)getNSUsuario;{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *usuarioEncodedObject = [defaults objectForKey:@"dadosUsuario"];
    Usuario *nsUsuario = nil;
    if(usuarioEncodedObject!=nil){
        nsUsuario = (Usuario *)[NSKeyedUnarchiver unarchiveObjectWithData: usuarioEncodedObject];
    }
    return nsUsuario;
}

+(void)setNSUsuario:(Usuario *)usuario{
    NSData *usuarioEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:usuario];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:usuarioEncodedObject forKey:@"dadosUsuario"];
    [defaults synchronize];
    
}

+ (NSString *)stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (NSString *)CFBridgingRelease(string);
}


@end
