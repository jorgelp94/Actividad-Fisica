//
//  ViewControllerDesempenoAlumno.h
//  actividadFisica
//
//  Created by Jorge Luis Perales on 03/05/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMSimpleLineGraphView.h"
@interface ViewControllerDesempenoAlumno : UIViewController <BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>

@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *myGraph;
@property NSMutableArray *pruebasAlumno;
@property NSMutableArray *listaPruebas;

@property NSArray *registro;

@property (weak, nonatomic) IBOutlet UILabel *lblDisplay;
@property (weak, nonatomic) IBOutlet UILabel *lblFecha;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)refresh:(UISegmentedControl *)sender;

@end
