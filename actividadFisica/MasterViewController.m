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

@property NSMutableArray *listaPruebas;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.borrar = NO;   // no se quiere borrar un elemento de la lista
    
    // Init with objects recibe bjetos separados por coma y termina en nil o nulo
    //self.listaPruebas = [[NSMutableArray alloc]init];
    
    NSString *filePath = [self dataFilePath];
    if	([[NSFileManager defaultManager] fileExistsAtPath: filePath]){
        self.listaPruebas	=	[	[NSMutableArray alloc]	initWithContentsOfFile:	filePath];
        //self.listaPruebas = [[NSMutableArray alloc]init];
        //[self.listaPruebas setArray:array];
    }
    else{
        self.listaPruebas = [[NSMutableArray alloc]init];
    }
    
    //UIApplication *app=[UIApplication sharedApplication];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aplicacionTerminara:)	 name: UIApplicationDidEnterBackgroundNotification object:app];
    
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray *object = self.listaPruebas[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
    
}


- (IBAction)unwindAgregar:(UIStoryboardSegue *)segue{
    
    
    [self.listaPruebas addObject:self.arregloRegistro];
    
    [self.listaPruebas writeToFile:[self dataFilePath] atomically: YES];
    [self.tableView reloadData];
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listaPruebas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    NSArray *object = self.listaPruebas[indexPath.row];
    //NSDateFormatter *formatoFecha = [[NSDateFormatter alloc ]init];
    //[formatoFecha setDateStyle: NSDateFormatterMediumStyle];
    //NSString *stringFormateado = [formatoFecha stringFromDate:[object fecha]];
    
    //cell.textLabel.text = stringFormateado;
    cell.textLabel.text = [object objectAtIndex:0];
    return cell;
}





/**
 *
 **/

-(NSString *) dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex: 0];
    NSLog(@"%@",[documentsDirectory stringByAppendingPathComponent:@"archivoDatos.plist"]);
    return	[documentsDirectory stringByAppendingPathComponent:@"archivoDatos.plist"];
}

//-(void) aplicacionTerminara: (NSNotification *) notification{

//}




@end