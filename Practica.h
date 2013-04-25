//
//  Practica.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 17/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Practica : NSObject{
    NSString *identificador;
    NSString *id_alum_carnet;
    NSString *fecha;
    NSString *hora;
    NSString *tiempo;
}

@property(nonatomic, strong) NSString *identificador;
@property(nonatomic, strong) NSString *id_alum_carnet;
@property(nonatomic, strong) NSString *fecha;
@property(nonatomic, strong) NSString *hora;
@property(nonatomic, strong) NSString *tiempo;

@end
