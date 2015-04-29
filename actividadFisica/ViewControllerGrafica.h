//
//  ViewControllerGrafica.h
//  actividadFisica
//
//  Created by Diego Aleman on 4/29/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMSimpleLineGraphView.h"

@interface ViewControllerGrafica : UIViewController <BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>
@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *myGraph;
@property (strong, nonatomic) NSArray *arrayOfValues;
@property (weak, nonatomic) IBOutlet UILabel *lblDisplay;
@property NSMutableArray *listaPruebas;
@end
