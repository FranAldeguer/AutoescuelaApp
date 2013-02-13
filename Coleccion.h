//
//  Coleccion.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 11/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coleccion : NSObject{
    int identificador;
    NSString *nombre;
    int id_carnet;
}

@property (nonatomic) int identificador;
@property (nonatomic, strong) NSString *nombre;
@property (nonatomic) int id_carnet;

@end
