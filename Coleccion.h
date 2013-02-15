//
//  Coleccion.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 11/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coleccion : NSObject{
    NSString *identificador;
    NSString *nombre;
    NSString *id_carnet;
}

@property (nonatomic, strong) NSString *identificador;
@property (nonatomic, strong) NSString *nombre;
@property (nonatomic, strong) NSString *id_carnet;

@end
