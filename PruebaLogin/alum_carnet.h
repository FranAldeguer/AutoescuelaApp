//
//  alum_carnet.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 13/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface alum_carnet : NSObject{
    int identificador;
    int id_alumno;
    int id_carnet;
    int terminado;
}

@property(nonatomic) int identificador;
@property(nonatomic) int id_alumno;
@property(nonatomic) int id_carnet;
@property(nonatomic) int terminado;

@end
