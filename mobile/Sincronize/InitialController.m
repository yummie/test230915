//
//  ViewController.m
//  Sincronize
//
//  Created by Fabio Martinez on 04/05/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "InitialController.h"
#import "InitialView.h"
#import "Helper.h"


@interface InitialController ()

@end

@implementation InitialController

@synthesize profile;
@synthesize token;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_accessTokenChanged:)
                                                 name:FBSDKAccessTokenDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_currentProfileChanged:)
                                                 name:FBSDKProfileDidChangeNotification
                                               object:nil];
    [[self basicView] setLayout];


    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - FaceBook Notification

// Observe a new token, so save it to our SUCache and update
// the cell.
- (void)_accessTokenChanged:(NSNotification *)notification {
    token = notification.userInfo[FBSDKAccessTokenChangeNewKey];
    //[[USHSettings sharedInstance] setFaceBookToken:token.tokenString];
    //[[USHSettings sharedInstance] setFaceBookID:token.userID];
    
    NSLog(@"_accessTokenChanged");
    
}

// The profile information has changed, update the cell and cache.
- (void)_currentProfileChanged:(NSNotification *)notification {
    profile = notification.userInfo[FBSDKProfileChangeNewKey];
    //[[USHSettings sharedInstance] setContactFirstName:profile.firstName];
    //[[USHSettings sharedInstance] setContactLastName:profile.lastName];
    NSLog(@"_currentProfileChanged");
}

- (IBAction)clickBtnFaceBook:(id)sender {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    login.loginBehavior = FBSDKLoginBehaviorNative;
    
    [login logInWithReadPermissions:@[@"public_profile", @"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Falha de conexão"
                                                                message:@"Não foi possível conectar com o servidor.\n Por favor verifique sua conexão com a Internet." delegate:self
                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
        else if (result.isCancelled) {

            NSLog(@"Cancelou");
        }
        else {
            if ([result.grantedPermissions containsObject:@"email"]) {
                if ([FBSDKAccessToken currentAccessToken]) {
                    
                    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
                     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                         if (!error) {
                             
                            NSLog(result[@"email"]);
                             NSLog(@"Enviar dados");
                             //fazendo o login com os dados do facebook
                             Usuario *usuarioLogado = [[Usuario alloc] init];
                             NSString *nomeCompleto = [NSString stringWithFormat:@"%@ %@",profile.firstName, profile.lastName];

                             usuarioLogado.nomeCompleto = nomeCompleto;
                             usuarioLogado.email = result[@"email"];
                             usuarioLogado.usuarioId = token.userID;
                             usuarioLogado.urlFoto = @"";
                             usuarioLogado.facebookLogin = YES;
                             
                             
                             [Helper setNSUsuario:usuarioLogado];
                             //logo o usuario
                             UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                             UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DashBoardControllerID"];
                             vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                             [self presentViewController:vc animated:YES completion:NULL];
                             
                         }
                     }];
                }
            }
        }
    }];
}

- (IBAction)clickBtnGoogle:(id)sender {
    NSLog(@"Google Click");

    
}


- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.activitIndicatorYConstraints.constant = [Helper screenHeight] > 480.0f ? 80 : 15;
}
@end
