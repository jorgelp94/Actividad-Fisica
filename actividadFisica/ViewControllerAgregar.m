//
//  ViewControllerAgregar.m
//  actividadFisica
//
//  Created by Diego Aleman on 4/29/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "ViewControllerAgregar.h"
#import "MasterViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface ViewControllerAgregar ()

@property NSMutableArray *lagartijas;
@property NSMutableArray *abdominales;
@property NSMutableArray *millaMin;
@property NSMutableArray *millaSeg;
@property NSMutableArray *flex;
@property (strong, nonatomic) UIPickerView *lagPicker;
@property (strong, nonatomic) UIPickerView *absPicker;
@property (strong, nonatomic) UIPickerView *millaPicker;
@property (strong, nonatomic) UIPickerView *flexPicker;

@end

@implementation ViewControllerAgregar

- (void) quitaTeclado {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitaTeclado)];
    [self.view addGestureRecognizer:tap];
    
    //arreglos
    self.lagartijas = [[NSMutableArray alloc] init];
    self.abdominales = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i <= 150; i++) {
        NSString *dato = [[NSString alloc] initWithFormat:@"%ld", (long)i];
        [self.lagartijas addObject:dato];
        [self.abdominales addObject:dato];
    }
    
    self.millaMin = [[NSMutableArray alloc] init];
    self.millaSeg = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i <= 59; i++) {
        NSString *dato = [[NSString alloc] initWithFormat:@"%ld:", (long)i];
        [self.millaMin addObject:dato];
    }
    for (NSInteger i = 0; i <= 59; i++) {
        NSString *dato = [[NSString alloc] initWithFormat:@"%ld", (long)i];
        [self.millaSeg addObject:dato];
    }
    
    self.flex = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i <= 120; i++) {
        NSString *dato = [[NSString alloc] initWithFormat:@"%ld", (long)i];
        [self.flex addObject:dato];
    }
    
    //Pickers
    self.lagPicker = [[UIPickerView alloc] init];
    self.lagPicker.delegate = self;
    self.lagPicker.dataSource =  self;
    [self.lagPicker setShowsSelectionIndicator:YES];
    self.tfLag.inputView = self.lagPicker;
    
    self.absPicker = [[UIPickerView alloc] init];
    self.absPicker.delegate = self;
    self.absPicker.dataSource =  self;
    [self.absPicker setShowsSelectionIndicator:YES];
    self.tfAbd.inputView = self.absPicker;
    
    self.millaPicker = [[UIPickerView alloc] init];
    self.millaPicker.delegate = self;
    self.millaPicker.dataSource =  self;
    [self.millaPicker setShowsSelectionIndicator:YES];
    self.tfMilla.inputView = self.millaPicker;
    
    self.flexPicker = [[UIPickerView alloc] init];
    self.flexPicker.delegate = self;
    self.flexPicker.dataSource =  self;
    [self.flexPicker setShowsSelectionIndicator:YES];
    self.tfElast.inputView = self.flexPicker;
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
    
    PFObject *registro = [PFObject objectWithClassName:@"Pruebas"];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    registro[@"fecha"] = fechaHoy;
    registro[@"matricula"] = appDelegate.matriculaGeneral;
    registro[@"lagartijas"] = self.tfLag.text;
    registro[@"abdominales"] = self.tfAbd.text;
    registro[@"milla"] = self.tfMilla.text;
    registro[@"flexibilidad"] = self.tfElast.text;
    
    [registro save];
    
    [registro saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSString *mensaje = [[NSString alloc] initWithFormat:@"Los datos se uguardaron correctamente."];
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Datos" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alerta show];
        }
        else {
            NSString *mensaje = [[NSString alloc] initWithFormat:@"Los datos no se guardaron."];
            UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Error" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alerta show];
        }
    }];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == self.lagPicker) {
        return self.lagartijas[row];
    }
    else if (pickerView == self.millaPicker){
        if (component == 0) {
            return self.millaMin[row];
        }
        else {
            return self.millaSeg[row];
        }
    }
    else if (pickerView == self.absPicker){
        return self.abdominales[row];
    } else {
        return self.flex[row];
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == self.lagPicker) {
        return 1;
    }
    else if (pickerView == self.millaPicker) {
        return 2;
    }
    else {
        return 1;
    }
    
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.lagPicker) {
        return self.lagartijas.count;
    }
    else if (pickerView == self.millaPicker) {
        if (component == 0) {
            return self.millaMin.count;
        }
        else {
            return self.millaSeg.count;
        }
    }
    else if (pickerView == self.absPicker){
        return self.abdominales.count;
    }
    else {
        return self.flex.count;
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.lagPicker) {
        NSInteger val1 = [pickerView selectedRowInComponent:0];
        //NSInteger val2 = [pickerView selectedRowInComponent:1];
        NSString *value = [[NSString alloc] initWithFormat:@"%@", self.lagartijas[val1]];
        self.tfLag.text = value;
    }
    else if (pickerView == self.millaPicker) {
        NSInteger val1 = [pickerView selectedRowInComponent:0];
        NSInteger val2 = [pickerView selectedRowInComponent:1];
        NSString *value = [[NSString alloc] initWithFormat:@"%@%@", self.millaMin[val1], self.millaSeg[val2]];
        self.tfMilla.text = value;
    }
    else if (pickerView == self.absPicker){
        NSInteger val1 = [pickerView selectedRowInComponent:0];
        NSString *value = [[NSString alloc] initWithFormat:@"%@",self.abdominales[val1]];
        self.tfAbd.text = value;
    }
    else {
        NSInteger val1 = [pickerView selectedRowInComponent:0];
        NSString *value = [[NSString alloc] initWithFormat:@"%@", self.flex[val1]];
        self.tfElast.text = value;
    }
    
}


@end
