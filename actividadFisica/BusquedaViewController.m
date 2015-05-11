//
//  BusquedaViewController.m
//  actividadFisica
//
//  Created by Jorge Luis Perales on 22/04/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "BusquedaViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface BusquedaViewController ()

@end

@implementation BusquedaViewController

- (void) quitaTeclado {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Gestura para quitar el teclado de la pantalla al dar tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitaTeclado)];
    [self.view addGestureRecognizer:tap];
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

- (IBAction)presionoBuscar:(UIButton *)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    appDelegate.busqueda = self.buscaMatricula.text;
    
    //Carga la información del usuario con la matrícula tecleada en el campo
    PFQuery *query = [PFQuery queryWithClassName:@"Usuario"];
    [query whereKey:@"matricula" equalTo:self.buscaMatricula.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            
            // Si  no regresa ningún objeto, significa que no existe en la base de datos
            if (objects.count == 0) {
                NSString *mensaje = [[NSString alloc] initWithFormat:@"Matricula incorrecta o no existe"];
                UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alerta show];
            } else {
                // Do something with the found objects
                for (PFObject *object in objects) {
                    //NSLog(@"%@", object.objectId);
                
                    [query getObjectInBackgroundWithId:object.objectId block:^(PFObject *usuario, NSError *error) {
                        self.tfNombre.text = usuario[@"nombre"];
                        self.tfMatricula.text = usuario[@"matricula"];
                        self.tfEstatura.text = usuario[@"estatura"];
                        self.tfPeso.text = usuario[@"peso"];
                    
                        appDelegate.genero = usuario[@"genero"];
                    
                        NSString *fechaNacimiento = object[@"fecha"];
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
                        NSDate *nacimiento = [[NSDate alloc] init];
                        nacimiento = [dateFormatter dateFromString:fechaNacimiento];
                    
                        NSDate *now = [NSDate date];
                        NSDateComponents *ageComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:nacimiento toDate:now options:0];
                        NSInteger age = [ageComponents year];
                        NSString *edad = [[NSString alloc] initWithFormat:@"%ld", (long)age];
                    
                        self.tfEdad.text = edad;
                        appDelegate.edad = edad;
                    }];
                
                }
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}
@end
