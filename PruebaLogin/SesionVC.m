//
//  SesionVC.m
//  PruebaLogin
//
//  Created by Fran Aldeguer on 18/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import "SesionVC.h"

@interface SesionVC ()

@end

@implementation SesionVC

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CerrarSesion:(id)sender {
    
    NSString *docsDir;
    NSArray *dirPath;

    //Elige el directorio donde se va a crear la base de datos
    dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPath[0];
    
    _databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"Alum.db"]];
    
    //NSFileManager *filemgr = [NSFileManager defaultManager];
    

    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_alumnoDB) == SQLITE_OK)
    {
        NSString *insertSQL =@"DELETE FROM ALUMNOS";
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_alumnoDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Tabla borrada correctamente");
        } else {
            NSLog(@"Error al borrar la tabla");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_alumnoDB);
    }
    
    SesionVC *vc =(SesionVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self presentModalViewController:vc animated:YES];
    


    
    
}
@end
