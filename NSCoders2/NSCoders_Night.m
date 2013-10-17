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

@synthesize nsCodersWebView;


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
//    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    nsCodersWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 40.0, 640, 1160)];
//    nsCodersWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [nsCodersWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://nscodernight.com"]]];
    nsCodersWebView.delegate = self;
    [self.view addSubview:nsCodersWebView];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    CGSize contentSize = webView.scrollView.contentSize;
//    CGSize viewSize = self.view.bounds.size;
//    
//    float rw = viewSize.width / contentSize.width;
//    
//    webView.scrollView.minimumZoomScale = rw;
//    webView.scrollView.maximumZoomScale = rw;
//    webView.scrollView.zoomScale = rw;
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
