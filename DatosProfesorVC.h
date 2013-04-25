//
//  DatosProfesorVC.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 18/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "Profesor.h"

@interface DatosProfesorVC : UIViewController{
    NSMutableArray *profesores;
    NSDictionary *datos;
}

@property (strong, nonatomic) NSMutableArray *profesores;
@property (strong, nonatomic) NSDictionary *datos;

@property (strong, nonatomic) IBOutlet UILabel *LBLnombre;
@property (strong, nonatomic) IBOutlet UILabel *LBLtelefono;
@property (strong, nonatomic) IBOutlet UILabel *LBLmail;
@property (strong, nonatomic) IBOutlet UIImageView *imgpractico;
@property (strong, nonatomic) IBOutlet UIImageView *imgencargado;

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *alumnoDB;
- (IBAction)Llamar:(id)sender;

@end
