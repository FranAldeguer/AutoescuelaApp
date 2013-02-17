//
//  ListaColeccionesVC.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 17/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "Coleccion.h"

@interface ListaColeccionesVC : UITableViewController{
    NSMutableArray *colecciones;
    NSDictionary *datos;
}

@property (nonatomic, strong) NSMutableArray *colecciones;
@property (nonatomic, strong) NSDictionary *datos;
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *alumnoDB;

@end
