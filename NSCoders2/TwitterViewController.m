//
//  TwitterViewController.m
//  NSCoders2
//
//  Created by Narcis Zait on 10/17/13.
//  Copyright (c) 2013 Narcis. All rights reserved.
//

#import "TwitterViewController.h"

@interface TwitterViewController ()

@end

@implementation TwitterViewController
@synthesize username;
@synthesize scrollView, pageControl;
@synthesize webviewer;

-(IBAction)sendimage_tweet {
    
    // Hides the conformation UIView then calls "tweet_image"
    // to send tweet with image.
    
    [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
    [UIView setAnimationDuration:1.0];
    imageviewer.alpha = 0.0;
    [UIView commitAnimations];
    
    [self tweet_image];
}

-(IBAction)cancelimage_tweet {
    
    // Hides the conformation UIView.
    
    [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
    [UIView setAnimationDuration:1.0];
    imageviewer.alpha = 0.0;
    [UIView commitAnimations];
}

-(IBAction)devbysupertecnoboff {
    tweet_message = 2;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Developed by Supertecnoboff. Check out my other items on CodeCanyon:" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: @"View Portfolio", nil];
	[alert show];
}

-(IBAction)changebutton {
    
    // Show the UIWebView or UITableView depending on which one is currently present on the screen.
    
    if (current_view == 0) {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        [UIView setAnimationDuration:1.0];
        webviewer.alpha = 1.0;
        [UIView commitAnimations];
    }
    
    else if (current_view == 1) {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        [UIView setAnimationDuration:1.0];
        webviewer.alpha = 0.0;
        [UIView commitAnimations];
    }
}

-(IBAction)refresh {
    
    // Refresh the UIWebView or UITableView depending on which one is currently present on the screen.
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
    
    if (current_view == 0) {
        [self user_info];
        [self update_timeline];
    }
    
    else if (current_view == 1) {
        [webviewer reload];
    }
}

-(IBAction)sendtweet {
    
    // Send a tweet to the twitter profile you have specified.
    
    tweet_message = 1;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Send Tweet" message:@"" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: @"Tweet", @"Tweet + Pic", @"Tweet + Camera Pic", nil];
	[alert show];
}

-(IBAction)changePage {
	// Update the UIPageControl to the appropriate dot depending on the state of the scroll view.
    
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
	// Keep track of when scrolls happen in response to the page control
	// value changing. If we don't do this, a noticeable "flashing" occurs
	// as the the scroll delegate will temporarily switch back the page
	// number.
	pageControlBeingUsed = YES;
}

-(void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [profileImageView.layer setBorderWidth:2.0f];
    [profileImageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [profileImageView.layer setShadowRadius:3.0];
    [profileImageView.layer setShadowOpacity:0.5];
    [profileImageView.layer setShadowOffset:CGSizeMake(1.0, 0.0)];
    [profileImageView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    
    current_view = 1;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkLoad) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkNotLoad) userInfo:nil repeats:YES];
    
    webviewer.backgroundColor = [UIColor clearColor];
    [self.webviewer.scrollView setContentInset: UIEdgeInsetsMake(44, 0, 0, 0)];
    
    // Setup of the scrollview in charge of user profile information scrolling.
    pageControlBeingUsed = NO;
    self.scrollView.contentSize = CGSizeMake(640, 148);
    
    // Just for this demo app, I have added a content inset which makes the content
    // in the UITableView shift down by 40px.
    [self.tweetTableView setContentInset: UIEdgeInsetsMake(44, 0, 0, 0)];
    
    // The UIView called "profileview" needs to be set as the header view of the UITableView.
    self.tweetTableView.tableHeaderView = profileview;
    
    // We will get the user profile information first and then download the timeline of tweets
    // for that profile.
    [self user_info];
    [self update_timeline];
}

-(void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!pageControlBeingUsed) {
		// Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = self.scrollView.frame.size.width;
        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.pageControl.currentPage = page;
	}
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

-(void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

-(void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    self.scrollView = nil;
    self.pageControl = nil;
}

-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(void)user_info {
    // Request access to the Twitter accounts - using one iOS Twitter account for OAuth
    // access to the latest Twitter API.
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        
        if (granted) {
            
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            
            // Check if the users has setup at least one Twitter account.
            
            if (accounts.count > 0) {
                ACAccount *twitterAccount = [accounts objectAtIndex:0];
                
                // Creating a request to get the info about a user on Twitter.
                
                SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"] parameters:[NSDictionary dictionaryWithObject:USERNAME forKey:@"screen_name"]];
                [twitterInfoRequest setAccount:twitterAccount];
                
                // Making the request to the Twitter API.
                
                [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        // Check if we reached the rate limit of the Twitter API.
                        
                        if ([urlResponse statusCode] == 429) {
                            NSLog(@"API Rate limit reached. Try again later.");
                            return;
                        }
                        
                        // Check if there was any other errors.
                        
                        if (error) {
                            NSLog(@"Error: %@", error.localizedDescription);
                            return;
                        }
                        
                        // Check if there is some response data from the user information JSON feed.
                        
                        if (responseData) {
                            
                            NSError *error = nil;
                            NSArray *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                            
                            // Get user information such as follower count, name, etc...
                            // You can customise this if you wish to.
                            
                            // Stores the username, name and description downloaded from the JSON feed.
                            NSString *screen_name = [(NSDictionary *)TWData objectForKey:@"screen_name"];
                            NSString *name = [(NSDictionary *)TWData objectForKey:@"name"];
                            NSString *user_info = [(NSDictionary *)TWData objectForKey:@"description"];
                            
                            // Stores the number of followers, following, tweets and lists.
                            int followers = [[(NSDictionary *)TWData objectForKey:@"followers_count"] integerValue];
                            int following = [[(NSDictionary *)TWData objectForKey:@"friends_count"] integerValue];
                            int tweets = [[(NSDictionary *)TWData objectForKey:@"statuses_count"] integerValue];
                            int lists = [[(NSDictionary *)TWData objectForKey:@"listed_count"] integerValue];
                            
                            NSString *profileImageStringURL = [(NSDictionary *)TWData objectForKey:@"profile_image_url_https"];
                            NSString *bannerImageStringURL =[(NSDictionary *)TWData objectForKey:@"profile_banner_url"];
                            
                            
                            // Display the parsed JSON data to the user.
                            
                            // Displays the users's name, username and description.
                            nameLabel.text = name;
                            usernameLabel.text = [NSString stringWithFormat:@"@%@",screen_name];
                            user_info_des.text = [NSString stringWithFormat:@"%@", user_info];
                            
                            // Displays the users number of tweets, followers and the number of
                            // people the user is following.
                            tweetsLabel.text = [NSString stringWithFormat:@"%i", tweets];
                            followingLabel.text= [NSString stringWithFormat:@"%i", following];
                            followersLabel.text = [NSString stringWithFormat:@"%i", followers];
                            listsLabel.text = [NSString stringWithFormat:@"%i", lists];
                            
                            // Get the user profile image.
                            
                            profileImageStringURL = [profileImageStringURL stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
                            [self getProfileImageForURLString:profileImageStringURL];
                            
                            // If the user has a background banner image, we will download this too.
                            
                            if (bannerImageStringURL) {
                                NSString *bannerURLString = [NSString stringWithFormat:@"%@/mobile_retina", bannerImageStringURL];
                                [self getBannerImageForURLString:bannerURLString];
                            }
                            
                            else {
                                bannerImageView.backgroundColor = [UIColor underPageBackgroundColor];
                            }
                            
                            [active stopAnimating];
                        }
                    });
                }];
            }
        }
        
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oh dear..." message:@"Access has not been granted to the Twitter API. Make sure you have at least one Twitter account setup in iOS Settings." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alertView show];
        }
    }];
}

