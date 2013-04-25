//
//  Autoescuela.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 18/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Autoescuela : NSObject{
    NSString *identificador;
    NSString *nombre;
    NSString *direccion;
    NSString *telefono;
    NSString *poblacion;
    NSString *provincia;
    NSString *CP;
}

@property (nonatomic, strong) NSString *identificador;
@property (nonatomic, strong) NSString *nombre;
@property (nonatomic, strong) NSString *direccion;
@property (nonatomic, strong) NSString *telefono;
@property (nonatomic, strong) NSString *poblacion;
@property (nonatomic, strong) NSString *provincia;
@property (nonatomic, strong) NSString *CP;

@end
