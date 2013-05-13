//
//  ValueRootViewController.m
//  Clinical_Reviewer_02
//
//  Created by Thanh Huynh on 11/24/11.
//  Copyright (c) 2011 MetaXceed. All rights reserved.
//

#import "KPRLRootViewController.h"
#import "MyTreeViewCell.h"
#import "JSON.h"
#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"
#import "ConfigViewController.h"
#import "ScreenShotViewController.h"
@implementation KPRLRootViewController
@synthesize detail;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.navigationItem.title=@"KP Report Library";
    float height= self.tableView.contentOffset.y;
    
    
    NSLog(@"%f",height);
    [self showLoadingInViewCenter:self.view Height:height];
    [self performSelector:@selector(pustToDetailViewCenter) withObject:nil afterDelay:1.0];
    
  //   UIBarButtonItem *config = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"gear.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(config)];
    

 //   self.navigationItem.rightBarButtonItem=config;
  //  [config release];
}
-(void)config{
    ConfigViewController *detailViewController = [[ConfigViewController alloc] initWithNibName:@"ConfigViewController" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}
-(void)loadNode{
    treeNode = [[MyTreeNode alloc] initWithValue:@"Root"];
    
    if([self isConnectionAvailable] == FALSE)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"WARNING" message:@"There is no internet Wifi or 3G/4G data network available. Please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
        
    }
   else if([self isHostAvailable] == FALSE &&[self isConnectionAvailable] == TRUE)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ERROR" message:@"The gateway to the host server is down" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
     
    }
    else
    {
    
    NSString *urlString1 = @"http://meta-x.com/conference/treesview_values.json";
	NSMutableURLRequest *request1 = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString: urlString1]] autorelease]; 
	[request1 setHTTPMethod: @"GET"];
	NSError *myerr1 = nil;
	NSData *returnData1 = [ NSURLConnection sendSynchronousRequest: request1 returningResponse: nil error: &myerr1 ];
	NSString *returnDataString1 = [[[NSString alloc] initWithData:returnData1 encoding: NSUTF8StringEncoding] autorelease];	
    jsonArray=[returnDataString1 JSONValue];
    searchArray=[[NSMutableArray alloc] init ];
    for (int i=1; i<[jsonArray count]; i++) {
        NSString *strNode1=[[jsonArray objectAtIndex:i] objectForKey:@"text"];
        [searchArray addObject:[jsonArray objectAtIndex:i]];
        NSMutableArray *tempArr=[[jsonArray objectAtIndex:i] objectForKey:@"children"];
        int ex1=[[[jsonArray objectAtIndex:i] objectForKey:@"expanded"] intValue];
        
        MyTreeNode *node1 = [[MyTreeNode alloc] init];
        node1.value=strNode1;
        if (ex1==0) {
            node1.inclusive=NO;
        }
        else
            node1.inclusive=YES;
        [treeNode addChild:node1];
        
        for (int j=0; j<[tempArr count]; j++) {
            
            NSString *strText=[[tempArr objectAtIndex:j] objectForKey:@"text"] ;
            int ex2=[[[tempArr objectAtIndex:j] objectForKey:@"expanded"]  intValue];
            
            MyTreeNode *node2 = [[MyTreeNode alloc] init];
            node2.value=strText;
            if (ex2==0) {
                node2.inclusive=NO;
            }
            else
                node2.inclusive=YES;
            [node1 addChild:node2];
            
            id obj = [[tempArr objectAtIndex:j] objectForKey:@"children"];            
            if (obj)
            {
                
                
                NSMutableArray *arrDic=[[tempArr objectAtIndex:j] objectForKey:@"children"] ;
                
                
                for (int n=0;n<[arrDic count] ; n++) {
                    NSString *str=[[arrDic objectAtIndex:n] objectForKey:@"text"];
                    MyTreeNode *node3 = [[MyTreeNode alloc] init];
                    node3.value=str;
                    node3.dic=[arrDic objectAtIndex:n];
                    [node2 addChild:node3];
                    [node3 release];
                }
            }
            else
            {
                node2.dic=[tempArr objectAtIndex:j];
            }
            
            [node2 release];
        }
        [node1 release];
        
        
    }
    }
    [self.tableView reloadData];
}
- (void) pustToDetailViewCenter{
	[loadingViewCenter removeFromSuperview];
    [self loadNode];
}

