//
//  ViewControllerAgregar.h
//  actividadFisica
//
//  Created by Diego Aleman on 4/29/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerAgregar : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *tfLag;
@property (weak, nonatomic) IBOutlet UITextField *tfAbd;
@property (weak, nonatomic) IBOutlet UITextField *tfMilla;
@property (weak, nonatomic) IBOutlet UITextField *tfElast;
@property (weak, nonatomic) IBOutlet UIButton *btnGuardar;

@end
