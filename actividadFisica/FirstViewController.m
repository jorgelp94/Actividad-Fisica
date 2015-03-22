//
//  FirstViewController.m
//  actividadFisica
//
//  Created by Jorge Luis Perales on 21/03/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "FirstViewController.h"
#import "ViewControllerEditarPruebas.h"

@interface FirstViewController ()

@end

@implementation FirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindEditarRegistro:(UIStoryboardSegue *)segue {
    // falta recibir y desplegar informacion
    self.tfVerAbdominales.text = self.abdomin;
    self.tfVerLagartijas.text = self.lag;
    self.tfVerFlexibilidad.text = self.fl;
    self.tfVerMilla.text = self.mill;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ViewControllerEditarPruebas *viewPruebasEdit = [segue destinationViewController];
    
    viewPruebasEdit.abs = self.tfVerAbdominales.text;
    viewPruebasEdit.lagar = self.tfVerLagartijas.text;
    viewPruebasEdit.milla = self.tfVerMilla.text;
    viewPruebasEdit.flex = self.tfVerFlexibilidad.text;
}

@end
