//
//  ViewControllerEditarAjustes.m
//  actividadFisica
//
//  Created by Jorge Luis Perales on 21/03/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "ViewControllerEditarAjustes.h"
#import "SecondViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface ViewControllerEditarAjustes ()

@end

@implementation ViewControllerEditarAjustes

- (void) quitaTeclado {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Gestura para quitar el teclado de la pantalla al dar tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitaTeclado)];
    [self.view addGestureRecognizer:tap];
    
    // Inicializa los objetos con la información obtenida de SecondViewController
    self.imagenEditarAjustes.image = self.imagenEd;
    self.tfEditarPeso.text = self.pesoEd;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender == self.botonGuardar) {
        SecondViewController *secondView = [segue destinationViewController];
        // Envía la imagen y el peso que se editaron
        secondView.pesoAj = self.tfEditarPeso.text;
        secondView.imagenAj = self.imagenEditarAjustes.image;
        
        AppDelegate *appDelegateEditar = [[UIApplication sharedApplication] delegate];
        
        //Actualiza el peso en la base de datos
        PFQuery *query = [PFQuery queryWithClassName:@"Usuario"];
        [query whereKey:@"objectId" equalTo:appDelegateEditar.generalID];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                [object setObject:self.tfEditarPeso.text forKey:@"peso"];
                [object saveInBackground];
            }
            else {
                NSLog(@"Error: %@", error);
            }
        }];
    }
}

//Funcion para cambiar la imagen
- (IBAction)cambiarImagen:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.imagenEditarAjustes.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
