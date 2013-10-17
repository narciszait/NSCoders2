//
//  NSCoders_Night.m
//  NSCodersStoryBoards
//
//  Created by Narcis on 3/21/13.
//  Copyright (c) 2013 Narcis. All rights reserved.
//

#import "NSCoders_Night.h"

@interface NSCoders_Night ()

@end

@implementation NSCoders_Night


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
    NSLog(@"nscoders night");
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
