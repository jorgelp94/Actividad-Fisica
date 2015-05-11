//
//  ViewControllerLogin.m
//  actividadFisica
//
//  Created by Jorge Luis Perales on 21/03/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "ViewControllerLogin.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface ViewControllerLogin ()

@end

@implementation ViewControllerLogin

- (void) quitaTeclado {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Gestura para quitar el teclado de la pantalla al dar tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitaTeclado)];
    [self.view addGestureRecognizer:tap];
    
    AppDelegate *appDelegateVar = [[UIApplication sharedApplication] delegate];
    
    // Usuario y contraseña de administrador
    appDelegateVar.userArturo = @"L00888888";
    appDelegateVar.passArturo = @"arturo";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)unwindRegistro:(UIStoryboardSegue *)segue {
    // no hace nada
}

- (IBAction)presionoIniciarSesion:(UIButton *)sender {
    
    AppDelegate *appDelegateLogin = [[UIApplication sharedApplication] delegate];
    
    //Verifica si es el usuario y contraseña del administrador
    if ([self.loginMatricula.text isEqualToString:appDelegateLogin.userArturo] && [self.loginPassword.text isEqualToString:appDelegateLogin.passArturo]) {
        [self performSegueWithIdentifier:@"administrador" sender:sender];
    } else {
        
    // Si no es el administrador, verifica que el usuario y contraseña tecleados
    // existan en la base de datos
        NSString *mat = [[NSString alloc] initWithFormat:@"%@", self.loginMatricula.text];
        NSString *pas = [[NSString alloc] initWithFormat:@"%@", self.loginPassword.text];
        PFQuery *query = [PFQuery queryWithClassName:@"Usuario"];
        [query whereKey:@"matricula" equalTo:mat];
        [query whereKey:@"password" equalTo:pas];
    
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            appDelegateLogin.generalID = object.objectId;
            appDelegateLogin.matriculaGeneral = object[@"matricula"];
            appDelegateLogin.genero = object[@"genero"];
            
            NSString *fechaNacimiento = object[@"fecha"];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd-MM-yyyy"];
            NSDate *nacimiento = [[NSDate alloc] init];
            nacimiento = [dateFormatter dateFromString:fechaNacimiento];
            
            NSDate *now = [NSDate date];
            NSDateComponents *ageComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:nacimiento toDate:now options:0];
            NSInteger age = [ageComponents year];
            NSString *edad = [[NSString alloc] initWithFormat:@"%ld", (long)age];

            appDelegateLogin.edad = edad;
            
            NSLog(@"%@",appDelegateLogin.edad);
            
            NSLog(@"%@",appDelegateLogin.matriculaGeneral);
            NSLog(@"%@", object.objectId);
            if (!object) {
                NSString *mensaje = [[NSString alloc] initWithFormat:@"El usuario y/o contraseña son incorrectos."];
                UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Error" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alerta show];

            }
            else {
                NSString *mensaje = [[NSString alloc] initWithFormat:@"Inicio de sesión exitoso."];
                UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Login" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alerta show];
                [self performSegueWithIdentifier:@"usuario" sender:sender];
            }
        }];
    }
    
}



@end
