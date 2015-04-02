//
//  ViewControllerLogin.m
//  actividadFisica
//
//  Created by Jorge Luis Perales on 21/03/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "ViewControllerLogin.h"
#import <Parse/Parse.h>

@interface ViewControllerLogin ()

@end

@implementation ViewControllerLogin

- (void) quitaTeclado {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitaTeclado)];
    [self.view addGestureRecognizer:tap];
    self.sendSegue = NO;
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
    
    NSString *mat = [[NSString alloc] initWithFormat:@"%@", self.loginMatricula.text];
    NSString *pas = [[NSString alloc] initWithFormat:@"%@", self.loginPassword.text];
    PFQuery *query = [PFQuery queryWithClassName:@"Usuario"];
    [query whereKey:@"matricula" equalTo:mat];
    [query whereKey:@"password" equalTo:pas];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        NSLog(@"%@", object.objectId);
        if (!object) {
            NSString *mensaje = [[NSString alloc] initWithFormat:@"El usuario y/o contraseña son incorrectos."];
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Error" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alerta show];
            
            self.sendSegue = NO;
        }
        else {
            NSString *mensaje = [[NSString alloc] initWithFormat:@"Inicio de sesión exitoso."];
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Login" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alerta show];
            self.sendSegue = YES;
        }
    }];
    
    //[self shouldPerformSegueWithIdentifier:@"success" sender:sender];
}

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    //[self presionoIniciarSesion:self.botonIniciar];
    if ([identifier  isEqual: @"cuenta"]) {
        return YES;
    }
    if (self.sendSegue == YES) {
        return YES;
    }
    else {
        return NO;
    }
}

@end
