//
//  Test.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 14/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Test : NSObject{
    NSString *identificador;
    NSString *numero;
    NSString *id_coleccion;
    NSString *num_preguntas;
}

@property (nonatomic, strong) NSString *identificador;
@property (nonatomic, strong) NSString *numero;
@property (nonatomic, strong) NSString *id_coleccion;
@property (nonatomic, strong) NSString *num_preguntas;
@property (nonatomic, strong) NSString *fallos;

@end
