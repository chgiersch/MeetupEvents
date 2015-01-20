//
//  ViewController.m
//  MeetupEvents
//
//  Created by Chris Giersch on 1/19/15.
//  Copyright (c) 2015 ChrisGiersch. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

#pragma mark - Connections
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

#pragma mark - Other
@property NSArray *eventsArray;
@property DetailViewController *detailvc;


@end
#pragma mark
@implementation RootViewController

#pragma mark - View
- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=4b233a3256c8384121330d4d1d39"];

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         self.eventsArray = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"results"];
         [self.tableView reloadData];
     }];

}


- (IBAction)onSearchButtonPressed:(UIBarButtonItem *)sender
{
    
    
    NSString *enteredText = self.textField.text;
    NSString *newURL = [NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=4b233a3256c8384121330d4d1d39", enteredText];
    
    NSURL *url = [NSURL URLWithString:newURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
        {
         self.eventsArray = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"results"];
         [self.tableView reloadData];
        }];
}


#pragma mark - Table View
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    NSDictionary *event = [self.eventsArray objectAtIndex:indexPath.row];




    //    NSLog(@"%lu", (unsigned long)self.eventsArray.count);

    cell.textLabel.text = event[@"name"];
    NSDictionary *venue = event[@"venue"];
    cell.detailTextLabel.numberOfLines = 3;
//    cell.detailTextLabel.text = venue[@"name"];
    cell.detailTextLabel.text = venue[@"address_1"];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.eventsArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.detailvc.currentEvent = [self.eventsArray objectAtIndex:indexPath.row];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.detailvc = segue.destinationViewController;
}






@end
