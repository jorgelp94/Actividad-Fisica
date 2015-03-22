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

- (void) quitaTeclado {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitaTeclado)];
    [self.view addGestureRecognizer:tap];
    
    self.tfEditaAbdominales.text = self.abs;
    self.tfEditaLagartijas.text = self.lagar;
    self.tfEditaMilla.text = self.milla;
    self.tfEditaFlexibilidad.text = self.flex;
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
        viewFirst.abdomin = self.tfEditaAbdominales.text;
        viewFirst.lag = self.tfEditaLagartijas.text;
        viewFirst.mill = self.tfEditaMilla.text;
        viewFirst.fl = self.tfEditaFlexibilidad.text;
    }
}

@end
