//
//  AppDelegate.m
//  IVideo
//
//  Created by Minfon on 13/9/15.
//  Copyright (c) 2013年 com.mftech. All rights reserved.
//

#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ViewController.h"
#import "ipsettingViewController.h"

static NSString *KEYNAME_TITLE = @"subject";
static NSString *KEYNAME_IMGLINK = @"imagelink";
static NSString *KEYNAME_VIDEOLINK = @"videolink";
static NSString *KEYNAME_TITLE_LOG = @"Subject:%@";

@implementation AppDelegate

UITableView *tableView1;
UINavigationController *naviController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    
    
    // 初始 - 導航 控制器
    naviController = [[UINavigationController alloc] init];
    //------------------------------------------------
    // 初始 - 導航 default 的視圖 , 標題
    self.viewController = [[ViewController alloc] init];
    self.viewController.title=@"教育視頻";
   
    
    //  導航: 指定 返回按鈕
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc] initWithTitle:@"視頻清單" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.viewController.navigationItem.backBarButtonItem = backbutton;
    
    //  導航: 左 按鈕
    UIBarButtonItem *ipsettingButton = [[UIBarButtonItem alloc] initWithTitle:@"來源" style:UIBarButtonItemStyleBordered target:self action:@selector(ipSetting:)];
    self.viewController.navigationItem.leftBarButtonItem = ipsettingButton;
    
    //  導航: 右 按鈕
    UIBarButtonItem *refreshButton = [[[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                       target:self action:@selector(refreshClicked:)] autorelease];
    self.viewController.navigationItem.rightBarButtonItem = refreshButton;
    
    // 把 1個視圖, 推入到 導航 控制器
    [naviController pushViewController:self.viewController animated:NO];
    //------------------------------------------------
    
    [self.window addSubview:naviController.view];  //如果沒有 標簽控制器, 就只加入用 導航控制器
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (IBAction)ipSetting:(id)sender
{
    // 初始 - 自訂的視圖控制器
    ipsettingViewController *ipController = [[ipsettingViewController alloc]init];
    ipController.title = @"IP SETTING";
    
    // 把 自訂的視圖, 推入到 導航 控制器
    [naviController pushViewController:ipController  animated:YES];
}

//  按下　Reload 按鈕
- (IBAction)refreshClicked:(id)sender {
    
    
    NSString *addrKey = @"ServerForLink";
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:addrKey];
    if( str != nil)
    {
        
        // NSString *str=[DEFAULT_DATASRC_LINK stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        NSURL *url = [NSURL URLWithString :str];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        
        // 异步方式来调用，请求是在后台线程中运行，当请求执行完后再通知调用的线程。
        // 这样不会导致主线程进行网络请求时，界面被锁定等情况
        [request setDelegate:self];
        [request startAsynchronous];
    }
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSError *error;
    
    // 当以文本形式读取返回内容时用这个方法
    NSString *responseString = [request responseString];
    
    // 当以二进制形式读取返回内容时用这个方法
    NSData *responseData = [request responseData];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    
    NSString *space = [[NSString alloc] initWithString:@"\r\n"];
    
    self.viewController.m_txt.text = space;
    
    
    // 遍历输出JSON 里 XXXX 里的 YYYY
    /*
     NSArray *myArray = [json objectForKey:@"XXXX"];
     for(NSDictionary *myDic in myArray)
     { NSString *array = [myDic objectForKey:@"YYYY"];  }
     
     NSMutableArray *stringArray = [[NSMutableArray alloc] init];
     
     
     NSArray *item_array = [NSArray arrayWithObjects:@"One", @"Two", nil];
     self.items = [NSArray arrayWithObjects:@"One", @"Two", nil];
     
     item_array = [item_array arrayByAddingObject:@"Three"];
     for(NSDictionary *myDic in json)
     {
     NSString *array = [myDic objectForKey:@"myname"];
     item_array = [item_array arrayByAddingObject:array];
     }
     */
    
    self.viewController.items = [[NSMutableArray alloc]init];
    self.viewController.imglink = [[NSMutableArray alloc]init];
    self.viewController.videolink = [[NSMutableArray alloc]init];
    
    
    // 遍历输出JSON 里 的 key name
    for(NSDictionary *myDic in json)
    {
        NSString *video_str = [myDic objectForKey:KEYNAME_VIDEOLINK];
        NSString *img_str = [myDic objectForKey:KEYNAME_IMGLINK];
        NSString *array = [myDic objectForKey:KEYNAME_TITLE];
        if( array)
        {
            
            
            self.viewController.items = [self.viewController.items arrayByAddingObject:array];
            
            self.viewController.m_txt.text = [ self.viewController.m_txt.text stringByAppendingString:array];
            
            if( img_str )
                self.viewController.imglink = [self.viewController.imglink arrayByAddingObject:img_str];
            if( video_str )
                self.viewController.videolink = [self.viewController.videolink arrayByAddingObject:video_str];
            
            self.viewController.m_txt.text = [ self.viewController.m_txt.text stringByAppendingString:space];
            
            
            NSLog(KEYNAME_TITLE_LOG,array);
        }
    }
    
    [tableView1 reloadData];
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
}
@end
