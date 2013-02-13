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
    int identificador;
    NSString *dni;
    NSString *nombre;
    NSString *apellidos;
    int telefono;
    NSString *mail;
    NSString *pass;
    int id_profesor;
}

@property (nonatomic) int identificador;
@property (nonatomic, strong) NSString *dni;
@property (nonatomic, strong) NSString *nombre;
@property (nonatomic, strong) NSString *apellidos;
@property (nonatomic) int telefono;
@property (nonatomic, strong) NSString *mail;
@property (nonatomic, strong) NSString *pass;
@property (nonatomic) int id_profesor;

@end
