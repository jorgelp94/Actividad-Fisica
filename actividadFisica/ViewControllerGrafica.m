//
//  ViewControllerGrafica.m
//  actividadFisica
//
//  Created by Diego Aleman on 4/29/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "ViewControllerGrafica.h"
#import "SecondViewController.h"
#import "AppDelegate.h"
#import "ViewControllerDetailGrafica.h"


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

    
    
    // Draw an average line
    self.myGraph.averageLine.enableAverageLine = YES;
    self.myGraph.averageLine.alpha = 0.6;
    self.myGraph.averageLine.color = [UIColor yellowColor];
    self.myGraph.averageLine.width = 2.5;
    self.myGraph.averageLine.dashPattern = @[@(2),@(2)];
     
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
 *  SEGUE
 */

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"envia"]) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSString *mensaje;
        /*
         *  LAGARTIJAS
         */
        if (self.segmentedControl.selectedSegmentIndex == 0){
            //HOMBRE
            if ([appDelegate.genero isEqualToString:@"Masculino"]){
                if ([appDelegate.edad integerValue] < 35){ // <35
                    mensaje = @"Excelente -> 60 \n Buena -> 45 \n Promedio -> 30 \n Deficiente -> 15";
                }
                else if([appDelegate.edad integerValue] > 34 && [appDelegate.edad integerValue] < 45) { // 35-44
                    mensaje = @"Excelente -> 50 \n Buena -> 40 \n Promedio -> 25 \n Deficiente -> 10";
                }
                else{ //>45
                    mensaje = @"Excelente -> 40 \n Buena -> 25 \n Promedio -> 15 \n Deficiente -> 5";
                }
            }
            //MUJER
            else{
                if ([appDelegate.edad integerValue] < 35){ // <35
                    mensaje = @"Excelente -> 50 \n Buena -> 40 \n Promedio -> 25 \n Deficiente -> 10";
                }
                else if([appDelegate.edad integerValue] > 34 && [appDelegate.edad integerValue] < 45) { // 35-44
                    mensaje = @"Excelente -> 40 \n Buena -> 25 \n Promedio -> 15 \n Deficiente -> 6";
                }
                else{ //>45
                    mensaje = @"Excelente -> 30 \n Buena -> 15 \n Promedio -> 10 \n Deficiente -> 4";
                }
            }
        }
        /*
         *  ABDOMINALES
         */
        else if (self.segmentedControl.selectedSegmentIndex == 1){
            //HOMBRE
            if ([appDelegate.genero isEqualToString:@"Masculino"]){
                if ([appDelegate.edad integerValue] < 30){ // <=29
                    mensaje = @"Excelente -> +54 \n Buena -> 45-54 \n Promedio -> 34-44 \n Mala -> 20-34\n Muy Mala -> <20";
                }
                else if([appDelegate.edad integerValue] > 29 && [appDelegate.edad integerValue] < 40){ // 30-39
                    mensaje = @"Excelente -> +44 \n Buena -> 35-34 \n Promedio -> 24-34 \n Mala -> 15-24\n Muy Mala -> <15";
                }
                else if([appDelegate.edad integerValue] > 39 && [appDelegate.edad integerValue] < 50){ // 40-49
                    mensaje = @"Excelente -> +39 \n Buena -> 30-39 \n Promedio -> 20-29 \n Mala -> 12-19\n Muy Mala -> <12";
                }
                else if([appDelegate.edad integerValue] > 49 && [appDelegate.edad integerValue] < 60){ // 50-59
                    mensaje = @"Excelente -> +34 \n Buena -> 25-34 \n Promedio -> 15-24 \n Mala -> 8-14\n Muy Mala -> <8";
                }
                else{ //+60
                    mensaje = @"Excelente -> +29 \n Buena -> 20-29 \n Promedio -> 10-19 \n Mala -> 5-9\n Muy Mala -> <5";
                }
            }
            //MUJER
            else{
                if ([appDelegate.edad integerValue] < 30){ // <=29
                    mensaje = @"Excelente -> +48 \n Buena -> 34-48 \n Promedio -> 17-33 \n Mala -> 6-16\n Muy Mala -> <6";
                }
                else if([appDelegate.edad integerValue] > 29 && [appDelegate.edad integerValue] < 40){ // 30-39
                    mensaje = @"Excelente -> +39 \n Buena -> 25-39 \n Promedio -> 12-24 \n Mala -> 4-11\n Muy Mala -> <4";
                }
                else if([appDelegate.edad integerValue] > 39 && [appDelegate.edad integerValue] < 50){ // 40-49
                    mensaje = @"Excelente -> +34 \n Buena -> 20-34 \n Promedio -> 8-19 \n Mala -> 3-7\n Muy Mala -> <3";
                }
                else if([appDelegate.edad integerValue] > 49 && [appDelegate.edad integerValue] < 60){ // 50-59
                    mensaje = @"Excelente -> +29 \n Buena -> 15-29 \n Promedio -> 6-14 \n Mala -> 2-5\n Muy Mala -> <2";
                }
                else{ //+60
                    mensaje = @"Excelente -> +19 \n Buena -> 5-19 \n Promedio -> 3-4 \n Mala -> 1-2\n Muy Mala -> <2";
                }
            }
        }
        /*
         *  MILLAS
         */
        else if (self.segmentedControl.selectedSegmentIndex == 2){
            //HOMBRE
            if ([appDelegate.genero isEqualToString:@"Masculino"]){
                if ([appDelegate.edad integerValue] < 30){ // <=29
                    mensaje = @"Excelente -> <11:54 \n Buena -> 11:54-13:00 \n Promedio -> 13:01-13:42 \n Mala -> 13:43-14:30\n Muy Mala -> +14:30";
                }
                else if ([appDelegate.edad integerValue] > 29 && [appDelegate.edad integerValue] < 40){
                    mensaje = @"Excelente -> <12:24 \n Buena -> 12:24-13:30 \n Promedio -> 13:31-14:12 \n Mala -> 14:13-15:00\n Muy Mala -> +15:00";
                }
                else if ([appDelegate.edad integerValue] > 39 && [appDelegate.edad integerValue] < 50){
                    mensaje = @"Excelente -> <12:54 \n Buena -> 12:54-14:00 \n Promedio -> 14:01-14:42 \n Mala -> 14:43-15:30\n Muy Mala -> +15:30";
                }
                else if ([appDelegate.edad integerValue] > 49 && [appDelegate.edad integerValue] < 60){
                    mensaje = @"Excelente -> <13:24 \n Buena -> 13:24-14:24 \n Promedio -> 14:25-15:12 \n Mala -> 15:13-16:30\n Muy Mala -> +16:30";
                }
                else if ([appDelegate.edad integerValue] > 59 && [appDelegate.edad integerValue] < 70){
                    mensaje = @"Excelente -> <14:06 \n Buena -> 14:06-15:12 \n Promedio -> 15:13-16:18 \n Mala -> 16:19-17:18\n Muy Mala -> +17:18";
                }
                else{ // +70
                    mensaje = @"Excelente -> <15:06 \n Buena -> 15:06-15:48 \n Promedio -> 15:49-18:48 \n Mala -> 18:49-20:18\n Muy Mala -> +20:18";
                }
            }
            //MUJER
            else{
                if ([appDelegate.edad integerValue] < 30){ // <=29
                    mensaje = @"Excelente -> <13:12 \n Buena -> 13:12-14:06 \n Promedio -> 14:07-15:06 \n Mala -> 15:07-16:30\n Muy Mala -> +16:30";
                }
                else if ([appDelegate.edad integerValue] > 29 && [appDelegate.edad integerValue] < 40){
                    mensaje = @"Excelente -> <13:42 \n Buena -> 13:42-14:36 \n Promedio -> 14:37-15:36 \n Mala -> 15:37-17:00\n Muy Mala -> +17:00";
                }
                else if ([appDelegate.edad integerValue] > 39 && [appDelegate.edad integerValue] < 50){
                    mensaje = @"Excelente -> <14:12 \n Buena -> 14:12-15:06 \n Promedio -> 15:07-16:06 \n Mala -> 16:07-17:30\n Muy Mala -> +17:30";
                }
                else if ([appDelegate.edad integerValue] > 49 && [appDelegate.edad integerValue] < 60){
                    mensaje = @"Excelente -> <14:42 \n Buena -> 14:42-15:36 \n Promedio -> 15:37-17:00 \n Mala -> 17:01-18:06\n Muy Mala -> +18:06";
                }
                else if ([appDelegate.edad integerValue] > 59 && [appDelegate.edad integerValue] < 70){
                    mensaje = @"Excelente -> <15:06 \n Buena -> 15:06-16:18 \n Promedio -> 16:19-17:30 \n Mala -> 17:31-19:12\n Muy Mala -> +19:12";
                }
                else{ // +70
                    mensaje = @"Excelente -> <18:18 \n Buena -> 18:18-20:00 \n Promedio -> 20:01-21:48 \n Mala -> 21:49-24:06\n Muy Mala -> +24:06";
                }
            }
        }
        /*
         *  ELASTICIDAD
         */
        else {
            mensaje = @"No hay datos para Elasticidad :(";
        }

        [[segue destinationViewController] setDatos:mensaje];
    }
}

