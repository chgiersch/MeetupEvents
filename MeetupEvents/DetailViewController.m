//
//  DetailViewController.m
//  MeetupEvents
//
//  Created by Clint Chilcott on 1/19/15.
//  Copyright (c) 2015 ChrisGiersch. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *rsvpCountLabel;
@property (weak, nonatomic) IBOutlet UITextView *eventTextField;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.eventNameLabel.text = self.currentEvent[@"name"];
    self.groupInfoLabel.text = self.currentEvent[@"group"][@"name"];
    self.rsvpCountLabel.text = [NSString stringWithFormat:@"RSVP: %@", self.currentEvent[@"yes_rsvp_count"]];
    self.eventTextField.text = self.currentEvent[@"description"];

    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebViewController *wvc = segue.destinationViewController;
    wvc.linkToLoad = self.currentEvent[@"event_url"];
    
}


@end
