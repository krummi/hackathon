//
//  RSSecondViewController.m
//  RecieptScanner
//
//  Created by Kári Tristan Helgason on 31.5.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "RSSecondViewController.h"

@interface RSSecondViewController ()

@end

@implementation RSSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
