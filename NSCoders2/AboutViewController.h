//
//  AboutViewController.h
//  NSCoders2
//
//  Created by Narcis Zait on 10/17/13.
//  Copyright (c) 2013 Narcis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController {
    IBOutlet UILabel  *description;
    IBOutlet UIButton *linkToCph;
    IBOutlet UIButton *linkToNS;
}

@property (nonatomic,retain) IBOutlet UILabel *description;
@property (nonatomic,retain) IBOutlet UIButton *linkToCph;
@property (nonatomic,retain) IBOutlet UIButton *linkToNS;


@end
