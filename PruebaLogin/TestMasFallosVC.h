//
//  TestMasFallosVC.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 15/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "Test.h"

@interface TestMasFallosVC : UITableViewController{
    NSMutableArray *tests;
    NSDictionary *datos;
}

@property (nonatomic, strong) NSMutableArray *tests;
@property (nonatomic, strong) NSDictionary *datos;
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *alumnoDB;
/*
@property (strong, nonatomic) IBOutlet UILabel *test_nom;
@property (strong, nonatomic) IBOutlet UILabel *test_colec;
@property (strong, nonatomic) IBOutlet UILabel *test_fallos;
*/
@end
