//
//  ViewControllerGrafica.m
//  actividadFisica
//
//  Created by Diego Aleman on 4/29/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "ViewControllerGrafica.h"


@implementation ViewControllerGrafica

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *filePath = [self dataFilePath];
    if	([[NSFileManager defaultManager] fileExistsAtPath: filePath]){
        self.listaPruebas	=	[	[NSMutableArray alloc]	initWithContentsOfFile:	filePath];
        //self.listaPruebas = [[NSMutableArray alloc]init];
        //[self.listaPruebas setArray:array];
    }
    else{
        self.listaPruebas = [[NSMutableArray alloc]init];
    }
    
    self.myGraph.animationGraphEntranceTime = 3; // la animacion de la grafica dura 3 segundos
    self.myGraph.enablePopUpReport = YES;
    self.myGraph.enableTouchReport = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *) dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex: 0];
    NSLog(@"%@",[documentsDirectory stringByAppendingPathComponent:@"archivoDatos.plist"]);
    return	[documentsDirectory stringByAppendingPathComponent:@"archivoDatos.plist"];
}


/*
 *  GRAFICA
 */
- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return self.listaPruebas.count; // Number of points in the graph.
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    return [[[self.listaPruebas objectAtIndex:index] objectAtIndex:0]doubleValue]; // The value of the point on the Y-Axis for the index.
}


- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index{
    
    if ((index % 2) == 1){
        NSArray *object = [self.listaPruebas objectAtIndex:index];
        NSDateFormatter *formatoFecha = [[NSDateFormatter alloc ]init];
        [formatoFecha setDateStyle: NSDateFormatterShortStyle];
        NSString *stringFormateado = [formatoFecha stringFromDate:[object objectAtIndex:4]];
        
        return stringFormateado;
    }
    else{
        return @"";
    }
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
    self.lblDisplay.text = [[self.listaPruebas objectAtIndex:index] objectAtIndex:0];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
    self.lblDisplay.text = @"---";
}




@end
