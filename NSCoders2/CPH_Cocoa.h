//
//  CPH_Cocoa.h
//  NSCoders
//
//  Created by Narcis on 3/1/13.
//
//

#import <UIKit/UIKit.h>

@interface CPH_Cocoa : UIViewController <UIWebViewDelegate> {
    IBOutlet UIWebView *cphCocoaWebView;
}


@property (nonatomic,retain) IBOutlet UIWebView *cphCocoaWebView;

@end
