//
//  WebViewController.m
//  MeetupEvents
//
//  Created by Clint Chilcott on 1/19/15.
//  Copyright (c) 2015 ChrisGiersch. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *adddressURL = [NSURL URLWithString:self.linkToLoad];
    NSURLRequest *addressRequest = [NSURLRequest requestWithURL:adddressURL];
    [self.myWebView loadRequest:addressRequest];

}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
}


@end
