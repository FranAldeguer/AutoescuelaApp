//
//  ListaColeccionesVC.m
//  PruebaLogin
//
//  Created by Fran Aldeguer on 17/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import "ListaColeccionesVC.h"
#import "DetailVC.h"
#import "ListaTestVC.h"

@interface ListaColeccionesVC ()

@end

@implementation ListaColeccionesVC
@synthesize colecciones, datos;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = @"Tests sin hacer";
    
    NSString *docsDir;
    NSArray *dirPath;
    NSString *id_carnet;
    
    //Elige el directorio donde se va a crear la base de datos
    dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPath[0];
    _databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"Alum.db"]];
    
    const char *dbPath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbPath, &_alumnoDB) == SQLITE_OK)
    {
        NSString *query = @"SELECT id_carnet FROM ALUMNOS";
        const char *query_stmt = [query UTF8String];
        if (sqlite3_prepare_v2(_alumnoDB,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                id_carnet = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSLog(@"id_carnet: %@", id_carnet);
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No hay tests"
                                                                message:@"No tienes test para hacer"
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_alumnoDB);
    }
    
    colecciones = [[NSMutableArray alloc] init];
    datos = [[NSDictionary alloc] init];
    
    //NSURL es un objeto de tipo URL que contiene la Url que le pasemos
    NSString *conectar = [NSString stringWithFormat:@"http://localhost/ProyectoAutoescuela/app_json/ColeccionesIOS.php?carnet=%@", id_carnet];
    NSLog(@"%@", conectar);
    NSURL *url = [NSURL URLWithString:conectar];
    //NSData es un objeto que contiene datos, en este caso los datos que le pasamos por el json que cojemos de la url
    NSData *json = [NSData dataWithContentsOfURL:url];
    //NSArray es un objeto de tipo Array y el atributo 'NSJSONSerialization JSONObjectWithData' transformamos el contenido del Json al Array
    NSArray *serialJson = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
    //NSLog es como un 'echo' en php, sirve para imprimir texto por pantalla
    NSLog(@"Ha devuelto %@", serialJson);
    
    //NSLog(@"Apellidos: %@", [alu apellidos]);
    
    
    
    Coleccion *colec;
    for (int i = 0; i<[serialJson count]; i++)
    {
        colec = [[Coleccion alloc] init];
        [colec setIdentificador:[[serialJson objectAtIndex:i] valueForKey:@"id"]];
        [colec setNombre:[[serialJson objectAtIndex:i] valueForKey:@"nombre"]];
        [colec setId_carnet:[[serialJson objectAtIndex:i] valueForKey:@"id_carnet"]];
        
        //int identi = [colec identificador];
        //NSString *numero = [NSString stringWithFormat:@"%d", [colec identificador]];
        //NSLog(@"%@", numero);
        
        [colecciones addObject:colec];
        NSLog(@"coleccion: %@", [colec identificador]);
    }
    [self.tableView reloadData];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [colecciones count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"C_coleccion";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Coleccion *col = [[Coleccion alloc]init];
    col = [colecciones objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = [col nombre];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"testLista2"]){
        NSString *ident_colec = [[colecciones objectAtIndex:[[self.tableView indexPathForSelectedRow] row]] identificador];
        [segue.destinationViewController setId_coleccion:ident_colec];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
