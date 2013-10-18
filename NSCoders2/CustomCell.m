//
//  CustomCell.m
//  TwitterFeed
//
//  Created by Daniel Sadjadian on 18/07/2013.
//  Copyright (c) 2013 Supertecnoboff. All rights reserved.
//

/*************************************************************
 * IMPORTANT NOTE:                                           *
 * This application has been designed for iOS 6 and higher,  *
 * some of the functionality of this application will NOT    *
 * work with lower versions of iOS.                          *
 *                                                           *
 * If you need any help, please leave a comment on the       *
 * CodeCanyon page of this item or send me an email:         *
 *                                                           *
 * supertecnoboff@me.com                                     *
 *************************************************************/


#import "CustomCell.h"

@implementation CustomCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
