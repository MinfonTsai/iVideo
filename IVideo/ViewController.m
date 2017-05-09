//
//  ViewController.m
//  IVideo
//
//  Created by Minfon on 13/9/15.
//  Copyright (c) 2013年 com.mftech. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"
#import "AsyncImageView.h"


//static NSString *DEFAULT_DATASRC_LINK = @"http://127.0.0.1:10088/chinanews";

//static NSString *DEFAULT_DATASRC_LINK = @"http://127.0.0.1/my4";


//static NSString *DEFAULT_DATASRC_LINK = @"http://127.0.0.1:10088/open163";
static NSString *KEYNAME_TITLE = @"subject";
static NSString *KEYNAME_IMGLINK = @"imagelink";
static NSString *KEYNAME_VIDEOLINK = @"videolink";
static NSString *KEYNAME_TITLE_LOG = @"Subject:%@";


@interface ViewController ()

    
@end

@implementation ViewController

UITableView *tableView1;
@synthesize items;
@synthesize imglink;
@synthesize videolink;
@synthesize mpcontrol;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Set up the NSArray
   // self.items = [[NSMutableArray alloc] initWithObjects:@"Item 1",@"Item 2",@"Item 3", @"Item 4",@"Item 5",@"Item 6",@"Item 7",@"Item 8",@"Item 9",@"Item 10",@"Item 11",@"Item 12", nil];
    
    
    self.items = [[NSMutableArray alloc]init];
    self.imglink = [[NSMutableArray alloc]init];
    self.videolink = [[NSMutableArray alloc]init];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count]; // or self.items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    tableView1 = tableView;
    return 1;
}

// 指定 表視圖的 accessory type （附蜀類型），顯示文字　等
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    // Step 1: Check to see if we can reuse a cell from a row that has just rolled off the screen
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    // Step 2: If there are no cells to reuse, create a new one
    if(cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    // Add a detail view accessory
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    // Step 3: Set the cell text
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    
    // Step 4: Return the cell
    return cell;
     */
    
#define IMAGE_VIEW_TAG 99    
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        // 只有一段文字
        //  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        
        //上　, 下 ２段文字
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
        
        //add AsyncImageView to cell
		AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(4.0f, 4.0f, 36.0f, 36.0f)];
		imageView.contentMode = UIViewContentModeScaleAspectFill;
		imageView.clipsToBounds = YES;
		imageView.tag = IMAGE_VIEW_TAG;
		[cell addSubview:imageView];
		
        // 為了最左邊放一張圖片, 加入以下
        cell.indentationLevel = 2; //缩进层级
        cell.indentationWidth = 20.0f; //每次缩进寛
    }    
    // Add a detail view accessory , 右邊的樣式
    cell.accessoryType = UITableViewCellAccessoryNone;    //右邊沒有任何符號
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;  //右邊有帶一個箭頭 (> more更多)
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton; //藍色按鈕帶白色箭頭
    // cell.accessoryType = UITableViewCellAccessoryCheckmark;   //打勾符號
    
    //cell 被選中後顏色不變
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 分割線
    tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine; // 單行分割線
    //self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;     //沒有分割線
    
    
    //設字體、顏色、背景色什麼的
    cell.textLabel.backgroundColor = [UIColor clearColor];  //[UIColor redColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:54.0/255.0 green:161.0/255.0 blue:219.0/255.0 alpha:1];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:135.0/255.0 green:135.0/255.0 blue:135.0/255.0 alpha:1];
    
    
    // 指定 字型 和　大小
    //UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 18.0 ];
    //cell.textLabel.font  = myFont;
    
    //  粗體字 , 大小
    //cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0];
    
    // 不指定字型, 只有指 字體大小
    cell.textLabel.font=[UIFont systemFontOfSize:16.0];
    
    
    //設定textLabel的最大允許行數，超過的話會在尾未以...表示
    //cell.textLabel.numberOfLines = 2;
    
    //  Set the cell text
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"時間:";
    
    //[tableView setEditing:YES animated:YES];     //全部變成 "可編輯" (editing) 模式
    
    // 項目的 縮圖
    /*
    switch (indexPath.row)
    {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"item_1.png"];
            break;
            
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"item_2.png"];
            break;
            
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"item_3.png"];
            break;
            
        default:
            cell.imageView.image = [UIImage imageNamed:@"item_1.png"];
            break;
    }  */
   
    //get image view
	AsyncImageView *imageView = (AsyncImageView *)[cell viewWithTag:IMAGE_VIEW_TAG];
	
    //cancel loading previous image for cell
    [[AsyncImageLoader sharedLoader] cancelLoadingURL:imageView.imageURL];
    
    //load the image
    NSURL *url = [NSURL URLWithString:[imglink objectAtIndex:indexPath.row]];
    imageView.imageURL = url;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 背景顏色, default為白，設定為指定的顏色
    cell.backgroundColor = [UIColor clearColor];   //如果要紅色底色 redColor
    //cell.contentView.backgroundColor=[UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:0.3]; //半透明
    
    //cell.backgroundColor = [UIColor yellowColor];  //[UIColor clearColor];
}

