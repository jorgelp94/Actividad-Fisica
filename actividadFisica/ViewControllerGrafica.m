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
    
    self.navigationItem.title = @"Progreso";

    NSString *filePath = [self dataFilePath];
    if	([[NSFileManager defaultManager] fileExistsAtPath: filePath]){
        self.listaPruebas	=	[	[NSMutableArray alloc]	initWithContentsOfFile:	filePath];
        //self.listaPruebas = [[NSMutableArray alloc]init];
        //[self.listaPruebas setArray:array];
    }
    else{
        self.listaPruebas = [[NSMutableArray alloc]init];
    }
    
    /*
     *  Configuracion de la grafica
     */
    self.myGraph.animationGraphEntranceTime = 1;
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

/*
 *  Obtiene el path de los datos dentro del iPhone
 */
-(NSString *) dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex: 0];
    NSLog(@"%@",[documentsDirectory stringByAppendingPathComponent:@"archivoDatos.plist"]);
    return	[documentsDirectory stringByAppendingPathComponent:@"archivoDatos.plist"];
}

/*
 *  SEGUE - lo que envia a ViewControllerDetailGrafica para que usuari compare resultados
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
                    mensaje = @"Excelente -> 60 \nBuena -> 45 \nPromedio -> 30 \nDeficiente -> 15";
                }
                else if([appDelegate.edad integerValue] > 34 && [appDelegate.edad integerValue] < 45) { // 35-44
                    mensaje = @"Excelente -> 50 \nBuena -> 40 \nPromedio -> 25 \nDeficiente -> 10";
                }
                else{ //>45
                    mensaje = @"Excelente -> 40 \nBuena -> 25 \nPromedio -> 15 \nDeficiente -> 5";
                }
            }
            //MUJER
            else{
                if ([appDelegate.edad integerValue] < 35){ // <35
                    mensaje = @"Excelente -> 50 \nBuena -> 40 \nPromedio -> 25 \nDeficiente -> 10";
                }
                else if([appDelegate.edad integerValue] > 34 && [appDelegate.edad integerValue] < 45) { // 35-44
                    mensaje = @"Excelente -> 40 \nBuena -> 25 \nPromedio -> 15 \nDeficiente -> 6";
                }
                else{ //>45
                    mensaje = @"Excelente -> 30 \nBuena -> 15 \nPromedio -> 10 \nDeficiente -> 4";
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
                    mensaje = @"Excelente -> +54 \nBuena -> 45-54 \nPromedio -> 34-44 \nMala -> 20-34\nMuy Mala -> <20";
                }
                else if([appDelegate.edad integerValue] > 29 && [appDelegate.edad integerValue] < 40){ // 30-39
                    mensaje = @"Excelente -> +44 \nBuena -> 35-34 \nPromedio -> 24-34 \nMala -> 15-24\nMuy Mala -> <15";
                }
                else if([appDelegate.edad integerValue] > 39 && [appDelegate.edad integerValue] < 50){ // 40-49
                    mensaje = @"Excelente -> +39 \nBuena -> 30-39 \nPromedio -> 20-29 \nMala -> 12-19\n uy Mala -> <12";
                }
                else if([appDelegate.edad integerValue] > 49 && [appDelegate.edad integerValue] < 60){ // 50-59
                    mensaje = @"Excelente -> +34 \nBuena -> 25-34 \nPromedio -> 15-24 \nMala -> 8-14\nMuy Mala -> <8";
                }
                else{ //+60
                    mensaje = @"Excelente -> +29 \nBuena -> 20-29 \nPromedio -> 10-19 \nMala -> 5-9\nMuy Mala -> <5";
                }
            }
            //MUJER
            else{
                if ([appDelegate.edad integerValue] < 30){ // <=29
                    mensaje = @"Excelente -> +48 \nBuena -> 34-48 \nPromedio -> 17-33 \nMala -> 6-16\nMuy Mala -> <6";
                }
                else if([appDelegate.edad integerValue] > 29 && [appDelegate.edad integerValue] < 40){ // 30-39
                    mensaje = @"Excelente -> +39 \nBuena -> 25-39 \nPromedio -> 12-24 \nMala -> 4-11\nMuy Mala -> <4";
                }
                else if([appDelegate.edad integerValue] > 39 && [appDelegate.edad integerValue] < 50){ // 40-49
                    mensaje = @"Excelente -> +34 \nBuena -> 20-34 \nPromedio -> 8-19 \nMala -> 3-7\nMuy Mala -> <3";
                }
                else if([appDelegate.edad integerValue] > 49 && [appDelegate.edad integerValue] < 60){ // 50-59
                    mensaje = @"Excelente -> +29 \nBuena -> 15-29 \nPromedio -> 6-14 \nMala -> 2-5\nMuy Mala -> <2";
                }
                else{ //+60
                    mensaje = @"Excelente -> +19 \nBuena -> 5-19 \nPromedio -> 3-4 \nMala -> 1-2\nMuy Mala -> <2";
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
                    mensaje = @"Excelente -> <11:54 \nBuena -> 11:54-13:00 \nPromedio -> 13:01-13:42 \nMala -> 13:43-14:30\nMuy Mala -> +14:30";
                }
                else if ([appDelegate.edad integerValue] > 29 && [appDelegate.edad integerValue] < 40){
                    mensaje = @"Excelente -> <12:24 \nBuena -> 12:24-13:30 \nPromedio -> 13:31-14:12 \nMala -> 14:13-15:00\nMuy Mala -> +15:00";
                }
                else if ([appDelegate.edad integerValue] > 39 && [appDelegate.edad integerValue] < 50){
                    mensaje = @"Excelente -> <12:54 \nBuena -> 12:54-14:00 \nPromedio -> 14:01-14:42 \nMala -> 14:43-15:30\nMuy Mala -> +15:30";
                }
                else if ([appDelegate.edad integerValue] > 49 && [appDelegate.edad integerValue] < 60){
                    mensaje = @"Excelente -> <13:24 \nBuena -> 13:24-14:24 \nPromedio -> 14:25-15:12 \nMala -> 15:13-16:30\nMuy Mala -> +16:30";
                }
                else if ([appDelegate.edad integerValue] > 59 && [appDelegate.edad integerValue] < 70){
                    mensaje = @"Excelente -> <14:06 \nBuena -> 14:06-15:12 \nPromedio -> 15:13-16:18 \nMala -> 16:19-17:18\nMuy Mala -> +17:18";
                }
                else{ // +70
                    mensaje = @"Excelente -> <15:06 \nBuena -> 15:06-15:48 \nPromedio -> 15:49-18:48 \nMala -> 18:49-20:18\nMuy Mala -> +20:18";
                }
            }
            //MUJER
            else{
                if ([appDelegate.edad integerValue] < 30){ // <=29
                    mensaje = @"Excelente -> <13:12 \nBuena -> 13:12-14:06 \nPromedio -> 14:07-15:06 \nMala -> 15:07-16:30\nMuy Mala -> +16:30";
                }
                else if ([appDelegate.edad integerValue] > 29 && [appDelegate.edad integerValue] < 40){
                    mensaje = @"Excelente -> <13:42 \nBuena -> 13:42-14:36 \nPromedio -> 14:37-15:36 \nMala -> 15:37-17:00\nMuy Mala -> +17:00";
                }
                else if ([appDelegate.edad integerValue] > 39 && [appDelegate.edad integerValue] < 50){
                    mensaje = @"Excelente -> <14:12 \nBuena -> 14:12-15:06 \nPromedio -> 15:07-16:06 \nMala -> 16:07-17:30\nMuy Mala -> +17:30";
                }
                else if ([appDelegate.edad integerValue] > 49 && [appDelegate.edad integerValue] < 60){
                    mensaje = @"Excelente -> <14:42 \nBuena -> 14:42-15:36 \nPromedio -> 15:37-17:00 \nMala -> 17:01-18:06\nMuy Mala -> +18:06";
                }
                else if ([appDelegate.edad integerValue] > 59 && [appDelegate.edad integerValue] < 70){
                    mensaje = @"Excelente -> <15:06 \nBuena -> 15:06-16:18 \nPromedio -> 16:19-17:30 \nMala -> 17:31-19:12\nMuy Mala -> +19:12";
                }
                else{ // +70
                    mensaje = @"Excelente -> <18:18 \nBuena -> 18:18-20:00 \nPromedio -> 20:01-21:48 \nMala -> 21:49-24:06\nMuy Mala -> +24:06";
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
 *  GRAFICA - cantidad de muntos en la grafica
 */
- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return self.listaPruebas.count; // Number of points in the graph.
}

/*
 *  GRAFICA - pone los puntos y las lineas promedio de cada vista
 */
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

/*
 *  GRAFICA - string que va en parte inferior de la grafica
 */
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

/*
 *  GRAFICA - para que cuando el usuario toque alguna parte de la grafica desplegar resultado mas cercano
 */
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

/*
 *  GRAFICA - cuando no este tocando la grafica
 */
- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
    self.lblDisplay.text = @"---";
    self.lblFecha.text = @"--";
}




- (IBAction)refresh:(UISegmentedControl *)sender {
    [self.myGraph reloadGraph];
}
@end
