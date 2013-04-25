//
//  DatosAutoescuelaVC.m
//  PruebaLogin
//
//  Created by Fran Aldeguer on 18/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import "DatosAutoescuelaVC.h"

@interface DatosAutoescuelaVC ()

@end

@implementation DatosAutoescuelaVC
@synthesize autoescuelas, datos, LBLcp, LBLdireccion, LBLnombre, LBLpoblacion, LBLprovincia, LBLtelefono;

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
    autoescuelas = [[NSMutableArray alloc] init];
    datos = [[NSDictionary alloc] init];
    
    //NSURL es un objeto de tipo URL que contiene la Url que le pasemos
    NSString *conectar = [NSString stringWithFormat:
                          @"http://192.168.0.146/ProyectoAutoescuela/app_json/autoescuelaIOS.php"];
    NSLog(@"%@", conectar);
    NSURL *url = [NSURL URLWithString:conectar];
    //NSData es un objeto que contiene datos, en este caso los datos que le pasamos por el json que cojemos de la url
    NSData *json = [NSData dataWithContentsOfURL:url];
    //NSArray es un objeto de tipo Array y el atributo 'NSJSONSerialization JSONObjectWithData' transformamos el contenido del Json al Array
    NSArray *serialJson = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
    //NSLog es como un 'echo' en php, sirve para imprimir texto por pantalla
    NSLog(@"Ha devuelto %@", serialJson);
    
    
    Autoescuela *a;
    
    for (int i = 0; i<[serialJson count]; i++)
    {
        
        a = [[Autoescuela alloc] init];
        
        [a setIdentificador:[[serialJson objectAtIndex:i] valueForKey:@"id"]];
        [a setNombre:[[serialJson objectAtIndex:i] valueForKey:@"nombre"]];
        //[a setDireccion:[[serialJson objectAtIndex:i] valueForKey:@"direccion"]];
        [a setTelefono:[[serialJson objectAtIndex:i] valueForKey:@"telefono"]];
        [a setPoblacion:[[serialJson objectAtIndex:i] valueForKey:@"poblacion"]];
        [a setProvincia:[[serialJson objectAtIndex:i] valueForKey:@"provincia"]];
        [a setCP:[[serialJson objectAtIndex:i] valueForKey:@"CP"]];
        
        [autoescuelas addObject:a];
        NSLog(@"autoESC: %@", [a nombre]);
    }

    self.LBLnombre.text = [a nombre];
    //self.LBLdireccion.text = [a direccion];
    self.LBLtelefono.text = [a telefono];
    self.LBLpoblacion.text = [a poblacion];
    self.LBLprovincia.text = [a provincia];
    self.LBLcp.text = [a CP];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Llamar:(id)sender {
    Autoescuela *autoes = [[Autoescuela alloc] init];
    autoes =[autoescuelas objectAtIndex:0];
    
    UIApplication *myApp = [UIApplication sharedApplication];
    NSString *theCall = [NSString stringWithFormat:@"tel://%@",[autoes telefono]];
    NSLog(@"making call with %@",theCall);
    [myApp openURL:[NSURL URLWithString:theCall]];
}
@end
