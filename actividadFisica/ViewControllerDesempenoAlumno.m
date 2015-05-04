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

@interface ViewControllerDesempenoAlumno ()

@property (strong, nonatomic) NSMutableArray *pruebasAlumno;
@property (strong, nonatomic) NSMutableArray *registro;

@end

@implementation ViewControllerDesempenoAlumno

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //appDelegate.busqueda;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Pruebas"];
    [query whereKey:@"matricula" equalTo:appDelegate.busqueda];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                //NSLog(@"%@", object.objectId);
                
                [query getObjectInBackgroundWithId:object.objectId block:^(PFObject *usuario, NSError *error) {
                    self.registro = [[NSMutableArray alloc] initWithObjects:usuario[@"lagartijas"], usuario[@"abdominales"], usuario[@"milla"], usuario[@"flexibilidad"], usuario[@"fecha"], nil];
                    self.pruebasAlumno = [[NSMutableArray alloc] initWithObjects:self.registro, nil];
                    NSLog(@"%@", self.registro);
                }];
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
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

@end
