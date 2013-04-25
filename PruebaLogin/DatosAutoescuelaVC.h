//
//  DatosAutoescuelaVC.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 18/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Autoescuela.h"

@interface DatosAutoescuelaVC : UIViewController{
    NSMutableArray *autoescuelas;
    NSDictionary *datos;
}

@property (nonatomic, strong) NSMutableArray *autoescuelas;
@property (nonatomic, strong) NSDictionary *datos;

@property (strong, nonatomic) IBOutlet UILabel *LBLnombre;
@property (strong, nonatomic) IBOutlet UILabel *LBLdireccion;
@property (strong, nonatomic) IBOutlet UILabel *LBLpoblacion;
@property (strong, nonatomic) IBOutlet UILabel *LBLprovincia;
@property (strong, nonatomic) IBOutlet UILabel *LBLcp;
@property (strong, nonatomic) IBOutlet UILabel *LBLtelefono;
- (IBAction)Llamar:(id)sender;

@end
