//
//  CPH_Cocoa.m
//  NSCodersStoryBoards
//
//  Created by Narcis on 3/21/13.
//  Copyright (c) 2013 Narcis. All rights reserved.
//

#import "CPH_Cocoa.h"

@interface CPH_Cocoa ()



@end

@implementation CPH_Cocoa

@synthesize cphCocoaWebView;


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
    NSLog(@"cocoacph");
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    cphCocoaWebView=[[UIWebView alloc] initWithFrame:self.view.bounds];
    [cphCocoaWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://copenhagencocoa.com"]]];
    [self.view addSubview:cphCocoaWebView];
    cphCocoaWebView.delegate=self;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGSize contentSize = webView.scrollView.contentSize;
    CGSize viewSize = self.view.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    
    webView.scrollView.minimumZoomScale = rw;
    webView.scrollView.maximumZoomScale = rw;
    webView.scrollView.zoomScale = rw;
    
    [webView setFrame:CGRectMake(0.0, 40.0, contentSize.width, contentSize.height + rw)];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
