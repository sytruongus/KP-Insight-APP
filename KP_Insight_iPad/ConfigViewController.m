//
//  ConfigViewController.m
//  KP_Insight_iPad
//
//  Created by Thanh Huynh on 5/21/12.
//  Copyright (c) 2012 MetaXceed. All rights reserved.
//

#import "ConfigViewController.h"

@implementation ConfigViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
   // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return  YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    if (section==0) {
        return 3;
    }
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            cell.textLabel.text = @"Server Name";
            UITextField *lbServerName;
            if([[UIDevice currentDevice]orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice]orientation] == UIDeviceOrientationPortraitUpsideDown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationUnknown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceUp || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceDown)
            {
                lbServerName = [[UITextField alloc]initWithFrame:CGRectMake(130, 14, 160, 40)];
            }
            if([[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeRight)
            {
                lbServerName = [[UITextField alloc]initWithFrame:CGRectMake(130, 14, 320, 40)];
            }
           // lbUserName.delegate = self;
            lbServerName.text = @"";
            lbServerName.autocorrectionType = UITextAutocorrectionTypeNo;
            lbServerName.backgroundColor = [UIColor clearColor];
         //   lbUserName.textColor = [UIColor blueStandardColor:@"15336b"];
            lbServerName.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
            [cell.contentView addSubview:lbServerName];
        }
        else if(indexPath.row==1)
        {
            cell.textLabel.text = @"User Name";
            UITextField *lbUserName;
            if([[UIDevice currentDevice]orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice]orientation] == UIDeviceOrientationPortraitUpsideDown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationUnknown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceUp || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceDown)
            {
                lbUserName = [[UITextField alloc]initWithFrame:CGRectMake(130, 14, 160, 40)];
            }
            if([[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeRight)
            {
                lbUserName = [[UITextField alloc]initWithFrame:CGRectMake(130, 14, 320, 40)];
            }
          //  lbUserName.delegate = self;
           // lbUserName.text = username;
            lbUserName.autocorrectionType = UITextAutocorrectionTypeNo;
            lbUserName.backgroundColor = [UIColor clearColor];
            //lbUserName.textColor = [UIColor blueStandardColor:@"15336b"];
            lbUserName.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
            [cell.contentView addSubview:lbUserName];
        }
        else
        {
            cell.textLabel.text = @"Password";
             UITextField *lbPassword;
            if([[UIDevice currentDevice]orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice]orientation] == UIDeviceOrientationPortraitUpsideDown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationUnknown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceUp || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceDown)
            {
                lbPassword = [[UITextField alloc]initWithFrame:CGRectMake(130, 14, 160, 40)];
            }
            if([[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeRight)
            {
                lbPassword = [[UITextField alloc]initWithFrame:CGRectMake(130, 14, 320, 40)];
            }
           // lbPassword.delegate = self;
           // lbPassword.text = password;
            lbPassword.autocorrectionType = UITextAutocorrectionTypeNo;
            lbPassword.backgroundColor = [UIColor clearColor];
            [lbPassword setSecureTextEntry:YES];
          //  lbPassword.textColor = [UIColor blueStandardColor:@"15336b"];
            lbPassword.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
            [cell.contentView addSubview:lbPassword];
        }
    }
    else
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        if([[UIDevice currentDevice]orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice]orientation] == UIDeviceOrientationPortraitUpsideDown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationUnknown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceUp || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceDown)
        {
             [button setFrame:CGRectMake(0.0f, 0.0f,400, 44.0f)];
        }
        if([[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeRight)
        {
             [button setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width-90, 44.0f)];
        }
       // [button setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width-100, 44.0f)];
        
        [button setTitle:@"Request Account" forState:UIControlStateNormal];
       // button.titleLabel.textColor = [UIColor blackColor forState:UIControlStateNormal]];
        [button setTintColor:[UIColor blackColor]];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];

        // UIFont* boldFont = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];

        [button addTarget:self action:@selector(config) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];

    }
    
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // Configure the cell...
    return cell;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
