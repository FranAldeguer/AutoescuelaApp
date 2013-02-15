//
//  alum_carnet.h
//  PruebaLogin
//
//  Created by Fran Aldeguer on 13/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface alum_carnet : NSObject{
    NSString *identificador;
    NSString *id_alumno;
    NSString *id_carnet;
    NSString *terminado;
}

@property(nonatomic, strong) NSString *identificador;
@property(nonatomic, strong) NSString *id_alumno;
@property(nonatomic, strong) NSString *id_carnet;
@property(nonatomic, strong) NSString *terminado;

@end
