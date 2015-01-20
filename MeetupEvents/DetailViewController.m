//
//  DetailViewController.m
//  MeetupEvents
//
//  Created by Clint Chilcott on 1/19/15.
//  Copyright (c) 2015 ChrisGiersch. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *rsvpCountLabel;
@property (weak, nonatomic) IBOutlet UITextView *eventTextField;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property NSArray *commentsArray;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.eventNameLabel.text = self.currentEvent[@"name"];
    self.groupInfoLabel.text = self.currentEvent[@"group"][@"name"];
    self.rsvpCountLabel.text = [NSString stringWithFormat:@"RSVP: %@", self.currentEvent[@"yes_rsvp_count"]];
    self.eventTextField.text = self.currentEvent[@"description"];
    
    NSString *eventID = self.currentEvent[@"id"];
    
    NSString *newURL = [NSString stringWithFormat:@"https://api.meetup.com/2/event_comments.json?event_id=%@&key=4b233a3256c8384121330d4d1d39", eventID];
    
    NSURL *url = [NSURL URLWithString:newURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         self.commentsArray = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"results"];
         [self.commentTableView reloadData];
     }];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    
    
    
    
    NSDictionary *comment = [self.commentsArray objectAtIndex:indexPath.row];
    
    //    NSLog(@"%lu", (unsigned long)self.eventsArray.count);
    
    cell.textLabel.text = comment[@"comment"];
//    cell.textLabel.numberOfLines = 3;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[comment[@"time"] integerValue]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", comment[@"member_name"], date];

    
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentsArray.count;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebViewController *wvc = segue.destinationViewController;
    wvc.linkToLoad = self.currentEvent[@"event_url"];

}


@end
