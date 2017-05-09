//
//  ipsettingViewController.m
//  IVideo
//
//  Created by Minfon on 13/9/21.
//  Copyright (c) 2013年 com.mftech. All rights reserved.
//

#import "ipsettingViewController.h"

static NSString *DEFAULT_DATASRC_LINK = @"http://127.0.0.1:10088/open163";

@interface ipsettingViewController ()

@end

@implementation ipsettingViewController

UINavigationController *naviController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       // NSString *addrKey = @"ServerForLink";
       //// NSString *str1 = [[NSUserDefaults standardUserDefaults] objectForKey:addrKey];
       // if( str1 == nil)
        //    self.servertext.text = DEFAULT_DATASRC_LINK;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *addrKey = @"ServerForLink";
    NSString *str1 = [[NSUserDefaults standardUserDefaults] objectForKey:addrKey];
    if( str1 != nil)
        self.servertext.text = str1;
    else
         self.servertext.text = DEFAULT_DATASRC_LINK;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setServertext:nil];
    [super viewDidUnload];
}
- (IBAction)okPressed:(id)sender {
    
    NSString *serveraddr =
    self.servertext.text;
    
    NSString *addrKey = @"ServerForLink";
    [[NSUserDefaults standardUserDefaults] setObject:serveraddr forKey:addrKey];
    
    // 同步到文件里，避免数据的丢失
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [naviController popViewControllerAnimated:YES];
}
@end
