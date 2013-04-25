//
//  ViewController.m
//  PruebaLogin
//
//  Created by Fran Aldeguer on 07/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize dni, pass;
@synthesize datos;
Alumno *alu;
alum_carnet *alucar;
- (void)viewDidLoad
{
    self.dni.text = nil;
    self.pass.text = nil;
    [super viewDidLoad];
    NSString *docsDir;
    NSArray *dirPath;
    
    
    //Elige el directorio donde se va a crear la base de datos
    dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPath[0];
    
    _databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"Alum.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if([filemgr fileExistsAtPath: _databasePath] == NO ){
        
        const char *dbpath = [_databasePath UTF8String];
        
        if(sqlite3_open(dbpath, &_alumnoDB) == SQLITE_OK){
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS ALUMNOS (ID_ALUMNO VARCHAR(11) PRIMARY KEY, PASS VARCHAR(32), ID_ALUM_CARNET VARCHAR(11), ID_CARNET VARCHAR(11))";
            if (sqlite3_exec(_alumnoDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Error al crear la tabla"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BD"
                                                                message:@"La base de datos se ha creado correctamente"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
            sqlite3_close(_alumnoDB);
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Error al crear la base de datos"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
}

-(void)comprobar:(id)sender{
    NSString *insertSQL;
    //Comprueba si hay algún campo vacio
    if ([self.dni.text isEqualToString:@""] || [self.pass.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"No puedes dejar campos vacios"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }else{
        
        datos = [[NSDictionary alloc]init];

        //Crea la URL para comprobar si el usuario y la contraseña son correctos
        NSString *conectar = [NSString stringWithFormat:
                              @"http://192.168.0.146/ProyectoAutoescuela/app_json/LoginAlumnoIOS.php?userDNI=%@&userPASS=%@",
                              self.dni.text, self.pass.text];
        NSURL *url = [NSURL URLWithString:conectar];
        
        //NSLog(conectar);
        
        //Rellena un JSON con los datos que devuelve la pagina
        NSData *DatosJson = [NSData dataWithContentsOfURL:url];
        
        NSArray *json = [NSJSONSerialization JSONObjectWithData:DatosJson options:0 error:nil];
        NSLog(@"Devuelve %@", json);
        
        //si el JSON devuelve vacio es por que no ha encontrado ningun alumno con ese dni y pass
        //por lo que el logueo está mal hecho y tiene que volver a intentarlo
        if (json == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logueo incorrecto"
                                                            message:@"El usuario o la contraseña son incorrectos"
                                                           delegate:self
                                                  cancelButtonTitle:@"Reintentar"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }else{
            
            //Recoge el alumno logueado y lo guarda en un objeto ALUMNO
            alu = [[Alumno alloc]init];
            //Rellena las variables del objeto con los datos obtenidos del JSON
            [alu setIdentificador:[[json objectAtIndex:0] valueForKey:@"id"]];
            [alu setDni:[[json objectAtIndex:0] valueForKey:@"dni"]];
            [alu setNombre:[[json objectAtIndex:0] valueForKey:@"nombre"]];
            [alu setApellidos:[[json objectAtIndex:0] valueForKey:@"apellidos"]];
            [alu setTelefono:[[json objectAtIndex:0] valueForKey:@"telefono"]];
            [alu setMail:[[json objectAtIndex:0] valueForKey:@"mail"]];
            [alu setPass:[[json objectAtIndex:0] valueForKey:@"pass"]];
            [alu setId_profesor:[[json objectAtIndex:0] valueForKey:@"id_profesor"]];
            
            //Recoge el carnet que se está sacando actualmente el alumno
            conectar = [NSString stringWithFormat:
                        @"http://192.168.0.146/ProyectoAutoescuela/app_json/AlumCarnetIOS.php?alumno=%@",
                        [alu identificador]];
            url = [NSURL URLWithString:conectar];
            DatosJson = [NSData dataWithContentsOfURL:url];
            json = [NSJSONSerialization JSONObjectWithData:DatosJson options:0 error:nil];
            NSLog(@"Devuelve %@", json);
            
            //Si no se está sacando ningun carnet devuelve un alert
            if(json == nil){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sin carnets"
                                                                message:@"En este momento no te estás sacando ningun carnet"
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                insertSQL = [NSString stringWithFormat:
                             @"INSERT INTO ALUMNOS (id_alumno, pass) VALUES (\"%@\", \"%@\")", [alu identificador], [alu pass]];
            }else{
            //Y si se lo está sacando lo mete en un objeto de tipo alum_carnet
                alucar = [[alum_carnet alloc] init];
            
                [alucar setIdentificador:[[json objectAtIndex:0] valueForKey:@"id"]];
                [alucar setId_alumno:[[json objectAtIndex:0] valueForKey:@"id_alumno"]];
                [alucar setId_carnet:[[json objectAtIndex:0] valueForKey:@"id_carnet"]];
                [alucar setTerminado:[[json objectAtIndex:0] valueForKey:@"terminado"]];
                
                NSLog(@"id_alucar: %@", [alucar identificador]);
                insertSQL = [NSString stringWithFormat:
                             @"INSERT INTO ALUMNOS (id_alumno, pass, id_alum_carnet, id_carnet) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")",
                             [alu identificador], [alu pass], [alucar identificador], [alucar id_carnet]];

            }
            NSLog(@"%@", insertSQL);
            
            sqlite3_stmt *statement;
            const char *dbpath = [_databasePath UTF8String];
            
            if (sqlite3_open(dbpath, &_alumnoDB) == SQLITE_OK)
            {
                const char *insert_stmt = [insertSQL UTF8String];
                sqlite3_prepare_v2(_alumnoDB, insert_stmt,-1, &statement, NULL);
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    NSLog(@"La insercion se ha realizado correctamente");
                } else {
                    NSLog(@"Error al realizar la inserción");
                }
                sqlite3_finalize(statement);
                sqlite3_close(_alumnoDB);
            }

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Correcto"
                                                            message: @"Bienvenido a la App"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
            
            Coleccion *vc =(Coleccion *)[self.storyboard instantiateViewControllerWithIdentifier:@"MenuPrincipal"];
            [self presentModalViewController:vc animated:YES];
        }
    }
    [dni resignFirstResponder];
    [pass resignFirstResponder];
}

//Subir la pantalla al subir el teclado
-(IBAction) slideFrameUp;
{
    [self slideFrame:YES];
}

//Bajar la pantalla
-(IBAction) slideFrameDown;
{
    [self slideFrame:NO];
}

//Metodo para subir la pantalla o bajarla
-(void) slideFrame:(BOOL) up
{
    const int movementDistance = 200; // lo que sea necesario, en mi caso yo use 80
    const float movementDuration = 0.3f; // lo que sea necesario
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
