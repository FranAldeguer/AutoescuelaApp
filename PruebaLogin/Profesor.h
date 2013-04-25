//
//  Profesor.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 18/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Profesor : NSObject{
    
    NSString *identificador;
    NSString *dni;
    NSString *nombre;
    NSString *apellidos;
    NSString *telefono;
    NSString *mail;
    NSString *practico;
    NSString *encargado;
}

@property (nonatomic, strong) NSString *identificador;
@property (nonatomic, strong) NSString *dni;
@property (nonatomic, strong) NSString *nombre;
@property (nonatomic, strong) NSString *apellidos;
@property (nonatomic, strong) NSString *telefono;
@property (nonatomic, strong) NSString *mail;
@property (nonatomic, strong) NSString *practico;
@property (nonatomic, strong) NSString *encargado;

@end
