//
//  BusquedaViewController.m
//  actividadFisica
//
//  Created by Jorge Luis Perales on 22/04/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "BusquedaViewController.h"
#import <Parse/Parse.h>

@interface BusquedaViewController ()

@end

@implementation BusquedaViewController

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

- (IBAction)presionoBuscar:(UIButton *)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Usuario"];
    [query whereKey:@"matricula" equalTo:self.buscaMatricula.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                //NSLog(@"%@", object.objectId);
                
                [query getObjectInBackgroundWithId:object.objectId block:^(PFObject *usuario, NSError *error) {
                    self.tfNombre.text = usuario[@"nombre"];
                    self.tfMatricula.text = usuario[@"matricula"];
                    self.tfEstatura.text = usuario[@"estatura"];
                    self.tfPeso.text = usuario[@"peso"];
                }];
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}
@end
