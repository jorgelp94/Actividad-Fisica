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
    
    self.myGraph.animationGraphEntranceTime = 1; // la animacion de la grafica dura 3 segundos
    self.myGraph.enablePopUpReport = YES;
    self.myGraph.enableTouchReport = YES;
    self.myGraph.enableReferenceXAxisLines = YES;
    self.myGraph.enableReferenceYAxisLines = YES;

    /*
    
    // Draw an average line
    self.myGraph.averageLine.enableAverageLine = YES;
    self.myGraph.averageLine.alpha = 0.6;
    self.myGraph.averageLine.color = [UIColor darkGrayColor];
    self.myGraph.averageLine.width = 2.5;
    self.myGraph.averageLine.dashPattern = @[@(2),@(2)];
    self.myGraph.averageLine.yValue = 4.5;
     */
     
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
    if (self.segmentedControl.selectedSegmentIndex == 0){
        return [[[self.listaPruebas objectAtIndex:index] objectAtIndex:0]doubleValue];
        
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1){
        return [[[self.listaPruebas objectAtIndex:index] objectAtIndex:1]doubleValue];

    }
    else if (self.segmentedControl.selectedSegmentIndex == 2){
        return [[[self.listaPruebas objectAtIndex:index] objectAtIndex:2]doubleValue];
        
    }
    else {
        return [[[self.listaPruebas objectAtIndex:index] objectAtIndex:3]doubleValue];
    }
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
    if (self.segmentedControl.selectedSegmentIndex == 0){
        self.lblDisplay.text = [[self.listaPruebas objectAtIndex:index] objectAtIndex:0];

    }
    else if (self.segmentedControl.selectedSegmentIndex == 1){
        self.lblDisplay.text = [[self.listaPruebas objectAtIndex:index] objectAtIndex:1];
    }
    else if (self.segmentedControl.selectedSegmentIndex == 2){
        self.lblDisplay.text = [[self.listaPruebas objectAtIndex:index] objectAtIndex:2];
        
    }
    else if (self.segmentedControl.selectedSegmentIndex == 3){
        self.lblDisplay.text = [[self.listaPruebas objectAtIndex:index] objectAtIndex:3];
    }
    
    NSDateFormatter *formatoFecha = [[NSDateFormatter alloc ]init];
    [formatoFecha setDateStyle: NSDateFormatterMediumStyle];
    NSString *stringFormateado = [formatoFecha stringFromDate:[[self.listaPruebas objectAtIndex:index] objectAtIndex:4]];
    self.lblFecha.text = stringFormateado;
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
    self.lblDisplay.text = @"---";
    self.lblFecha.text = @"--";
}




- (IBAction)refresh:(UISegmentedControl *)sender {
    [self.myGraph reloadGraph];
}
@end
