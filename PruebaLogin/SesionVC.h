//
//  SesionVC.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 18/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface SesionVC : UIViewController

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *alumnoDB;

- (IBAction)CerrarSesion:(id)sender;

@end
