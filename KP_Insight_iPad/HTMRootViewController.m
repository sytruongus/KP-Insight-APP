//
//  ValueRootViewController.m
//  Clinical_Reviewer_02
//
//  Created by Thanh Huynh on 11/24/11.
//  Copyright (c) 2011 MetaXceed. All rights reserved.
//

#import "HTMRootViewController.h"
#import "MyTreeViewCell.h"
#import "JSON.h"
@implementation HTMRootViewController
@synthesize detail;
@synthesize jsonArray;

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
     self.navigationItem.title=@"HTM";
    /*
    self.navigationItem.title=@"TreeView";
    treeNode = [[MyTreeNode alloc] initWithValue:@"Root"];
    
    NSString *urlString1 = @"http://meta-x.com/conference/treesview_values.json";
	NSMutableURLRequest *request1 = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString: urlString1]] autorelease]; 
	[request1 setHTTPMethod: @"GET"];
	NSError *myerr1 = nil;
	NSData *returnData1 = [ NSURLConnection sendSynchronousRequest: request1 returningResponse: nil error: &myerr1 ];
	NSString *returnDataString1 = [[[NSString alloc] initWithData:returnData1 encoding: NSUTF8StringEncoding] autorelease];	
    jsonArray=[returnDataString1 JSONValue];
    
    // NSMutableDictionary *n=[jsonArray objectAtIndex:1];
    
    // NSLog(@"%@",n);
    
    for (int i=1; i<[jsonArray count]; i++) {
        NSLog(@"%@",[[jsonArray objectAtIndex:i] objectForKey:@"text"]);
        NSString *strNode1=[[jsonArray objectAtIndex:i] objectForKey:@"text"];
        NSMutableArray *tempArr=[[jsonArray objectAtIndex:i] objectForKey:@"children"];
        
        MyTreeNode *node1 = [[MyTreeNode alloc] init];
        node1.value=strNode1;
        [treeNode addChild:node1];
        
        for (int j=0; j<[tempArr count]; j++) {
            
            NSMutableArray *arrDic=[[tempArr objectAtIndex:j] objectForKey:@"children"] ;
            NSString *strText=[[tempArr objectAtIndex:j] objectForKey:@"text"] ;
            
            NSLog(@"%@",strText);
            MyTreeNode *node2 = [[MyTreeNode alloc] init];
            // node2.dic=[dic mutableCopy];
            node2.value=strText;
            [node1 addChild:node2];
            
            for (int n=0;n<[arrDic count] ; n++) {
                NSString *str=[[arrDic objectAtIndex:n] objectForKey:@"text"];
                MyTreeNode *node3 = [[MyTreeNode alloc] init];
                node3.value=str;
                node3.dic=[arrDic objectAtIndex:n];
                [node2 addChild:node3];
                [node3 release];
            }
            // MyTreeNode *node3 = [[MyTreeNode alloc] init];
            
            [node2 release];
        }
        [node1 release];
        
        
    }*/
    

          
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

   return [treeNode descendantCount];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
	
   	MyTreeNode *node = [[treeNode flattenElements] objectAtIndex:indexPath.row + 1];
	MyTreeViewCell *cell = [[MyTreeViewCell alloc] initWithStyle:UITableViewCellStyleDefault
												 reuseIdentifier:CellIdentifier 
														   level:[node levelDepth] - 1 
														expanded:node.inclusive];  
    // if(![node.value isEqualToString:@""])
    cell.valueLabel.text = node.value;
	
    return cell;
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
    /*
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSString *strName = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) { 
		strName =[filteredItemList objectAtIndex:indexPath.row];
	} else
	{
		strName = [itemlist objectAtIndex:[indexPath row]];
		
		
		
	}
    if ([strName isEqualToString:@"None"]) {
        return;
    }
    NSDictionary *tempDic1=[[[NSDictionary alloc] initWithContentsOfFile:[self dataFilePath]] autorelease];
    [tempDic1 setValue:strName forKey:@"key1" ];
    [tempDic1 writeToFile:[self dataFilePath] atomically:YES];
    [detail.navigationController popViewControllerAnimated:YES];
  //  NSLog(@" %@",cell.textLabel.text);
    detail.arr=[large objectForKey:[cell.textLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    detail.folderName=folderName;
   // NSLog(@"Large:%@",detail.arr);
    detail.navigationItem.title=@"Values: ";
    detail.navigationItem.title=[detail.navigationItem.title stringByAppendingString:strName];
    detail.title1=strName;
     [ScreenShotViewController setTitle: self.detail.navigationItem.title];
    [detail.tableView reloadData];*/
    
    MyTreeNode *node = [[treeNode flattenElements] objectAtIndex:indexPath.row + 1];
	if (!node.hasChildren) 
        NSLog(@"%@",node.dic);
	else
    {
        node.inclusive = !node.inclusive;	
        [treeNode flattenElementsWithCacheRefresh:YES];
        [tableView reloadData];
    }

   
}

@end
