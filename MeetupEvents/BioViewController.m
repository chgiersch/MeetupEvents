//
//  BioViewController.m
//  MeetupEvents
//
//  Created by Clint Chilcott on 1/19/15.
//  Copyright (c) 2015 ChrisGiersch. All rights reserved.
//

#import "BioViewController.h"

@interface BioViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hometownLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UITextView *bioTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation BioViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"faker");
    
    self.nameLabel.text = self.bioDictionary[@"name"];
    
    

    
}

-(void)updateLabels
{
    
    self.nameLabel.text = self.bioDictionary[@"name"];
//    self.hometownLabel.text = self.bioDictionary[@"name"];
//    self.birthdayLabel.text = self.bioDictionary[@"name"];
//    self.bioTextField.text = self.bioDictionary[@"name"];
//    self.imageView.image = self.bioDictionary[@"photo_url"];


    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    NSLog(@"faker2");
    
    self.nameLabel.text = self.bioDictionary[@"name"];
    NSLog(self.bioDictionary[@"name"]);
    
    
    
    NSLog(self.bioDictionary[@"name"]);
    
    
}

@end
