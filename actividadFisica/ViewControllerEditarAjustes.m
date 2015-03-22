//
//  ViewControllerEditarAjustes.m
//  actividadFisica
//
//  Created by Jorge Luis Perales on 21/03/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "ViewControllerEditarAjustes.h"
#import "SecondViewController.h"

@interface ViewControllerEditarAjustes ()

@end

@implementation ViewControllerEditarAjustes

- (void) quitaTeclado {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitaTeclado)];
    [self.view addGestureRecognizer:tap];
    
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
        
        secondView.pesoAj = self.tfEditarPeso.text;
        secondView.imagenAj = self.imagenEditarAjustes.image;
    }
}


- (IBAction)cambiarImagen:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.imagenEditarAjustes.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.imagenPersona.image];
    //    imageView.layer.cornerRadius = self.imagenPersona.image.size.width / 2;
    //    imageView.layer.masksToBounds = YES;
    //    [self.view addSubview:imageView];
    UIImageWriteToSavedPhotosAlbum(self.imagenEditarAjustes.image, nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
