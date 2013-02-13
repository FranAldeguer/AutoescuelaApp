//
//  ViewController.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 07/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coleccion.h"
#import "Alumno.h"
#import "alum_carnet.h"
#import <sqlite3.h>

@interface ViewController : UIViewController{
    UITextField *dni;
    UITextField *pass;
    NSDictionary *datos;
}

@property (nonatomic, strong) IBOutlet UITextField *dni;
@property (nonatomic, strong) IBOutlet UITextField *pass;
@property (nonatomic, strong) NSDictionary *datos;

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *alumnoDB;

-(IBAction)comprobar:(id)sender;




@end
