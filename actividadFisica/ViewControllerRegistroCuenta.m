//
//  ViewControllerRegistroCuenta.m
//  actividadFisica
//
//  Created by Jorge Luis Perales on 21/03/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "ViewControllerRegistroCuenta.h"
#import "Usuario.h"

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

- (IBAction)preionoCancelar:(UIButton *)sender {
    
    // quitar pantalla y mandar a pantalla de login
}

- (IBAction)presionoCrear:(UIButton *)sender {
    
//    if ([self.tfNombre.text isEqualToString:@""] || [self.tfMatricula.text isEqualToString:@""] || [self.tfPassword.text isEqualToString:@""] || [self.tfPeso.text isEqualToString:@""] || [self.tfYear.text isEqualToString:@""] || [self.tfMes.text isEqualToString:@""] || [self.tfDia.text isEqualToString:@""] || [self.tfEstatura.text isEqualToString:@""]) {
//
//        NSString *mensaje = [[NSString alloc] initWithFormat:@"Llena todos los campos."];
//        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Error" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alerta show];
//        
//    } else {
        nuevoUsuario.nombreUsuario = self.tfNombre.text;
        nuevoUsuario.matriculaUsuario = self.tfMatricula.text;
        NSString *fecha = [[NSString alloc] initWithFormat:@"%@-%@-%@", self.tfDia.text, self.tfMes.text, self.tfYear.text];
        //NSLog(@"%@", fecha);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-mm-yyyy"];
        
        nuevoUsuario.fechaNacimientoUsuario = [dateFormatter dateFromString:fecha];
        float estatura = [self.tfEstatura.text floatValue];
        NSNumber *estatura2 = [[NSNumber alloc] initWithFloat:estatura];
        nuevoUsuario.estaturaUsuario = estatura2;
        float peso = [self.tfPeso.text floatValue];
        NSNumber *peso2 = [[NSNumber alloc] initWithFloat:peso];
        nuevoUsuario.pesoUsuario = peso2;
        nuevoUsuario.passwordUsuario = self.tfPassword.text;

//    }
    
    
}

- (IBAction)agregarImagen:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.imagenPersona.image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.imagenPersona.image];
//    imageView.layer.cornerRadius = self.imagenPersona.image.size.width / 2;
//    imageView.layer.masksToBounds = YES;
//    [self.view addSubview:imageView];
    UIImageWriteToSavedPhotosAlbum(self.imagenPersona.image, nil, nil, nil);
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

@end