/*
 *  GRAFICA
 */
- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return self.listaPruebas.count; // Number of points in the graph.
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //            self.myGraph.averageLine.yValue = 50.0;

    /*
     *  LAGARTIJAS
     */
    if (self.segmentedControl.selectedSegmentIndex == 0){
        //HOMBRE
        if ([appDelegate.genero isEqualToString:@"Masculino"]){
            if ([appDelegate.edad integerValue] < 35){ // <35
                self.myGraph.averageLine.yValue = 30.0;
            }
            else if([appDelegate.edad integerValue] > 34 && [appDelegate.edad integerValue] < 45) { // 35-44
                self.myGraph.averageLine.yValue = 25.0;
            }
            else{ //>45
                self.myGraph.averageLine.yValue = 15.0;
            }
        }
        //MUJER
        else{
            if ([appDelegate.edad integerValue] < 35){ // <35
                self.myGraph.averageLine.yValue = 25.0;
            }
            else if([appDelegate.edad integerValue] > 34 && [appDelegate.edad integerValue] < 45) { // 35-44
                self.myGraph.averageLine.yValue = 15.0;
            }
            else{ //>45
                self.myGraph.averageLine.yValue = 10.0;
            }
        }
        
        return [[[self.listaPruebas objectAtIndex:index] objectAtIndex:0]doubleValue];
        
    }
    /*
     *  ABDOMINALES
     */
    else if (self.segmentedControl.selectedSegmentIndex == 1){
        //HOMBRE
        if ([appDelegate.genero isEqualToString:@"Masculino"]){
            if ([appDelegate.edad integerValue] < 30){ // <=29
                self.myGraph.averageLine.yValue = 39.5;
            }
            else if([appDelegate.edad integerValue] > 29 && [appDelegate.edad integerValue] < 40){ // 30-39
                self.myGraph.averageLine.yValue = 29.0;
            }
            else if([appDelegate.edad integerValue] > 39 && [appDelegate.edad integerValue] < 50){ // 40-49
                self.myGraph.averageLine.yValue = 24.5;
            }
            else if([appDelegate.edad integerValue] > 49 && [appDelegate.edad integerValue] < 60){ // 50-59
                self.myGraph.averageLine.yValue = 19.5;
            }
            else{ //+60
                self.myGraph.averageLine.yValue = 14.5;
            }
        }
        //MUJER
        else{
            if ([appDelegate.edad integerValue] < 30){ // <=29
                self.myGraph.averageLine.yValue = 25.0;
            }
            else if([appDelegate.edad integerValue] > 29 && [appDelegate.edad integerValue] < 40){ // 30-39
                self.myGraph.averageLine.yValue = 18.0;
            }
            else if([appDelegate.edad integerValue] > 39 && [appDelegate.edad integerValue] < 50){ // 40-49
                self.myGraph.averageLine.yValue = 13.5;
            }
            else if([appDelegate.edad integerValue] > 49 && [appDelegate.edad integerValue] < 60){ // 50-59
                self.myGraph.averageLine.yValue = 10.0;
            }
            else{ //+60
                self.myGraph.averageLine.yValue = 3.5;
            }
        }

        
        return [[[self.listaPruebas objectAtIndex:index] objectAtIndex:1]doubleValue];

    }
    /*
     *  MILLAS
     */
    else if (self.segmentedControl.selectedSegmentIndex == 2){
        //HOMBRE
        if ([appDelegate.genero isEqualToString:@"Masculino"]){
            if ([appDelegate.edad integerValue] < 30){ // <=29
                self.myGraph.averageLine.yValue = 13.20;
            }
            else if ([appDelegate.edad integerValue] > 29 && [appDelegate.edad integerValue] < 40){
                self.myGraph.averageLine.yValue = 13.50;
            }
            else if ([appDelegate.edad integerValue] > 39 && [appDelegate.edad integerValue] < 50){
                self.myGraph.averageLine.yValue = 14.20;
            }
            else if ([appDelegate.edad integerValue] > 49 && [appDelegate.edad integerValue] < 60){
                self.myGraph.averageLine.yValue = 14.40;
            }
            else if ([appDelegate.edad integerValue] > 59 && [appDelegate.edad integerValue] < 70){
                self.myGraph.averageLine.yValue = 15.40;
            }
            else{ // +70
                self.myGraph.averageLine.yValue = 16.50;
            }
        }
        //MUJER
        else{
            if ([appDelegate.edad integerValue] < 30){ // <=29
                self.myGraph.averageLine.yValue = 14.30;
            }
            else if ([appDelegate.edad integerValue] > 29 && [appDelegate.edad integerValue] < 40){
                self.myGraph.averageLine.yValue = 15.0;
            }
            else if ([appDelegate.edad integerValue] > 39 && [appDelegate.edad integerValue] < 50){
                self.myGraph.averageLine.yValue = 15.30;
            }
            else if ([appDelegate.edad integerValue] > 49 && [appDelegate.edad integerValue] < 60){
                self.myGraph.averageLine.yValue = 16.15;
            }
            else if ([appDelegate.edad integerValue] > 59 && [appDelegate.edad integerValue] < 70){
                self.myGraph.averageLine.yValue = 17.0;
            }
            else{ // +70
                self.myGraph.averageLine.yValue = 20.50;
            }
        }
        return [[[self.listaPruebas objectAtIndex:index] objectAtIndex:2]doubleValue];
        
    }
    /*
     *  ELASTICIDAD
     */
    else {
        self.myGraph.averageLine.yValue = 18;
        
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
