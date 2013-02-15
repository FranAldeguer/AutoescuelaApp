//
//  ListaTestSinHacerVC.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 14/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Test.h"
#import <sqlite3.h>

@interface ListaTestSinHacerVC : UITableViewController{
    NSMutableArray *tests;
    NSDictionary *datos;
}

@property (nonatomic, strong) NSString *id_coleccion;

@property (nonatomic, strong) NSMutableArray *tests;
@property (nonatomic, strong) NSDictionary *datos;
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *alumnoDB;

@end
