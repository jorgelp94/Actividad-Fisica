//
//  ViewControllerDetailGrafica.h
//  actividadFisica
//
//  Created by Diego Aleman on 5/4/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerDetailGrafica : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblDatos; // donde despliega informacion
@property NSString *datos;  // datos pasados
@end
