//
//  SecondViewController.m
//  actividadFisica
//
//  Created by Jorge Luis Perales on 21/03/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewControllerRegistroCuenta.h"
#import "ViewControllerEditarAjustes.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Carga informacion de la plist
//    NSString *filePath = [self dataFilePath];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
//        self.tfNombreAjustes.text = [array objectAtIndex:2];
//        self.tfMatriculaAjustes.text = [array objectAtIndex:0];
//        self.tfEstaturaAjustes.text = [array objectAtIndex:4];
//        self.tfPesoAjustes.text = [array objectAtIndex:5];
//    }
    AppDelegate *appDelegateSecond = [[UIApplication sharedApplication] delegate];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Usuario"];
    [query getObjectInBackgroundWithId:appDelegateSecond.generalID block:^(PFObject *object, NSError *error) {
        self.tfNombreAjustes.text = object[@"nombre"];
        self.tfMatriculaAjustes.text = object[@"matricula"];
        self.tfEstaturaAjustes.text = object[@"estatura"];
        self.tfPesoAjustes.text = object[@"peso"];
        
        
        //Fecha
        NSString *fechaNacimiento = object[@"fecha"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSDate *nacimiento = [[NSDate alloc] init];
        nacimiento = [dateFormatter dateFromString:fechaNacimiento];
        
        NSDate *now = [NSDate date];
        NSDateComponents *ageComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:nacimiento toDate:now options:0];
        NSInteger age = [ageComponents year];
        NSString *edad = [[NSString alloc] initWithFormat:@"%ld", (long)age];
        
        self.tfEdadAjustes.text = edad;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ViewControllerEditarAjustes *viewEditar = [segue destinationViewController];
    
    viewEditar.imagenEd = self.imagenAjustes.image;
    viewEditar.pesoEd = self.tfPesoAjustes.text;
}

- (IBAction)unwindEditarAjustes:(UIStoryboardSegue *)segue {
    self.tfPesoAjustes.text = self.pesoAj;
    self.imagenAjustes.image = self.imagenAj;
}

- (NSString *) dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent:@"archivoDatos.plist"];
}

@end
