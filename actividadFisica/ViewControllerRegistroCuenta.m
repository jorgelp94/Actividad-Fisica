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
@property NSArray *genero;
@property NSMutableArray *peso;
@property (strong, nonatomic) UIPickerView *genderPicker;
@property (strong, nonatomic) UIPickerView *weigthPicker;

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
    
    [self registerForKeyboardNotifications];
    
    // La aplicación guarda la información cuando se cierra
    // Esta información se va cargar posteriormente en la vista para modificacion de información
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aplicacionTerminara:) name:UIApplicationDidEnterBackgroundNotification object:app];
    self.idUsuarioActual = @"";
    

    //Muestra el datePicker en lugar del teclado
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.tfFecha setInputView:datePicker];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    // Inicialización de arreglos
    self.genero = [[NSArray alloc] initWithObjects:@"Masculino",@"Femenino", nil];
    self.peso = [[NSMutableArray alloc] init];
    for (NSInteger i = 30; i <= 120; i++) {
        NSString *dato = [[NSString alloc] initWithFormat:@"%ld", (long)i];
        [self.peso addObject:dato];
    }
    
    //Picker género
    self.genderPicker = [[UIPickerView alloc] init];
    self.genderPicker.delegate = self;
    self.genderPicker.dataSource =  self;
    [self.genderPicker setShowsSelectionIndicator:YES];
    self.tfGenero.inputView = self.genderPicker;
    
    //Picker peso
    self.weigthPicker = [[UIPickerView alloc] init];
    self.weigthPicker.delegate = self;
    self.weigthPicker.dataSource = self;
    [self.weigthPicker setShowsSelectionIndicator:YES];
    self.tfPeso.inputView = self.weigthPicker;
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
    
        if ([self.tfNombre.text isEqualToString:@""] || [self.tfMatricula.text isEqualToString:@""] || [self.tfPassword.text isEqualToString:@""] || [self.tfPeso.text isEqualToString:@""]|| [self.tfFecha.text isEqualToString:@""] || [self.tfEstatura.text isEqualToString:@""] || [self.tfGenero.text isEqualToString:@""]) {
    
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
                        usuario[@"genero"] = self.tfGenero.text;
                        
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


-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.tfFecha.inputView;
    //    UIDatePicker *picker;
    //    picker.datePickerMode = UIDatePickerModeDate;
    NSDate *fecha = picker.date;
    NSString *fechaMostrar = [[NSString alloc] init];
    NSDateFormatter *formatoFecha = [[NSDateFormatter alloc] init];
    
    [formatoFecha setDateFormat:@"dd-MM-YYYY"];
    
    fechaMostrar = [formatoFecha stringFromDate:fecha];
    
    self.tfFecha.text = fechaMostrar;
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect bkgndRect = self.activeField.superview.frame;
    bkgndRect.size.height += kbSize.height;
    [self.activeField.superview setFrame:bkgndRect];
    [self.scrollView setContentOffset:CGPointMake(0.0, self.activeField.frame.origin.y-kbSize.height) animated:YES];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect bkgndRect = self.activeField.superview.frame;
    bkgndRect.size.height -= kbSize.height;
    [self.activeField.superview setFrame:bkgndRect];
    [self.scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == self.genderPicker) {
        return self.genero[row];
    } else {
        return self.peso[row];
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == self.genderPicker) {
        return 1;
    } else {
        return 1;
    }
    
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.genderPicker) {
        return self.genero.count;
    } else {
        return self.peso.count;
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.genderPicker) {
        NSInteger val1 = [pickerView selectedRowInComponent:0];
        //NSInteger val2 = [pickerView selectedRowInComponent:1];
        NSString *value = [[NSString alloc] initWithFormat:@"%@", self.genero[val1]];
        self.tfGenero.text = value;
    } else {
        NSInteger val1 = [pickerView selectedRowInComponent:0];
        NSString *value = [[NSString alloc] initWithFormat:@"%@",self.peso[val1]];
        self.tfPeso.text = value;
    }
    
}


@end
