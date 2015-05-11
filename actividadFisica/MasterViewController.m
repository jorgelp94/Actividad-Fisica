//
//  MasterViewController.m
//  actividadFisica
//
//  Created by Diego Aleman on 4/29/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailPruebasViewcontroller.h"

@interface MasterViewController ()

// arreglo donde se guardan arreglos con los resultados de las pruebas
@property NSMutableArray *listaPruebas;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Registro";
    
    // extrae lo que esta uardado en el iPhone y lo agrega a listaPruebas, sino hay nada crea una nueva
    NSString *filePath = [self dataFilePath];
    if	([[NSFileManager defaultManager] fileExistsAtPath: filePath]){
        self.listaPruebas	=	[	[NSMutableArray alloc]	initWithContentsOfFile:	filePath];
    }
    else{
        self.listaPruebas = [[NSMutableArray alloc]init];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
    DELETE ROW
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.listaPruebas removeObjectAtIndex:indexPath.row];
    [self.listaPruebas writeToFile:[self dataFilePath] atomically: YES];
    [self.tableView reloadData];
}


#pragma mark - Segues
/*
 *  envia informacion al detail
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray *object = self.listaPruebas[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
    
}

/*
 * cuando regresa de ViewControllerAgregar
 */

- (IBAction)unwindAgregar:(UIStoryboardSegue *)segue{
    [self.listaPruebas addObject:self.arregloRegistro]; // agrega nuevo registo a listaPruebas
    [self.listaPruebas writeToFile:[self dataFilePath] atomically: YES];    // escribe nueva listaPruebas a iPhone
    [self.tableView reloadData];
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listaPruebas.count;
}

/*
 *  Escribe en cada renglon de la TableView
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *object = self.listaPruebas[indexPath.row];
    // convierte fecha a string
    NSDateFormatter *formatoFecha = [[NSDateFormatter alloc ]init];
    [formatoFecha setDateStyle: NSDateFormatterMediumStyle];
    NSString *stringFormateado = [formatoFecha stringFromDate:[object objectAtIndex:4]];
    
    cell.textLabel.text = stringFormateado;
    return cell;
}

/*
 *  Obtiene el Path de los datos dentro del iphone
 */

-(NSString *) dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex: 0];
    NSLog(@"%@",[documentsDirectory stringByAppendingPathComponent:@"archivoDatos.plist"]);
    return	[documentsDirectory stringByAppendingPathComponent:@"archivoDatos.plist"];
}

@end