- (void)showLoadingInViewCenter:(UIView *)view Height:(float)height {
	
	loadingViewCenter = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200, 60.0)];
	loadingViewCenter.opaque = NO;
	loadingViewCenter.backgroundColor = [UIColor grayColor];
	loadingViewCenter.alpha = 0.5;
	loadingViewCenter.tag=23;
	loadingViewCenter.center= CGPointMake(view.bounds.size.width/5,view.bounds.size.height/3);
    
    if ([loadingViewCenter.layer respondsToSelector: @selector(setCornerRadius:)]) [(id) loadingViewCenter.layer setCornerRadius: 10];
    
    UILabel	*label = [[[UILabel alloc] initWithFrame: CGRectMake(0, 5, loadingViewCenter.bounds.size.width, 15)] autorelease];
	label.text = NSLocalizedString(@"Loading…", nil);
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.textAlignment = UITextAlignmentCenter;
	label.font = [UIFont boldSystemFontOfSize: 15];
	[loadingViewCenter addSubview: label];
	
	UIActivityIndicatorView				*spinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite] autorelease];
	
	spinner.center = CGPointMake(loadingViewCenter.bounds.size.width / 2, loadingViewCenter.bounds.size.height / 2 + 10);
    [spinner startAnimating];
	[loadingViewCenter addSubview: spinner];
	[view addSubview: loadingViewCenter];
	
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView == self.searchDisplayController.searchResultsTableView) {
	
        return [filteredtreeNode descendantCount];
    }
	else {
	   return [treeNode descendantCount];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    MyTreeViewCell *cell;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        
        MyTreeNode *node = [[filteredtreeNode flattenElements] objectAtIndex:indexPath.row + 1];
        
        cell = [[MyTreeViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:CellIdentifier 
                                               level:[node levelDepth] - 1 
                                            expanded:node.inclusive
                                            haschild:node.hasChildren];  
        
        
        cell.valueLabel.text = node.value;
    }
    else
    {
	
        MyTreeNode *node = [[treeNode flattenElements] objectAtIndex:indexPath.row + 1];

        cell = [[MyTreeViewCell alloc] initWithStyle:UITableViewCellStyleDefault
												 reuseIdentifier:CellIdentifier 
														   level:[node levelDepth] - 1 
														expanded:node.inclusive
                                                       haschild:node.hasChildren];  
  
    
        cell.valueLabel.text = node.value;
    }
 
	
    return cell;
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText {
	
	////[filteredtreeNode removeAllObjects];
   // [[MyTreeNode alloc] initWithValue:@"Root"];
    
   // [filteredtreeNode release];
    filteredtreeNode=[[MyTreeNode alloc] initWithValue:@"Root"];
    for (int i=0; i<[searchArray count]; i++) {
        NSString *strNode1=[[searchArray objectAtIndex:i] objectForKey:@"text"];
        NSRange result= [strNode1 rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
		if (result.location != NSNotFound ) 
        {
            NSMutableArray *tempArr=[[searchArray objectAtIndex:i] objectForKey:@"children"];
            int ex1=[[[searchArray objectAtIndex:i] objectForKey:@"expanded"] intValue];
            
            MyTreeNode *node1 = [[MyTreeNode alloc] init];
            node1.value=strNode1;
            if (ex1==0) {
                node1.inclusive=YES;
            }
            else
                node1.inclusive=YES;
            [filteredtreeNode addChild:node1];
            
            for (int j=0; j<[tempArr count]; j++) {
                
                NSString *strText=[[tempArr objectAtIndex:j] objectForKey:@"text"] ;
                int ex2=[[[tempArr objectAtIndex:j] objectForKey:@"expanded"]  intValue];
                
                MyTreeNode *node2 = [[MyTreeNode alloc] init];
                node2.value=strText;
                if (ex2==0) {
                    node2.inclusive=YES;
                }
                else
                    node2.inclusive=YES;
                [node1 addChild:node2];
                
                id obj = [[tempArr objectAtIndex:j] objectForKey:@"children"];            
                if (obj)
                {
                    
                    
                    NSMutableArray *arrDic=[[tempArr objectAtIndex:j] objectForKey:@"children"] ;
                    
                    
                    for (int n=0;n<[arrDic count] ; n++) {
                        NSString *str=[[arrDic objectAtIndex:n] objectForKey:@"text"];
                        MyTreeNode *node3 = [[MyTreeNode alloc] init];
                        node3.value=str;
                        node3.dic=[arrDic objectAtIndex:n];
                        [node2 addChild:node3];
                        [node3 release];
                    }
                }
                else
                {
                    node2.dic=[tempArr objectAtIndex:j];
                }
                
                [node2 release];
            }
            [node1 release];
        }
        else
        {
            NSMutableArray *tempArr=[[searchArray objectAtIndex:i] objectForKey:@"children"];
            int ex1=[[[searchArray objectAtIndex:i] objectForKey:@"expanded"] intValue];
        
            MyTreeNode *node1 = [[MyTreeNode alloc] init];
            node1.value=strNode1;
            if (ex1==0) {
                node1.inclusive=YES;
            }
            else
                node1.inclusive=YES;
            //[filteredtreeNode addChild:node1];
        
            for (int j=0; j<[tempArr count]; j++) {
            
                NSString *strText=[[tempArr objectAtIndex:j] objectForKey:@"text"] ;
                NSRange result= [strText rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
                if (result.location != NSNotFound ) 
                {
                    [filteredtreeNode addChild:node1];
                    int ex2=[[[tempArr objectAtIndex:j] objectForKey:@"expanded"]  intValue];
                    
                    MyTreeNode *node2 = [[MyTreeNode alloc] init];
                    node2.value=strText;
                    if (ex2==0) {
                        node2.inclusive=YES;
                    }
                    else
                        node2.inclusive=YES;
                    [node1 addChild:node2];
                    
                    id obj = [[tempArr objectAtIndex:j] objectForKey:@"children"];            
                    if (obj)
                    {
                        
                        
                        NSMutableArray *arrDic=[[tempArr objectAtIndex:j] objectForKey:@"children"] ;
                        
                        
                        for (int n=0;n<[arrDic count] ; n++) {
                            NSString *str=[[arrDic objectAtIndex:n] objectForKey:@"text"];
                            MyTreeNode *node3 = [[MyTreeNode alloc] init];
                            node3.value=str;
                            node3.dic=[arrDic objectAtIndex:n];
                            [node2 addChild:node3];
                            [node3 release];
                        }
                    }
                    else
                    {
                        node2.dic=[tempArr objectAtIndex:j];
                    }
                    
                    [node2 release];

                }
                else
                {
                    int ex2=[[[tempArr objectAtIndex:j] objectForKey:@"expanded"]  intValue];
                    
                    MyTreeNode *node2 = [[MyTreeNode alloc] init];
                    node2.value=strText;
                    if (ex2==0) {
                        node2.inclusive=YES;
                    }
                    else
                        node2.inclusive=YES;
                   
                    
                    id obj = [[tempArr objectAtIndex:j] objectForKey:@"children"];            
                    if (obj)
                    {
                        
                        
                        NSMutableArray *arrDic=[[tempArr objectAtIndex:j] objectForKey:@"children"] ;
                        
                        
                        for (int n=0;n<[arrDic count] ; n++) 
                        {
                            NSString *str=[[arrDic objectAtIndex:n] objectForKey:@"text"];
                            NSRange result= [str rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
                            if (result.location != NSNotFound ) 
                            {
                               [filteredtreeNode addChild:node1];
                                [node1 addChild:node2];
                                MyTreeNode *node3 = [[MyTreeNode alloc] init];
                                node3.value=str;
                                node3.dic=[arrDic objectAtIndex:n];
                                [node2 addChild:node3];
                                [node3 release];
                            }

                            
                        }
                    }
                    else
                    {
                        node2.dic=[tempArr objectAtIndex:j];
                    }
                    
                    [node2 release];

                }
            }
            [node1 release];
        }
        
        
    }

    
    
    
	//for (int i = 0; i < [treeNode descendantCount]; i++) {
        
        
        
        /*
        NSRange result= [node.value rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
		if (result.location != NSNotFound ) {
			[filteredtreeNode addChild:node];
		//	[self.filteredTwitter addObject:[tweets objectAtIndex:i]];
		//	NSLog(@"ADD %d", [filteredTwitter count]);
		}*/
        
        
	//}
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString];
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]];
    return YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	NSLog(@"END Y: %f", scrollView.contentOffset.y);
	if (scrollView.contentOffset.y <= 0) {
		NSLog(@"DID");
		self.tableView.userInteractionEnabled = FALSE;		
		[self reloadData];
		
	}
}
- (void)reloadData {
	
	[loadingView removeFromSuperview];
    
	CGFloat textViewWidth;
	
    textViewWidth = 320;
	
	loadingView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, textViewWidth, 94.0)];
	loadingView.opaque = NO;
	loadingView.backgroundColor = [UIColor grayColor];
	loadingView.alpha = 0.5;
	
	UIActivityIndicatorView *spinningWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(20.0, 15.0, 20.0, 20.0)];
	[spinningWheel startAnimating];
	[spinningWheel setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[loadingView addSubview:spinningWheel];
    [spinningWheel release];
	
	
	UILabel *loadingText = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, textViewWidth, 20)];
	loadingText.backgroundColor = [UIColor clearColor];
	loadingText.text = @"Loading...";
	loadingText.font = [UIFont boldSystemFontOfSize:14];
	loadingText.textAlignment = UITextAlignmentCenter;
	[loadingView addSubview:loadingText];
    [loadingText release];
	
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	NSString* currentTime = [dateFormatter stringFromDate:[NSDate date]];
	
	
	UILabel *lastUpdatedText = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, textViewWidth, 20)];
	lastUpdatedText.backgroundColor = [UIColor clearColor];
	lastUpdatedText.text = [@"Last Updated: " stringByAppendingString:currentTime];
	lastUpdatedText.font = [UIFont systemFontOfSize:14];
	lastUpdatedText.textAlignment = UITextAlignmentCenter;
    
	[loadingView addSubview:lastUpdatedText];
	
	self.tableView.tableHeaderView = loadingView;
	self.searchDisplayController.searchBar.frame = CGRectMake(0, 50, textViewWidth, 44);
	[self.tableView.tableHeaderView addSubview:self.searchDisplayController.searchBar];
	[self performSelector:@selector(pustToDetailView) withObject:nil afterDelay:1.0];
	self.tableView.userInteractionEnabled = YES;	
	self.tableView.scrollEnabled=YES;
    
}
- (void) pustToDetailView{
	[loadingView removeFromSuperview];
    [self loadNode];
    self.tableView.tableHeaderView = self.searchDisplayController.searchBar;
}
-(Boolean)isConnectionAvailable
{
    
    Boolean ret = FALSE;
    
    Reachability *r = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    
    if ((internetStatus == ReachableViaWiFi) || (internetStatus == ReachableViaWWAN)){
        ret = TRUE;
    }
    return ret;
} 

