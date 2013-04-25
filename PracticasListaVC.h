//
//  PracticasListaVC.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 17/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Practica.h"
#import <sqlite3.h>

@interface PracticasListaVC : UITableViewController{
    NSMutableArray *practicas;
    NSDictionary *datos;
}

@property (nonatomic, strong) NSMutableArray *practicas;
@property (nonatomic, strong) NSDictionary *datos;
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *alumnoDB;

@end
