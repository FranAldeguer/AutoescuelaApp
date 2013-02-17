//
//  TestMasFallosVC.m
//  PruebaLogin
//
//  Created by Fran Aldeguer on 15/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import "TestMasFallosVC.h"
#import "RealizarTestVC.h"

@interface TestMasFallosVC ()

@end

@implementation TestMasFallosVC
@synthesize tests, datos;

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
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No hay tests"
                                                                message:@"No tienes test para hacer en esta coleccion"
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_alumnoDB);
    }
    
    tests = [[NSMutableArray alloc] init];
    datos = [[NSDictionary alloc] init];
    
    //NSURL es un objeto de tipo URL que contiene la Url que le pasemos
    NSString *conectar = [NSString stringWithFormat:
                          @"http://localhost/ProyectoAutoescuela/app_json/TestFallos.php?alumcar=%@",
                          id_alum_carnet];
    NSLog(@"%@", conectar);
    NSURL *url = [NSURL URLWithString:conectar];
    //NSData es un objeto que contiene datos, en este caso los datos que le pasamos por el json que cojemos de la url
    NSData *json = [NSData dataWithContentsOfURL:url];
    //NSArray es un objeto de tipo Array y el atributo 'NSJSONSerialization JSONObjectWithData' transformamos el contenido del Json al Array
    NSArray *serialJson = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
    //NSLog es como un 'echo' en php, sirve para imprimir texto por pantalla
    NSLog(@"Ha devuelto %@", serialJson);
    
    
    Test *t;
    
    for (int i = 0; i<[serialJson count]; i++)
    {
        t = [[Test alloc] init];
        [t setIdentificador:[[serialJson objectAtIndex:i] valueForKey:@"id"]];
        [t setId_coleccion:[[serialJson objectAtIndex:i] valueForKey:@"id_coleccion"]];
        [t setNum_preguntas:[[serialJson objectAtIndex:i] valueForKey:@"num_preguntas"]];
        [t setNumero:[[serialJson objectAtIndex:i] valueForKey:@"numero"]];
        [t setFallos:[[serialJson objectAtIndex:i] valueForKey:@"fallos"]];
        
        
        [tests addObject:t];
        NSLog(@"id_test: %@", [t identificador]);
    }
    
    if ([serialJson count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No hay tests"
                                                        message:@"No tienes test para hacer en esta coleccion"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
        [alert show];
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
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [tests count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"C_test_fallos";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    
    Test *t = [[Test alloc] init];
    t = [tests objectAtIndex:[indexPath row]];
    
    UILabel *test = (UILabel *) [cell viewWithTag:20];
    UILabel *coleccion = (UILabel *) [cell viewWithTag:21];
    UILabel *fallos = (UILabel *) [cell viewWithTag:22];
    
    test.text = [NSString stringWithFormat:@"Test %@", [t numero]];
    coleccion.text = [NSString stringWithFormat:@"Coleccion %@", [t id_coleccion]];
    fallos.text = [NSString stringWithFormat:@"%@ fallos", [t fallos]];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //Coleccion *colec;
    if ([segue.identifier isEqualToString:@"realizar2"]){
        
        Test *test_pasar = [tests objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        //NSString *ident_colec = [ identificador];
        
        [segue.destinationViewController setTest_pasado:test_pasar];
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
