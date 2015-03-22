//
//  ViewControllerEditarAjustes.h
//  actividadFisica
//
//  Created by Jorge Luis Perales on 21/03/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerEditarAjustes : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imagenEditarAjustes;
@property (weak, nonatomic) IBOutlet UITextField *tfEditarPeso;
- (IBAction)cambiarImagen:(UIButton *)sender;

@property (strong, nonatomic) NSString *pesoEd;
@property (strong, nonatomic) UIImage *imagenEd;
@property (weak, nonatomic) IBOutlet UIButton *botonGuardar;

@end
