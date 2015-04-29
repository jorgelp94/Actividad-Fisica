//
//  ViewControllerLogin.h
//  actividadFisica
//
//  Created by Jorge Luis Perales on 21/03/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerLogin : UIViewController

- (void) quitaTeclado;
@property (weak, nonatomic) IBOutlet UITextField *loginMatricula;
@property (weak, nonatomic) IBOutlet UITextField *loginPassword;
- (IBAction)presionoIniciarSesion:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *botonIniciar;

@end
