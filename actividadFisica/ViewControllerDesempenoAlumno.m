//
//  ViewControllerDesempenoAlumno.m
//  actividadFisica
//
//  Created by Jorge Luis Perales on 03/05/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "ViewControllerDesempenoAlumno.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"


@implementation ViewControllerDesempenoAlumno

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pruebasAlumno = [[NSMutableArray alloc]init];
    self.listaPruebas = [[NSMutableArray alloc]init];
    
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

-(void)viewDidAppear:(BOOL)animated{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //appDelegate.busqueda;
    [self.listaPruebas removeAllObjects];
    
    if (appDelegate.busqueda) {
        PFQuery *query = [PFQuery queryWithClassName:@"Pruebas"];
        [query whereKey:@"matricula" equalTo:appDelegate.busqueda];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
                // Do something with the found objects
                for (PFObject *object in objects) {
                    self.registro = [[NSArray alloc] initWithObjects:object[@"lagartijas"], object[@"abdominales"], object[@"milla"], object[@"flexibilidad"], object[@"fecha"], nil];
                    [self.listaPruebas addObject:self.registro];
                    NSLog(@"%@", self.registro);
                }
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
        
        [self.myGraph reloadGraph];
    }
    else {
        NSString *mensaje = [[NSString alloc] initWithFormat:@"Ingresa una matrícula primero"];
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alerta show];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
