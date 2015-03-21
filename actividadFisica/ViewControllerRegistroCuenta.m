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
    nuevoUsuario.nombreUsuario = self.tfNombre.text;
    nuevoUsuario.matriculaUsuario = self.tfMatricula.text;
    NSString *fecha = [[NSString alloc] initWithFormat:@"%@-%@-%@", self.tfDia.text, self.tfMes.text, self.tfYear.text];
    //NSLog(@"%@", fecha);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-mm-yyyy"];
    
    nuevoUsuario.fechaNacimientoUsuario = [dateFormatter dateFromString:fecha];
    nuevoUsuario.estaturaUsuario = [self.tfEstatura.text floatValue];
    nuevoUsuario.pesoUsuario = [self.tfPeso.text floatValue];
    
    // quitar pantalla y pasar a la tabbed view
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

@end
