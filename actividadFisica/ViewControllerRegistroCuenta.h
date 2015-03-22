//
//  ViewControllerRegistroCuenta.h
//  actividadFisica
//
//  Created by Jorge Luis Perales on 21/03/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Usuario.h"

@interface ViewControllerRegistroCuenta : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imagenPersona;
@property (weak, nonatomic) IBOutlet UITextField *tfNombre;
@property (weak, nonatomic) IBOutlet UITextField *tfMatricula;
@property (weak, nonatomic) IBOutlet UITextField *tfEstatura;
@property (weak, nonatomic) IBOutlet UITextField *tfPeso;
@property (weak, nonatomic) IBOutlet UITextField *tfDia;
@property (weak, nonatomic) IBOutlet UITextField *tfMes;
@property (weak, nonatomic) IBOutlet UITextField *tfYear;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;

@property (weak, nonatomic) IBOutlet UIButton *botonCrear;

- (IBAction)preionoCancelar:(UIButton *)sender;
- (IBAction)presionoCrear:(UIButton *)sender;
- (IBAction)agregarImagen:(UIButton *)sender;

- (void) quitaTeclado;

@end
