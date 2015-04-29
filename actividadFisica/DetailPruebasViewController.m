//
//  DetailPruebasViewController.m
//  actividadFisica
//
//  Created by Diego Aleman on 4/29/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "DetailPruebasViewController.h"

@implementation DetailPruebasViewController

#pragma mark - Managing the detail item


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tfLag.text = [self.detailItem objectAtIndex:0];
    self.tfAbd.text = [self.detailItem objectAtIndex:1];
    self.tfMilla.text = [self.detailItem objectAtIndex:2];
    self.tfElast.text = [self.detailItem objectAtIndex:3];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
