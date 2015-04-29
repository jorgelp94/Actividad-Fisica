//
//  ViewControllerAgregar.m
//  actividadFisica
//
//  Created by Diego Aleman on 4/29/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "ViewControllerAgregar.h"
#import "MasterViewController.h"

@interface ViewControllerAgregar ()

@end

@implementation ViewControllerAgregar

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //MasterViewController *viewIni = [segue destinationViewController];
    MasterViewController *view = [segue destinationViewController];
    NSDate *fechaHoy = [[NSDate alloc] init];
    NSArray *arreglo = [[NSArray alloc]initWithObjects:self.tfLag.text,self.tfAbd.text, self.tfMilla.text, self.tfElast.text, fechaHoy,nil];
    view.arregloRegistro = arreglo;
}

@end
