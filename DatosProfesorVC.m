//
//  DatosProfesorVC.m
//  PruebaLogin
//
//  Created by Fran Aldeguer on 18/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import "DatosProfesorVC.h"

@interface DatosProfesorVC ()

@end

@implementation DatosProfesorVC
@synthesize profesores, datos, LBLtelefono, LBLnombre, LBLmail, imgencargado, imgpractico;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSString *docsDir;
    NSArray *dirPath;
    NSString *id_alumno;
    
    //Elige el directorio donde se va a crear la base de datos
    dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPath[0];
    _databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"Alum.db"]];
    
    const char *dbPath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbPath, &_alumnoDB) == SQLITE_OK)
    {
        NSString *query = @"SELECT id_alumno FROM ALUMNOS";
        const char *query_stmt = [query UTF8String];
        if (sqlite3_prepare_v2(_alumnoDB,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                id_alumno = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSLog(@"id_carnet: %@", id_alumno);
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_alumnoDB);
    }

    profesores = [[NSMutableArray alloc] init];
    datos = [[NSDictionary alloc] init];
    
    NSString *conectar = [NSString stringWithFormat:@"http://192.168.0.146/ProyectoAutoescuela/app_json/profesorIOS.php?alumno=%@", id_alumno];
    NSLog(@"%@", conectar);
    NSURL *url = [NSURL URLWithString:conectar];
    NSData *json = [NSData dataWithContentsOfURL:url];
    NSArray *serialJson = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
    NSLog(@"Ha devuelto: %@", serialJson);
    
    Profesor *p;
    for (int i = 0; i<[serialJson count]; i++){
        p = [[Profesor alloc] init];
        
        [p setIdentificador:[[serialJson objectAtIndex:i] valueForKey:@"id"]];
        [p setNombre:[[serialJson objectAtIndex:i] valueForKey:@"nombre"]];
        [p setApellidos:[[serialJson objectAtIndex:i] valueForKey:@"apellidos"]];
        [p setTelefono:[[serialJson objectAtIndex:i] valueForKey:@"telefono"]];
        [p setMail:[[serialJson objectAtIndex:i] valueForKey:@"email"]];
        [p setEncargado:[[serialJson objectAtIndex:i] valueForKey:@"encargado"]];
        [p setPractico:[[serialJson objectAtIndex:i] valueForKey:@"practico"]];
        
        [profesores addObject:p];
        NSLog(@"profes %@", [p nombre]);
        
    }
    
    NSString *nom = [NSString stringWithFormat:@"%@ %@", [p nombre], [p apellidos]];
    
    UIImage *prac;
    UIImage *enc;
    
    if([[p practico] isEqualToString:@"0"]){
        prac = [UIImage imageNamed:@"cross.png"];
    }else{
        prac = [UIImage imageNamed:@"tick.png"];
    }
    
    if([[p encargado] isEqualToString:@"0"]){
        enc = [UIImage imageNamed:@"cross.png"];
    }else{
        enc = [UIImage imageNamed:@"tick.png"];
    }
    
    self.LBLnombre.text = nom;
    self.LBLtelefono.text = [p telefono];
    self.LBLmail.text = [p mail];
    self.imgencargado.image = enc;
    self.imgpractico.image = prac;
   
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Llamar:(id)sender {
    Profesor *prof = [[Profesor alloc] init];
    prof =[profesores objectAtIndex:0];
    
    UIApplication *myApp = [UIApplication sharedApplication];
    NSString *theCall = [NSString stringWithFormat:@"tel://%@",[prof telefono]];
    NSLog(@"making call with %@",theCall);
    [myApp openURL:[NSURL URLWithString:theCall]];
}
@end
