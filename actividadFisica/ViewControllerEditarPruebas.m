//
//  ViewControllerEditarPruebas.m
//  actividadFisica
//
//  Created by Jorge Luis Perales on 21/03/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "ViewControllerEditarPruebas.h"
#import "FirstViewController.h"

@interface ViewControllerEditarPruebas ()

@end

@implementation ViewControllerEditarPruebas

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FirstViewController *viewFirst = [segue destinationViewController];
    
    if (sender == self.botonGuardar) {
        viewFirst.tfVerAbdominales.text = self.tfEditaAbdominales.text;
        viewFirst.tfVerLagartijas.text = self.tfEditaLagartijas.text;
        viewFirst.tfVerMilla.text = self.tfEditaMilla.text;
        viewFirst.tfVerFlexibilidad.text = self.tfEditaFlexibilidad.text;
    }
}

@end
