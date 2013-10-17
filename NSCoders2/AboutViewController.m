//
//  AboutViewController.m
//  NSCoders2
//
//  Created by Narcis Zait on 10/17/13.
//  Copyright (c) 2013 Narcis. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

@synthesize linkToNS, linkToCph; //description
@synthesize description;


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
    
    
    UIColor *color = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bright_squares.png"]];
    self.view.backgroundColor = color;
    
    description.textColor=[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    [linkToNS setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1] forState:UIControlStateNormal];
    [linkToNS setBackgroundColor:[UIColor clearColor]];
    
    [linkToCph setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1] forState:UIControlStateNormal];
    [linkToCph setBackgroundColor:[UIColor clearColor]];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewDidUnload{
    self.navigationController.navigationBarHidden=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
