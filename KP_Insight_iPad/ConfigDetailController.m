//
//  ValueDetailController.m
//  Clinical_Reviewer_02
//
//  Created by Thanh Huynh on 11/24/11.
//  Copyright (c) 2011 MetaXceed. All rights reserved.
//

#import "ConfigDetailController.h"
#import "ScreenShotViewController.h"
@interface ConfigDetailController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureView;
@end

@implementation ConfigDetailController
@synthesize detailItem;
@synthesize popoverController=_myPopoverController;

-(void)configureView{
    if (self.detailItem) {
        [self.tableView reloadData];
    }
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (detailItem != newDetailItem) {
        [detailItem release]; 
        detailItem = [newDetailItem retain]; 
        
        // Update the view.
        [self configureView];
    }
    
    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }        
}


#pragma mark -
#pragma mark Split view support
- (void)splitViewController:(MGSplitViewController*)svc 
	 willHideViewController:(UIViewController *)aViewController 
		  withBarButtonItem:(UIBarButtonItem*)barButtonItem 
	   forPopoverController: (UIPopoverController*)pc
{
	
	
	if (barButtonItem) {
        //  btnBrowse=barButtonItem;
        barButtonItem.title=@"Browse";
        self.navigationItem.leftBarButtonItem=barButtonItem;
		//isPortrain=YES;
        
        
	}
    self.popoverController = pc;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(MGSplitViewController*)svc 
	 willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	
	self.navigationItem.leftBarButtonItem=nil;
	//isPortrain=NO;
    
    self.popoverController = nil;
    
}

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    self.navigationItem.title=@"Configuration";
    
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"OK");
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
   [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
  
}
-(void)textViewDidEndEditing:(UITextView *)textView
{

}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
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
#pragma mark -
#pragma mark Rotation support
- (void)willAnimateRotationToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    
    
    
    if (interfaceOrientation == UIDeviceOrientationPortrait )
    {
        NSLog(@"Protrait");
        
        [ScreenShotViewController setLandscape:@"Protrait"];
    }
    else if( interfaceOrientation == UIDeviceOrientationPortraitUpsideDown)
    {
        NSLog(@"PortraitUpsideDown");
        
        [ScreenShotViewController setLandscape:@"PortraitUpsideDown"];
    }
    else if( interfaceOrientation==UIDeviceOrientationLandscapeLeft)
    {
        NSLog(@"LandscapeLeft");
        
        [ScreenShotViewController setLandscape:@"LandscapeLeft"];
    }
    else if( interfaceOrientation==UIDeviceOrientationLandscapeRight)
    {
        NSLog(@"LandscapeRight");
        
        [ScreenShotViewController setLandscape:@"LandscapeRight"];
        
    }
    
    [self.tableView reloadData];
    
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    if (section==0) {
        return 3;
    }
    else
        return 1;
  
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if(section==0)
        return @"Server Information";
    else if(section==2)
        return @"Notify Users";
    return  @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            return 100.f;
        }
    }
  
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    else
    {
        [cell removeFromSuperview];
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease] ;
        
    }
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            cell.textLabel.text = @"Server Name";
          
            UITextField *lbServerName;
            if([[UIDevice currentDevice]orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice]orientation] == UIDeviceOrientationPortraitUpsideDown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationUnknown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceUp || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceDown)
            {
                lbServerName = [[UITextField alloc]initWithFrame:CGRectMake(130, 11, 160, 40)];
            }
            if([[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeRight)
            {
                lbServerName = [[UITextField alloc]initWithFrame:CGRectMake(130, 11, 320, 40)];
            }
            // lbUserName.delegate = self;
            lbServerName.text = @"";
            lbServerName.autocorrectionType = UITextAutocorrectionTypeNo;
            lbServerName.backgroundColor = [UIColor clearColor];
            lbServerName.textColor = [self toUIColor:@"003366"];
            lbServerName.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
            [cell.contentView addSubview:lbServerName];
        }
        else if(indexPath.row==1)
        {
            cell.textLabel.text = @"User Name";
          
            UITextField *lbUserName;
            if([[UIDevice currentDevice]orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice]orientation] == UIDeviceOrientationPortraitUpsideDown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationUnknown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceUp || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceDown)
            {
                lbUserName = [[UITextField alloc]initWithFrame:CGRectMake(130, 11, 160, 40)];
            }
            if([[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeRight)
            {
                lbUserName = [[UITextField alloc]initWithFrame:CGRectMake(130, 11, 320, 40)];
            }
            //  lbUserName.delegate = self;
            // lbUserName.text = username;
            lbUserName.autocorrectionType = UITextAutocorrectionTypeNo;
            lbUserName.backgroundColor = [UIColor clearColor];
            lbUserName.textColor = [self toUIColor:@"003366"];
            lbUserName.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
            [cell.contentView addSubview:lbUserName];
        }
        else
        {
            cell.textLabel.text = @"Password";
           
            UITextField *lbPassword;
            if([[UIDevice currentDevice]orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice]orientation] == UIDeviceOrientationPortraitUpsideDown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationUnknown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceUp || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceDown)
            {
                lbPassword = [[UITextField alloc]initWithFrame:CGRectMake(130, 11, 160, 40)];
            }
            if([[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeRight)
            {
                lbPassword = [[UITextField alloc]initWithFrame:CGRectMake(130, 11, 320, 40)];
            }
            // lbPassword.delegate = self;
            // lbPassword.text = password;
            lbPassword.autocorrectionType = UITextAutocorrectionTypeNo;
            lbPassword.backgroundColor = [UIColor clearColor];
            [lbPassword setSecureTextEntry:YES];
            lbPassword.textColor = [self toUIColor:@"003366"];
            lbPassword.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
            [cell.contentView addSubview:lbPassword];
        }
    }
    else if(indexPath.section==1)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        if([[UIDevice currentDevice]orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice]orientation] == UIDeviceOrientationPortraitUpsideDown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationUnknown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceUp || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceDown)
        {
            [button setFrame:CGRectMake(0.0f, 0.0f,680, 44.0f)];
        }
        if([[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeRight)
        {
            [button setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width-85, 44.0f)];
        }
        // [button setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width-100, 44.0f)];
        
        [button setTitle:@"Request Account" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [button addTarget:self action:@selector(config) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
        
    }
    else if(indexPath.section==2)
    {
        txtTitle = [[TextViewWithHolder alloc] init];
       // txtTitle.frame = CGRectMake(0, 94, textViewWidth -10, 90);
        if([[UIDevice currentDevice]orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice]orientation] == UIDeviceOrientationPortraitUpsideDown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationUnknown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceUp || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceDown)
        {
             txtTitle.frame =CGRectMake(0, 0, 680, 100);
        }
        if([[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeRight)
        {
             txtTitle.frame =CGRectMake(0, 0, 590, 100);
        }
        txtTitle.font = [UIFont systemFontOfSize:17];
        txtTitle.placeholder  = @"Broadcast Message";
        txtTitle.textColor = [self toUIColor:@"003366"];
        txtTitle.backgroundColor = [UIColor clearColor];
        txtTitle.delegate = self;
        //txtTitle.scrollEnabled = YES;
        txtTitle.textAlignment = UITextAlignmentLeft;
        
        [cell.contentView addSubview:txtTitle];
        [txtTitle release];
    }
    else
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        if([[UIDevice currentDevice]orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice]orientation] == UIDeviceOrientationPortraitUpsideDown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationUnknown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceUp || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceDown)
        {
            [button setFrame:CGRectMake(0.0f, 0.0f,680, 44.0f)];
        }
        if([[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeRight)
        {
            [button setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width-85, 44.0f)];
        }
        // [button setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width-100, 44.0f)];
        
        [button setTitle:@"Send Alert" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [button addTarget:self action:@selector(alertPush) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];

    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // Configure the cell...
    return cell;
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
-(void)alertPush{
    /*
    UIDevice *dev = [UIDevice currentDevice];
    NSString *deviceUuid;
    if ([dev respondsToSelector:@selector(uniqueIdentifier)])
        deviceUuid = dev.uniqueIdentifier;
    else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		id uuid = [defaults objectForKey:@"deviceUuid"];
		if (uuid)
			deviceUuid = (NSString *)uuid;
		else {
			CFStringRef cfUuid = CFUUIDCreateString(NULL, CFUUIDCreate(NULL));
			deviceUuid = (NSString *)cfUuid;
			CFRelease(cfUuid);
			[defaults setObject:deviceUuid forKey:@"deviceUuid"];
        }
    }
    
    NSString *strMessage=txtTitle.text;
    strMessage=[strMessage stringByReplacingOccurrencesOfString:@"\n" withString:@"%20"]; 
    strMessage=[strMessage stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    
    deviceUuid = [deviceUuid lowercaseString];
    
    NSString *body=[NSString stringWithFormat:@"message=%@&dv=%@",strMessage,deviceUuid];
    // NSString *body1=[NSString stringWithFormat:@"message=%@&dv=%@",strMessage,@"6dcbeef1300c6e390562e1f889891d0694864d1d"];
    NSLog(@"%@",body);
    NSMutableString *httpBodyString;
    NSURL *url;
    NSMutableString *urlString;
	
    httpBodyString=[[NSMutableString alloc] initWithString:body];
    urlString=[[NSMutableString alloc] initWithString:@"http://meta-x.com/kpinsight/push.php"];
    
    url=[[NSURL alloc] initWithString:urlString];
    [urlString release];
	
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    [url release];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
    [httpBodyString release];
	
    NSError *myerr = nil;
    NSURLConnection *conn = [[[NSURLConnection alloc]initWithRequest:urlRequest delegate:self] autorelease];
    if(conn)
    {
        NSLog(@"Connection Successful");
    }
    else
    {
        NSLog(@"Connection could not be made");
    }
    
    NSData *returnData = [[ NSURLConnection sendSynchronousRequest: urlRequest returningResponse: nil error: &myerr ] autorelease];
    NSString *returnDataString = [[[[NSString alloc] initWithData:returnData encoding: NSUTF8StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] autorelease];*/	
	
    // NSLog(@"%@=%d",returnDataString, [returnDataString length]);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"NOTE" message:@"As an administrator, your alert message has been sent to all users." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
}

-(void)config{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"NOTE" message:@"A new account request for KP Insight has been sent. We will inform you upon completion." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
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
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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
}

@end
