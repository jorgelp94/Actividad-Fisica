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
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imagenPersona;
@property (weak, nonatomic) IBOutlet UITextField *tfNombre;
@property (weak, nonatomic) IBOutlet UITextField *tfMatricula;
@property (weak, nonatomic) IBOutlet UITextField *tfEstatura;
@property (weak, nonatomic) IBOutlet UITextField *tfPeso;
@property (weak, nonatomic) IBOutlet UITextField *tfFecha;

@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfGenero;

@property (weak, nonatomic) IBOutlet UIButton *botonCrear;
@property (strong, nonatomic) NSString *idUsuarioActual;
@property BOOL validate;

- (IBAction)preionoCancelar:(UIButton *)sender;
- (IBAction)presionoCrear:(UIButton *)sender;
- (IBAction)agregarImagen:(UIButton *)sender;

- (void) quitaTeclado;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UITextField *activeField;

@end