-(void)getProfileImageForURLString:(NSString *)urlString; {
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    profileImageView.image = [UIImage imageWithData:data];
}

-(void)getBannerImageForURLString:(NSString *)urlString; {
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    bannerImageView.image = [UIImage imageWithData:data];
}

-(void)update_timeline {
    
    // Once again we will be using one of the Twitter accounts setup in
    // iOS Settings app for OAuth authentication with the Twitter API.
    
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        
        if (granted == YES) {
            NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
            
            if ([arrayOfAccounts count] > 0) {
                ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                
                // Requestion the "user_timeline" JSON feed. Contains all the latest tweets and more.
                NSURL *requestURL = [NSURL URLWithString:@"http://api.twitter.com/1.1/statuses/user_timeline.json"];
                
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
                [parameters setObject:@"20" forKey:@"text"];
                [parameters setObject:@"1" forKey:@"include_entities"];
                [parameters setObject:USERNAME forKey:@"screen_name"];
                
                SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestURL parameters:parameters];
                
                postRequest.account = twitterAccount;
                
                [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    self.dataSource = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                    
                    if (self.dataSource.count != 0) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tweetTableView reloadData];
                        });
                    }
                }];
            }
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
        }
        
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oh dear..." message:@"Access has not been granted to the Twitter API. Make sure you have at least one Twitter account setup in iOS Settings." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alertView show];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

