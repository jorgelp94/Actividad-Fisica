//
//  ViewControllerRegistroCuenta.m
//  actividadFisica
//
//  Created by Jorge Luis Perales on 21/03/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "ViewControllerRegistroCuenta.h"
#import "Usuario.h"
#import <Parse/Parse.h>
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "AppDelegate.h"

@interface ViewControllerRegistroCuenta ()

@end

@implementation ViewControllerRegistroCuenta

Usuario *nuevoUsuario;

- (void) quitaTeclado {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitaTeclado)];
    [self.view addGestureRecognizer:tap];
    
    // La aplicación guarda la información cuando se cierra
    // Esta información se va cargar posteriormente en la vista para modificacion de información
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aplicacionTerminara:) name:UIApplicationDidEnterBackgroundNotification object:app];
    self.idUsuarioActual = @"";
    
    // Scroll
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWasShown:)
//                                                 name:UIKeyboardDidShowNotification object:nil];
    //Muestra el datePicker en lugar del teclado
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.tfFecha setInputView:datePicker];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SecondViewController *secondView = [segue destinationViewController];
    
    secondView.idSecondView = self.idUsuarioActual;
}
*/

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"principal"]) {
        if (self.validate == YES) {
            return YES;
        }
        else {
            return NO;
        }
    }
    else {
        return YES;
    }
    
}


- (IBAction)preionoCancelar:(UIButton *)sender {
    
    // quitar pantalla y mandar a pantalla de login
}

- (IBAction)presionoCrear:(UIButton *)sender {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
        if ([self.tfNombre.text isEqualToString:@""] || [self.tfMatricula.text isEqualToString:@""] || [self.tfPassword.text isEqualToString:@""] || [self.tfPeso.text isEqualToString:@""]|| [self.tfFecha.text isEqualToString:@""] || [self.tfEstatura.text isEqualToString:@""]) {
    
            NSString *mensaje = [[NSString alloc] initWithFormat:@"Llena todos los campos."];
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Error" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alerta show];
            self.validate = NO;
            
    
        }
    
        else {
            PFObject *usuario = [PFObject objectWithClassName:@"Usuario"];
            
            // Validar matricula uq no exista una igual en la base de datos
            PFQuery *query = [PFQuery queryWithClassName:@"Usuario"];
            [query whereKey:@"matricula" equalTo:self.tfMatricula.text];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    NSLog(@"%lu registries", objects.count);
                    if (objects.count == 0) {
                        usuario[@"matricula"] = self.tfMatricula.text;
                        appDelegate.matriculaGeneral = self.tfMatricula.text;
                        usuario[@"nombre"] = self.tfNombre.text;
                        usuario[@"password"] = self.tfPassword.text;
                        
                        
                        usuario[@"fecha"] = self.tfFecha.text; // Puede guardarse como tipo fecha
                        usuario[@"peso"] = self.tfPeso.text;
                        usuario[@"estatura"] = self.tfEstatura.text;
                        
                        [usuario save];
                        
                        self.idUsuarioActual = usuario.objectId; // Id del objeto creado que se necesita enviar al siguiente view para obtener la información
                        
                        [usuario saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            if (succeeded) {
                                NSString *mensaje = [[NSString alloc] initWithFormat:@"El usuario se registró correctamente."];
                                UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Registro" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                [alerta show];
                            }
                            else {
                                NSString *mensaje = [[NSString alloc] initWithFormat:@"El usuario no se registró correctamente."];
                                UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Error" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                [alerta show];
                            }
                        }];
                        
                        appDelegate.generalID = usuario.objectId;
                        
                        self.validate = YES;
                    }
                    else {
                        NSString *mensaje = [[NSString alloc] initWithFormat:@"Ya está registrada esa matrícula. Por favor regresa e inicia sesión."];
                        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Error" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alerta show];
                        self.validate = NO;
                    }
                }
            }];
        }
}

- (IBAction)agregarImagen:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.imagenPersona.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"archivoDatos.plist"];
}

- (void) aplicacionTerminara:(NSNotification *)notification {
    NSMutableArray *listaDatos = [[NSMutableArray alloc] init];
    
    [listaDatos addObject:nuevoUsuario.matriculaUsuario];
    [listaDatos addObject:nuevoUsuario.passwordUsuario];
    [listaDatos addObject:nuevoUsuario.nombreUsuario];
    [listaDatos addObject:nuevoUsuario.fechaNacimientoUsuario];
    [listaDatos addObject:nuevoUsuario.estaturaUsuario];
    [listaDatos addObject:nuevoUsuario.pesoUsuario];
    
    [listaDatos writeToFile:[self dataFilePath] atomically:YES];
}

//// Called when the UIKeyboardDidShowNotification is sent.
//- (void)keyboardWasShown:(NSNotification*)aNotification
//{
//    NSDictionary* info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    [self.scrollView setContentOffset:CGPointMake(0, kbSize.height) animated:YES];
//}
////called when the text field is being edited
//- (IBAction)textFieldDidBeginEditing:(UITextField *)sender {
//    sender.delegate = self;
//}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.tfFecha.inputView;
    //    UIDatePicker *picker;
    //    picker.datePickerMode = UIDatePickerModeDate;
    NSDate *fecha = picker.date;
    NSString *fechaMostrar = [[NSString alloc] init];
    NSDateFormatter *formatoFecha = [[NSDateFormatter alloc] init];
    
    [formatoFecha setDateFormat:@"dd-MMM-YYYY"];
    
    fechaMostrar = [formatoFecha stringFromDate:fecha];
    
    self.tfFecha.text = fechaMostrar;
}


@end
