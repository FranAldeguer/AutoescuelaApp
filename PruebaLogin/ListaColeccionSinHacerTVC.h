//
//  ListaColeccionSinHacerTVC.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 13/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coleccion.h"
#import <sqlite3.h>

@interface ListaColeccionSinHacerTVC : UITableViewController{
    NSMutableArray *colecciones;
    NSDictionary *datos;
}

@property (nonatomic, strong) NSMutableArray *colecciones;
@property (nonatomic, strong) NSDictionary *datos;
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *alumnoDB;

@end
