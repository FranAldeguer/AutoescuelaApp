//
//  Alumno.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 12/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alumno : NSObject{
    
    //Creamos las variables de la clase 'alumno'
    NSString *identificador;
    NSString *dni;
    NSString *nombre;
    NSString *apellidos;
    NSString *telefono;
    NSString *mail;
    NSString *pass;
    NSString *id_profesor;
}

@property (nonatomic, strong) NSString *identificador;
@property (nonatomic, strong) NSString *dni;
@property (nonatomic, strong) NSString *nombre;
@property (nonatomic, strong) NSString *apellidos;
@property (nonatomic, strong) NSString *telefono;
@property (nonatomic, strong) NSString *mail;
@property (nonatomic, strong) NSString *pass;
@property (nonatomic, strong) NSString *id_profesor;

@end
