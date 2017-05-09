//
//  ViewController.h
//  IVideo
//
//  Created by Minfon on 13/9/15.
//  Copyright (c) 2013年 com.mftech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DirectionMPMoviePlayerViewController.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
   
    //NSArray *items;       // 不變的  NSArray
    NSMutableArray *items;  // 可變動的 NSMutableArray
    NSMutableArray *imglink;  // 可變動的 NSMutableArray
    NSMutableArray *videolink;       // 視頻來源
    
    DirectionMPMoviePlayerViewController *mpcontrol;  
}

@property (nonatomic,retain) NSMutableArray *items;
@property (nonatomic,retain) NSMutableArray *imglink;
@property (nonatomic,retain) NSMutableArray *videolink;
@property (nonatomic,retain) DirectionMPMoviePlayerViewController *mpcontrol;

@property (strong, nonatomic) IBOutlet UILabel *m_txt;
- (IBAction)buttonPress:(id)sender;

@end 

