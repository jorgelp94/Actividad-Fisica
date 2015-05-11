//
//  ViewControllerDetailGrafica.m
//  actividadFisica
//
//  Created by Diego Aleman on 5/4/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "ViewControllerDetailGrafica.h"

@implementation ViewControllerDetailGrafica
-(void)viewDidLoad{
    
    /*
     *  Despliega datos que le paso ViewControllerGrafica para que usuario compare sus resultados
     */
    self.lblDatos.text = self.datos;
    self.navigationItem.title = @"Información Resultados";
}

@end
