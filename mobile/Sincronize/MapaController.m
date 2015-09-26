//
//  MapaController.m
//  DemoYummie
//
//  Created by Fabio Martinez on 25/09/15.
//  Copyright (c) 2015 Sincronize. All rights reserved.
//

#import "MapaController.h"
#import "Helper.h"
#import "Usuario.h"

@interface MapaController ()

@end

@implementation MapaController

@synthesize mapView;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;

    
}

-(void) viewDidAppear:(BOOL)animated{
    Usuario *usuarioLogado = [Helper getNSUsuario];
    [self.mapView removeAnnotations:[self.mapView annotations]];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(usuarioLogado.lat, usuarioLogado.lng), 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:usuarioLogado.lat longitude:usuarioLogado.lng];
    
    [ceo reverseGeocodeLocation:loc
              completionHandler:^(NSArray *placemarks, NSError *error) {
                  CLPlacemark *placemark = [placemarks objectAtIndex:0];
                  if (placemark) {
                      MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
                      point.coordinate = CLLocationCoordinate2DMake(usuarioLogado.lat, usuarioLogado.lng);
                      point.title = [NSString stringWithFormat:@"Usuário: %@ %@",usuarioLogado.nome, usuarioLogado.sobrenome ];
                      point.subtitle = [NSString stringWithFormat:@"Endereço: %@ ",placemark.name];
                      
                      [self.mapView addAnnotation:point];
                  }else{
                      MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
                      point.coordinate = CLLocationCoordinate2DMake(usuarioLogado.lat, usuarioLogado.lng);
                      point.title = @"Você estava aqui quando se cadastrou.";
                      point.subtitle = [NSString stringWithFormat:@"Usuário: %@",usuarioLogado.nomeCompleto];
                      
                      [self.mapView addAnnotation:point];
                      
                  }
                  /*
                   NSLog(@"placemark %@",placemark);
                   //String to hold address
                   NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                   NSLog(@"addressDictionary %@", placemark.addressDictionary);
                   
                   NSLog(@"placemark %@",placemark.region);
                   NSLog(@"placemark %@",placemark.country);  // Give Country Name
                   NSLog(@"placemark %@",placemark.locality); // Extract the city name
                   NSLog(@"location %@",placemark.name);
                   NSLog(@"location %@",placemark.ocean);
                   NSLog(@"location %@",placemark.postalCode);
                   NSLog(@"location %@",placemark.subLocality);
                   
                   NSLog(@"location %@",placemark.location);
                   //Print the location to console
                   NSLog(@"I am currently at %@",locatedAt);
                   */
              }
     ];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

@end
