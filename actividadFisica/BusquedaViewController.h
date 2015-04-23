//
//  BusquedaViewController.h
//  actividadFisica
//
//  Created by Jorge Luis Perales on 22/04/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusquedaViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *buscaMatricula;
@property (weak, nonatomic) IBOutlet UITextField *tfNombre;
@property (weak, nonatomic) IBOutlet UITextField *tfMatricula;
@property (weak, nonatomic) IBOutlet UITextField *tfEdad;
@property (weak, nonatomic) IBOutlet UITextField *tfPeso;
@property (weak, nonatomic) IBOutlet UITextField *tfEstatura;
- (IBAction)presionoBuscar:(UIButton *)sender;

@end
