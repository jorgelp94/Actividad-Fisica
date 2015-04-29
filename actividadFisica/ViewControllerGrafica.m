//
//  ViewControllerGrafica.m
//  actividadFisica
//
//  Created by Diego Aleman on 4/29/15.
//  Copyright (c) 2015 Jorge Luis Perales. All rights reserved.
//

#import "ViewControllerGrafica.h"


@implementation ViewControllerGrafica

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.arrayOfValues = [[NSArray alloc]initWithObjects:@"1",@"2",@"1",@"4", nil];
    
    NSString *filePath = [self dataFilePath];
    if	([[NSFileManager defaultManager] fileExistsAtPath: filePath]){
        self.listaPruebas	=	[	[NSMutableArray alloc]	initWithContentsOfFile:	filePath];
        //self.listaPruebas = [[NSMutableArray alloc]init];
        //[self.listaPruebas setArray:array];
    }
    else{
        self.listaPruebas = [[NSMutableArray alloc]init];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return self.arrayOfValues.count; // Number of points in the graph.
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    return [[self.arrayOfValues objectAtIndex:index] doubleValue]; // The value of the point on the Y-Axis for the index.
}



-(NSString *) dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex: 0];
    NSLog(@"%@",[documentsDirectory stringByAppendingPathComponent:@"archivoDatos.plist"]);
    return	[documentsDirectory stringByAppendingPathComponent:@"archivoDatos.plist"];
}
@end
