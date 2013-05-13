//
//  DatasetDetailViewController.m
//  newCR
//
//  Created by Thanh Huynh on 11/18/11.
//  Copyright (c) 2011 MetaXceed. All rights reserved.
//

#import "DatasetDetailViewController.h"
#import "ScreenShotViewController.h"
@interface DatasetDetailViewController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureView;
@end
@implementation DatasetDetailViewController

@synthesize datasetSplit,webview;
@synthesize popoverController=_myPopoverController;
@synthesize detailItem;
@synthesize folderName,fileName;
@synthesize btnSearch;

- (void)setDetailItem:(id)newDetailItem
{
    if (detailItem != newDetailItem) {
        [detailItem release];
        detailItem = [newDetailItem retain];
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


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    if([[UIDevice currentDevice]orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice]orientation] == UIDeviceOrientationPortraitUpsideDown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationUnknown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceUp || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceDown)
    {
        textfield.frame=CGRectMake(12,7,695,31);
    }
    if([[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeRight)
    {
        textfield.frame=CGRectMake(12,7,630,31);
    }
    

     
}
- (void)configureView{
    
    NSString* pathFile1=[[NSBundle mainBundle] pathForResource:@"qs.html" ofType:nil];
  //  NSString *path = [[NSBundle mainBundle] pathForResource:@"SearchScript.js" ofType:nil];
//   NSLog(@"%@",path);
        NSURL *url= [[[NSURL alloc]initFileURLWithPath:pathFile1] autorelease];
       
        [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
     
   /*
    self.navigationItem.title=fileName;
    NSArray *temp=[fileName componentsSeparatedByString:@" - "];
    NSString *fileName1=[temp objectAtIndex:0];
    fileName1=[fileName1 lowercaseString];
    NSString *fileName2=[temp objectAtIndex:0];
    fileName1=[fileName1 stringByAppendingString:@".html"];
    fileName2=[fileName2 stringByAppendingString:@".html"];
    NSFileManager *fm=[NSFileManager defaultManager];
    if([folderName isEqualToString:@"Sample Documents"]){
        
        NSString* pathFile1=[[NSBundle mainBundle] pathForResource:fileName1 ofType:nil];
        
         if([fm fileExistsAtPath:pathFile1]){
             NSURL *url= [[[NSURL alloc]initFileURLWithPath:pathFile1] autorelease];
             if (url!=nil) {
            
                 [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
             }
             
         }
         else{
             [self.webview loadHTMLString:@"" baseURL:nil];
         }

    }
    else{
        
        
        NSString *pathFile2=[self applicationDocumentsDirectory];
        
        pathFile2=[pathFile2 stringByAppendingString:@"/"];
        pathFile2=[pathFile2 stringByAppendingString:folderName];
        pathFile2=[pathFile2 stringByAppendingString:@"/"];
        pathFile2=[pathFile2 stringByAppendingString:fileName1];
        
        NSString *pathFile3=[self applicationDocumentsDirectory];
        
        pathFile3=[pathFile3 stringByAppendingString:@"/"];
        pathFile3=[pathFile3 stringByAppendingString:folderName];
        pathFile3=[pathFile3 stringByAppendingString:@"/"];
        pathFile3=[pathFile3 stringByAppendingString:fileName2];
              
        NSURL *url1= [[[NSURL alloc]initFileURLWithPath:pathFile2] autorelease];
        NSURL *url2= [[[NSURL alloc]initFileURLWithPath:pathFile3] autorelease];
        
        if([fm fileExistsAtPath:pathFile2]){
            if (url1!=nil) {
                [self.webview loadRequest:[NSURLRequest requestWithURL:url1]];
               
            }
        }
        if([fm fileExistsAtPath:pathFile3]){
             if (url2!=nil) {
                 [self.webview loadRequest:[NSURLRequest requestWithURL:url2]];
               
             }
         }
         else{
             [self.webview loadHTMLString:@"" baseURL:nil];
         }

     
       
    }*/
    [self.popoverController dismissPopoverAnimated:YES];
}
-(IBAction)search:(id)sender
{
    [textfield resignFirstResponder];
    NSLog(@"%@",textfield.text);
   if([textfield.text length] != 0) {
        
        int num=[webview highlightAllOccurencesOfString:textfield.text];
        if(num==0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WARNING" message:@"The search criteria specified is not found in the current data view." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [alert show];
            [alert release];
        }
   }
    else
    {
    if([textfield.text length] == 0) {
    
        int num=[webview highlightAllOccurencesOfString:@"~`"];
    
    }
    }
    
    
    
	NSLog(@"search");
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if([textfield.text length] != 0) {
        
        int num=[webview highlightAllOccurencesOfString:textfield.text];
        if(num==0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WARNING" message:@"The search criteria specified is not found in the current data view." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [alert show];
            [alert release];
        }
   }
    
}     


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    if([[UIDevice currentDevice]orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice]orientation] == UIDeviceOrientationPortraitUpsideDown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationUnknown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceUp || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceDown)
    {
        textfield.frame=CGRectMake(12,7,695,31);
    }
    if([[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeRight)
    {
        textfield.frame=CGRectMake(12,7,630,31);
    }


       
     
}
- (void)dealloc{
    [super dealloc];
    [webview dealloc];
    [myURl dealloc];
    [myRequest dealloc];
    [pathFile dealloc];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.webview=nil;
    myRequest=nil;
    myRequest=nil;
    pathFile=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
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
    
    if([[UIDevice currentDevice]orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice]orientation] == UIDeviceOrientationPortraitUpsideDown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationUnknown || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceUp || [[UIDevice currentDevice]orientation] == UIDeviceOrientationFaceDown)
    {
        textfield.frame=CGRectMake(12,7,695,31);
    }
    if([[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeRight)
    {
        textfield.frame=CGRectMake(12,7,630,31);
    }
    
    
    
}
- (NSString *)applicationDocumentsDirectory     
{
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
@end
