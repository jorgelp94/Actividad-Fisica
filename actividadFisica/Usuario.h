//
//  Usuario.h
//  actividadFisica
//
//  Created by Jorge Luis Perales on 21/03/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Usuario : NSObject

@property (strong, nonatomic) NSString *nombreUsuario;
@property (strong, nonatomic) NSString *matriculaUsuario;
@property (strong, nonatomic) NSDate *fechaNacimientoUsuario;
@property float estaturaUsuario;
@property float pesoUsuario;


@end