// 被選中的 (手指 最右邊滑過)的單一個, 進入 "可編輯" (editing) 模式
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Item 直接被選中, 該如何處理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSInteger row = indexPath.row;
   // NSString *videosrc = [videolink objectAtIndex:indexPath.row];  // Video http link
    NSURL *url = [NSURL URLWithString:[videolink objectAtIndex:indexPath.row]];
    
    mpcontrol = [[DirectionMPMoviePlayerViewController alloc] initWithContentURL:url];
    
    // 把 播放器當作 子視圖,加入到當前view之下
    [self.view addSubview:mpcontrol.view];
    
   
    mpcontrol.view.frame = self.view.frame;  //全屏播放
    mpcontrol.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;//全屏播放
    
    // 視頻結束後的回調方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playover_callback:) name:MPMoviePlayerPlaybackDidFinishNotification object:mpcontrol];
    
    [mpcontrol.moviePlayer play];
    [self presentMoviePlayerViewControllerAnimated:mpcontrol];
    
    
    return;
}



// 選中右邊的 箭頭 (accessoryButton)　,　該如何處理
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;  // Row number
  
}

// 如果 表視圖 變成 可編輯 (editing) 模式, 應該是什麼模式 ?
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;    //刪除模式, 最左邊有個 "紅色" 的 - 號
    //return UITableViewCellEditingStyleInsert;    //挿入模式, 最左邊有個 "綠色" 的 + 號
    //return UITableViewCellEditingStyleNone;        //　動畫, 　最左邊沒有圖形, 保持空白而已
}

// 通知, 編輯了哪一個 Cell 項目 ?
-(void) tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle) editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        //刪除選中的項目
        [items removeObjectAtIndex:[indexPath row]];
        [tableView  reloadData];
        
    }
}

- (IBAction)buttonPress:(id)sender {
    
   // NSString *str=[@"http://douban.fm/j/mine/playlist?type=n&h=&channel=0&from=mainsite&r=4941e23d79"stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
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
    
    self.m_txt.text = space;
    
    
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
    // 遍历输出JSON 里 的 key name
    for(NSDictionary *myDic in json)
    {
        NSString *video_str = [myDic objectForKey:KEYNAME_VIDEOLINK];
        NSString *img_str = [myDic objectForKey:KEYNAME_IMGLINK];   
        NSString *array = [myDic objectForKey:KEYNAME_TITLE];
        if( array)
        {
            
            
            self.items = [self.items arrayByAddingObject:array];
        
            self.m_txt.text = [ self.m_txt.text stringByAppendingString:array];
            
            if( img_str )
                self.imglink = [self.imglink arrayByAddingObject:img_str];
            if( video_str )
            self.videolink = [self.videolink arrayByAddingObject:video_str];
            
            self.m_txt.text = [ self.m_txt.text stringByAppendingString:space];
        
        
            NSLog(KEYNAME_TITLE_LOG,array);
        }
    }
    
    [tableView1 reloadData];
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
}

//------ 視頻　結束 , 回調Callback ------
- (void) playover_callback: (NSNotification *)notification
{
    DirectionMPMoviePlayerViewController *video = [notification object];  //也可直接用 mpcobtrol
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:video];
    
    video = nil;

}


@end