-(CGFloat)tableView :(UITableView *)tableView heightForRowAtIndexPath :(NSIndexPath *)indexPath {
    return 134;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = (CustomCell *)[self.tweetTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:17.0];
    
    NSDictionary *tweet = _dataSource[[indexPath row]];
    cell.cell_tweet.text = tweet[@"text"];
    cell.cell_username.text = USERNAME;
    cell.cell_date.text = tweet[@"created_at"];
    
    cell.cell_tweet.clipsToBounds = YES;
    cell.cell_username.clipsToBounds = YES;
    cell.cell_date.clipsToBounds = YES;
    cell.contentView.clipsToBounds = NO;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // This function (method) detects which cell the user taps and the figures out if
    // there is a URL for that Tweet, if there is then the UIWebView will appear
    // shwoing the relevant URL.
    
    int storyIndex = indexPath.row;
    
    NSDictionary *dict = [_dataSource objectAtIndex: storyIndex];
    NSDictionary *entities = [dict objectForKey:@"entities"];
    NSArray *urls = [entities objectForKey:@"urls"];
    
    if ([urls count] > 0) {
        current_view = 1;
        [_tweetTableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSDictionary *firstUrl = [urls objectAtIndex:0];
        NSString *storyLink = [firstUrl objectForKey:@"expanded_url"];
        [webviewer loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:storyLink]]];
        
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        [UIView setAnimationDuration:1.0];
        webviewer.alpha = 1.0;
        [UIView commitAnimations];
    }
    
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:@"There is no URL attatched to this Tweet." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alertView show];
        
        [_tweetTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"There appears to be a problem with your Internet Connection. This Application requires an EDGE/3G/4G or WiFi Network in order to work. Please connect to a network and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}

-(void)checkLoad {
	if (webviewer.loading) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	}
}

-(void)checkNotLoad {
	if (!(webviewer.loading)) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
    if (tweet_message == 1) {
        
        if (buttonIndex == 1) {
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                
                SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                [tweetSheet setInitialText:[NSString stringWithFormat: @"@%@ ", USERNAME]];
                [self presentViewController:tweetSheet animated:YES completion:nil];
            }
            
            else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup in iOS settings." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                [alertView show];
            }
        }
        
        if (buttonIndex == 2) {
            picker1 = [[UIImagePickerController alloc] init];
            picker1.delegate = self;
            [picker1 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentViewController:picker1 animated:YES completion:NULL];
        }
        
        if (buttonIndex == 3) {
            picker2 = [[UIImagePickerController alloc] init];
            picker2.delegate = self;
            [picker2 setSourceType:UIImagePickerControllerSourceTypeCamera];
            [self presentViewController:picker2 animated:YES completion:NULL];
        }
    }
    
    else if (tweet_message == 2) {
        if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://codecanyon.net/user/Supertecnoboff/portfolio"]];
        }
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // This function (method) gets the image that the user selected and then
    // closes the UIImagePickerController. The conformation UIView will then
    // be shown to the user.
    
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [confirm_image setImage:image];
    
    [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
    [UIView setAnimationDuration:1.0];
    imageviewer.alpha = 1.0;
    [UIView commitAnimations];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)tweet_image {
    
    // This function (method) gets the image that the user selected and adds it
    // to the Tweetsheet. The user can then Tweet the image with their message.
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:[NSString stringWithFormat: @"@%@ ", USERNAME]];
        [tweetSheet addImage:image];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup in iOS settings." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alertView show];
    }
}

@end
