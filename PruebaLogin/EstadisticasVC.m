//
//  EstadisticasVC.m
//  PruebaLogin
//
//  Created by Fran Aldeguer on 20/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import "EstadisticasVC.h"

@interface EstadisticasVC ()

@end

@implementation EstadisticasVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTestAprobados:nil];
    [self setTestSuspensos:nil];
    [self setTestTotal:nil];
    [self setPracticaTotal:nil];
    [super viewDidUnload];
}
@end
