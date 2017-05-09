//  播放play時, 可自動　"橫屏"　顯示的 MPMoviePlayer
//  DirectionMPMoviePlayerViewController.m
//  Direction
//
//  Created by apple on 12-4-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DirectionMPMoviePlayerViewController.h"

@implementation DirectionMPMoviePlayerViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIDeviceOrientationIsLandscape(interfaceOrientation);
}

@end
