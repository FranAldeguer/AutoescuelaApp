//
//  RealizarTestVC.m
//  PruebaLogin
//
//  Created by Fran Aldeguer on 14/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import "RealizarTestVC.h"
#import "Test.h"

@interface RealizarTestVC ()

@end

@implementation RealizarTestVC
@synthesize test_pasado, num, colec, num_pre, TXTFallos, datos;

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
    NSString *title = [NSString stringWithFormat:@"TEST %@",[test_pasado numero]];
    self.title = title;
    self.num.text = [test_pasado numero];
    self.colec.text= [test_pasado id_coleccion];
    self.num_pre.text = [test_pasado num_preguntas];
    
    
    /*backButton = [[UIBarButtonItem alloc]
                  initWithTitle:@"Back" style:UIBarButtonItemStyleBordered
                  target:nil action:];
    
    [self.navigationItem setBackBarButtonItem:backButton];
    */
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)realizar:(id)sender {
    if ([self.TXTFallos.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No puedes dejar el campo vacio"
                                                        message:@"¿Cuantos fallos has tenido?"
                                                       delegate:self
                                              cancelButtonTitle:@"Volver"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }else{
    
        NSString *fallos = TXTFallos.text;
        
        NSString *docsDir;
        NSArray *dirPath;
        NSString *id_alum_carnet;
        
        //Elige el directorio donde se va a crear la base de datos
        dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = dirPath[0];
        _databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"Alum.db"]];
        
        const char *dbPath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbPath, &_alumnoDB) == SQLITE_OK)
        {
            NSString *query = @"SELECT id_alum_carnet FROM ALUMNOS";
            const char *query_stmt = [query UTF8String];
            if (sqlite3_prepare_v2(_alumnoDB,query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    id_alum_carnet = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    NSLog(@"id_alum_carnet: %@", id_alum_carnet);
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Vuelve a intentarlo"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(_alumnoDB);
        }
    
    
        datos = [[NSDictionary alloc] init];
        
        //NSURL es un objeto de tipo URL que contiene la Url que le pasemos
        NSString *conectar = [NSString stringWithFormat:
                              @"http://192.168.0.146/ProyectoAutoescuela/app_json/HacerTestIOS.php?alumcar=%@&test=%@&fallos=%@",
                              id_alum_carnet, [test_pasado identificador], fallos];
        NSLog(@"%@", conectar);
        NSURL *url = [NSURL URLWithString:conectar];
        //NSData es un objeto que contiene datos, en este caso los datos que le pasamos por el json que cojemos de la url
        NSData *json = [NSData dataWithContentsOfURL:url];
        //NSArray es un objeto de tipo Array y el atributo 'NSJSONSerialization JSONObjectWithData' transformamos el contenido del Json al Array
        //NSArray *serialJson = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
        //NSLog es como un 'echo' en php, sirve para imprimir texto por pantalla
        
        //NSString *datos = [NSString]
        NSString* newStr = [NSString stringWithUTF8String:[json bytes]];
        NSLog(@"Ha devuelto %@", newStr);
        
        if([newStr isEqualToString:@"1"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Correcto"
                                                            message:@"Has realizado el test correctamente"
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            //[self.view removeFromSuperview];
            Test *vc =(Test *)[self.storyboard instantiateViewControllerWithIdentifier:@"MenuPrincipal"];
            [self presentModalViewController:vc animated:YES];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Ha habido un error"
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    [TXTFallos resignFirstResponder];
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
    const int movementDistance = 100; // lo que sea necesario, en mi caso yo use 80
    const float movementDuration = 0.3f; // lo que sea necesario
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
@end
