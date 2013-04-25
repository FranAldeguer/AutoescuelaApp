//
//  PracticaVerVC.m
//  PruebaLogin
//
//  Created by Fran Aldeguer on 17/02/13.
//  Copyright (c) 2013 FranAldeguer. All rights reserved.
//

#import "PracticaVerVC.h"

@interface PracticaVerVC ()

@end

@implementation PracticaVerVC
@synthesize practicaPasada, TXTFecha, TXTHora, TXTTiempo;

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
    self.TXTFecha.text = [practicaPasada fecha];
    self.TXTHora.text = [practicaPasada hora];
    self.TXTTiempo.text = [practicaPasada tiempo];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
