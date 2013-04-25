//
//  PracticaVerVC.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 17/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Practica.h"
@interface PracticaVerVC : UIViewController

@property (nonatomic, strong) Practica *practicaPasada;

@property (strong, nonatomic) IBOutlet UILabel *TXTFecha;
@property (strong, nonatomic) IBOutlet UILabel *TXTHora;
@property (strong, nonatomic) IBOutlet UILabel *TXTTiempo;

@end
