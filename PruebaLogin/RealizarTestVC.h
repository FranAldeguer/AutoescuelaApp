//
//  RealizarTestVC.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 14/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Test.h"
#import <sqlite3.h>

@interface RealizarTestVC : UIViewController

//Objeto que se le pasa por el segue
@property (nonatomic, strong) Test *test_pasado;

//Objetos que se utilizan en la interfaz
@property (strong, nonatomic) IBOutlet UILabel *num;
@property (strong, nonatomic) IBOutlet UILabel *colec;
@property (strong, nonatomic) IBOutlet UILabel *num_pre;
@property (strong, nonatomic) IBOutlet UITextField *TXTFallos;

//Objetos necesarios para el uso de la base de datos
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *alumnoDB;

//Diccionario para el JSON
@property (nonatomic, strong) NSDictionary *datos;

//Metodos
- (IBAction)realizar:(id)sender;

@end