-(Boolean)isHostAvailable
{
    Boolean ret = FALSE;
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.meta-x.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    
    if ((internetStatus == ReachableViaWiFi) || (internetStatus == ReachableViaWWAN)){
        ret = TRUE;
    }
    
    return ret;
} 

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellE ditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        MyTreeNode *node = [[filteredtreeNode flattenElements] objectAtIndex:indexPath.row + 1];
        if (!node.hasChildren) 
        {for (MyTreeViewCell *cell in [tableView visibleCells]) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.valueLabel.textColor=[UIColor blackColor];
             cell.valueLabel.font=[UIFont systemFontOfSize:16.0f];
        }
            
            MyTreeViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];     
            
            if (newCell.accessoryType == UITableViewCellAccessoryNone) 
            {   
                newCell.accessoryType = UITableViewCellAccessoryCheckmark; 
                newCell.valueLabel.textColor=[self toUIColor:@"042061"];
                  newCell.valueLabel.font=[UIFont boldSystemFontOfSize:16.0];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];

            }
            
            // NSLog(@"%@",node.dic);
            detail.navigationItem.title=node.value;
             [ScreenShotViewController setTitle: node.value];
            [detail configureView];
            // detail.dic=node.dic;
            //  [detail.tableView reloadData];
        }
        else
        {
            node.inclusive = !node.inclusive;	
            [treeNode flattenElementsWithCacheRefresh:YES];
            [tableView reloadData];
        }

        
    }
    else
    {
        MyTreeNode *node = [[treeNode flattenElements] objectAtIndex:indexPath.row + 1];
        if (!node.hasChildren) 
        {
            for (MyTreeViewCell *cell in [tableView visibleCells]) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.valueLabel.textColor=[UIColor blackColor];
                cell.valueLabel.font=[UIFont systemFontOfSize:16.0f];
            }

            MyTreeViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];     
            
            if (newCell.accessoryType == UITableViewCellAccessoryNone) 
            {   
                newCell.accessoryType = UITableViewCellAccessoryCheckmark; 
                newCell.valueLabel.textColor=[self toUIColor:@"042061"];
                newCell.valueLabel.font=[UIFont boldSystemFontOfSize:16.0];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                
                // newCell.selectionStyle= UITableViewCellSelectionStyleNone;
            } 
            // NSLog(@"%@",node.dic);
            detail.navigationItem.title=node.value;
            [ScreenShotViewController setTitle: node.value];
            [detail configureView];
          //  detail.
            // detail.dic=node.dic;
            //  [detail.tableView reloadData];
            
        }
        else
        {
            node.inclusive = !node.inclusive;	
            [treeNode flattenElementsWithCacheRefresh:YES];
            [tableView reloadData];
        }

    }
        
    
    
   
}
-(UIColor *) toUIColor: (NSString *) stringToConvert  
{  
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];  
	NSRange range;  
    range.location = 0;  
    range.length = 2;  
    NSString *rString = [cString substringWithRange:range];  
	
    range.location = 2;  
    NSString *gString = [cString substringWithRange:range];  
	
    range.location = 4;  
    NSString *bString = [cString substringWithRange:range];  
	
    // Scan values  
    unsigned int r, g, b;  
    [[NSScanner scannerWithString:rString] scanHexInt:&r];  
    [[NSScanner scannerWithString:gString] scanHexInt:&g];  
    [[NSScanner scannerWithString:bString] scanHexInt:&b];  
	
    return [UIColor colorWithRed:((float) r / 255.0f)  
                           green:((float) g / 255.0f)  
                            blue:((float) b / 255.0f)  
                           alpha:1.0f];  
}

@end
