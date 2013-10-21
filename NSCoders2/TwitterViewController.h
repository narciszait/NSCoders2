//
//  TwitterViewController.h
//  NSCoders2
//
//  Created by Narcis Zait on 10/17/13.
//  Copyright (c) 2013 Narcis. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <QuartzCore/QuartzCore.h>
#import "CustomCell.h"

// Replace "supertecnoboff" with your own Twitter username.
#define USERNAME @"narciszait"

@class CustomCell;
@interface TwitterViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate> {
    
    // When the user decides to send a tweet with an image, these UIImagePickerController's
    // will be used to allow the user to choose which image to send.
    UIImagePickerController *picker1;
    UIImagePickerController *picker2;
    UIImage *image;
    
    // Displays the Twitter profile picture and profile background.
    IBOutlet UIImageView *profileImageView;
    IBOutlet UIImageView *bannerImageView;
    IBOutlet UIView *profileview;
    IBOutlet UIActivityIndicatorView *active;
    
    // Displays the twitter username as well as the persons name.
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *usernameLabel;
    
    // Displays the amount of tweets and followers, also shows the
    // the amount of people the user is following.
    IBOutlet UILabel *tweetsLabel;
    IBOutlet UILabel *followingLabel;
    IBOutlet UILabel *followersLabel;
    IBOutlet UILabel *listsLabel;
    
    // Displays the users Twitter description.
    IBOutlet UITextView *user_info_des;
    
    // Used to contain the twitter username for JSON parsing.
    NSString *username;
    
    // "scrollView" is used to show the different scrollable user profile information.
    // "pageControl" is used for displaying the current position of the scroll view.
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    BOOL pageControlBeingUsed;
    
    // Displays the website associated with a tweet.
    IBOutlet UIWebView *webviewer;
    
    // Used to decide which item should be reloaded (UITableView + profile info or UIWebView).
    int current_view;
    
    // Used to decide which UIAlertView should be displayed.
    int tweet_message;
    
    // If the user decides to attach an image to their tweet, a conformation view will be shown.
    IBOutlet UIView *imageviewer;
    IBOutlet UIImageView *confirm_image;
}

// Send and cancel buttons part of the conformation view when sending a tweet with an image.
-(IBAction)sendimage_tweet;
-(IBAction)cancelimage_tweet;

// This button will show the UIWebView or UITableView, depending on which one is currently present.
-(IBAction)changebutton;

// This button will refresh the user timeline and the user information.
-(IBAction)refresh;

// Displays a Tweet sheet - send a tweet to your specified twitter user.
-(IBAction)sendtweet;

// In charge of updating the UIPageControl.
-(IBAction)changePage;

// Shows my developer info :)
-(IBAction)devbysupertecnoboff;

// This function (method) is in charge of updating the twitter user info.
-(void)user_info;

// This function (method) is in charge of updating the user timeline.
-(void)update_timeline;

// This function (method) is in charge of sending a tweet with an image.
-(void)tweet_image;

@property (strong, nonatomic) IBOutlet UITableView *tweetTableView;
@property (strong, nonatomic) NSArray *dataSource;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) IBOutlet UIWebView *webviewer;

@end
