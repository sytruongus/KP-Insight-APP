//
//  AppDelegate.m
//  TreeView
//
//  Created by Thanh Huynh on 5/15/12.
//  Copyright (c) 2012 MetaXceed. All rights reserved.
//

#import "AppDelegate.h"
#import "MGSplitCornersView.h"
#import "KPRLDetailController.h"
#import "KPRLRootViewController.h"
#import "KPMDetailController.h"
#import "KPMRootViewController.h"
#import "CYODetailController.h"
#import "CYORootViewController.h"
#import "HTMDetailController.h"
#import "HTMRootViewController.h"
#import "DatasetDetailViewController.h"
#import "ConfigViewController.h"
#import "ConfigDetailController.h"
#import "CKPRLRootViewController.h"
#import "ScreenShotViewController.h"
@implementation AppDelegate

@synthesize window = _window,tabBarController;

- (void)dealloc
{
    [_window release];
    [tabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
        
    // Add registration for remote notifications
	[[UIApplication sharedApplication] 
     registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
	
	// Clear application badge when app launches
	application.applicationIconBadgeNumber = 0;
    
    // Override point for customization after application launch.
    UIViewController *view = [[UIViewController alloc]init];
    background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    background.image = [UIImage imageNamed:@"Default.png"];
    [self.window addSubview:background];
    
    
    indicatorView = [[UIActivityIndicatorView alloc]init];
    indicatorView.frame = CGRectMake(275.0f, 645.0f, 97.0f, 97.0f);
    indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.window addSubview:indicatorView];
    [indicatorView startAnimating];
    
    CGRect label = CGRectMake(355.0f, 645.0f, 150.0f, 100.0f);
	lbLoading = [[UILabel alloc] initWithFrame:label];
	lbLoading.textColor = [UIColor whiteColor];
    lbLoading.font = [UIFont fontWithName:@"AMHelveticaNeue" size:19];
    lbLoading.backgroundColor =[UIColor clearColor];
	[lbLoading setText:@"Loading ..."];
	[self.window addSubview:lbLoading];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(fadeScreen) userInfo:nil repeats:NO];
    self.window.rootViewController = view;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    
    return YES;
}
-(void)fadeScreen
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishFade)];
    self.window.alpha = 0.0;
    [UIView commitAnimations];
}

-(void)finishFade
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    self.window.alpha = 1.0;
    [UIView commitAnimations];
    [background removeFromSuperview];
    
    tabBarController=[[UITabBarController alloc]init] ;
    //*********************************
    //KPM
    //*********************************
    MGSplitViewController *KPMSplit=[[[MGSplitViewController alloc]init] autorelease];
    KPMRootViewController  *KPMRoot=[[KPMRootViewController  alloc]initWithNibName:@"KPMRootViewController" bundle:nil];
    KPMDetailController   *KPMDetail=[[KPMDetailController alloc]initWithNibName:@"KPMDetailController" bundle:nil];
    // KPRLDetail.KPRLSplit=KPRLSplit;
    KPMRoot.detail=KPMDetail;
    KPMSplit.delegate=KPMDetail;
    
    UINavigationController  *KPMRootnav=[[[UINavigationController alloc]initWithRootViewController:KPMRoot] autorelease];
    UINavigationController  *KPMDetailnav=[[[UINavigationController alloc]initWithRootViewController:KPMDetail] autorelease];
    
    KPMSplit.viewControllers=[NSArray arrayWithObjects:KPMRootnav,KPMDetailnav,nil];
    KPMSplit.tabBarItem.title=@"KP Metrics";
    KPMSplit.tabBarItem.image=[UIImage imageNamed:@"chart.png"];
    [KPMRoot release];
    [KPMDetail release];
    
    
    // Override point for customization after application launch.
    //*********************************
    //KPRL
    //*********************************
    
    MGSplitViewController *KPRLSplit=[[[MGSplitViewController alloc]init] autorelease];
    KPRLRootViewController  *KPRLRoot=[[KPRLRootViewController  alloc]initWithNibName:@"KPRLRootViewController" bundle:nil];
    DatasetDetailViewController   *KPRLDetail=[[DatasetDetailViewController alloc]initWithNibName:@"DatasetDetailViewController" bundle:nil];
    // KPRLDetail.KPRLSplit=KPRLSplit;
    KPRLRoot.detail=KPRLDetail;
    KPRLSplit.delegate=KPRLDetail;
    
    UINavigationController  *KPRLRootnav=[[[UINavigationController alloc]initWithRootViewController:KPRLRoot] autorelease];
    UINavigationController  *KPRLDetailnav=[[[UINavigationController alloc]initWithRootViewController:KPRLDetail] autorelease];
    
    KPRLSplit.viewControllers=[NSArray arrayWithObjects:KPRLRootnav,KPRLDetailnav,nil];
    KPRLSplit.tabBarItem.title=@"KP Report Library";
    KPRLSplit.tabBarItem.image=[UIImage imageNamed:@"report.png"];
    [KPRLRoot release];
    [KPRLDetail release];
    
    
    
    //*********************************
    //CYO
    //*********************************
    
    MGSplitViewController *CYOSplit=[[[MGSplitViewController alloc]init] autorelease];
    CYORootViewController  *CYORoot=[[CYORootViewController  alloc]initWithNibName:@"CYORootViewController" bundle:nil];
    CYODetailController   *CYODetail=[[CYODetailController alloc]initWithNibName:@"CYODetailController" bundle:nil];
    // KPRLDetail.KPRLSplit=KPRLSplit;
    CYORoot.detail=CYODetail;
    CYOSplit.delegate=CYODetail;
    
    UINavigationController  *CYORootnav=[[[UINavigationController alloc]initWithRootViewController:CYORoot] autorelease];
    UINavigationController  *CYODetailnav=[[[UINavigationController alloc]initWithRootViewController:CYODetail] autorelease];
    
    CYOSplit.viewControllers=[NSArray arrayWithObjects:CYORootnav,CYODetailnav,nil];
    CYOSplit.tabBarItem.title=@"Create Your Own";
    CYOSplit.tabBarItem.image=[UIImage imageNamed:@"user.png"];
    [CYORoot release];
    [CYODetail release];
    
    //*********************************
    //HTM
    //*********************************
    
    MGSplitViewController *HTMSplit=[[[MGSplitViewController alloc]init] autorelease];
    HTMRootViewController  *HTMRoot=[[HTMRootViewController  alloc]initWithNibName:@"HTMRootViewController" bundle:nil];
    HTMDetailController   *HTMDetail=[[HTMDetailController alloc]initWithNibName:@"HTMDetailController" bundle:nil];
    // KPRLDetail.KPRLSplit=KPRLSplit;
    HTMRoot.detail=HTMDetail;
    HTMSplit.delegate=HTMDetail;
    
    UINavigationController  *HTMRootnav=[[[UINavigationController alloc]initWithRootViewController:HTMRoot] autorelease];
    UINavigationController  *HTMDetailnav=[[[UINavigationController alloc]initWithRootViewController:HTMDetail] autorelease];
    
    HTMSplit.viewControllers=[NSArray arrayWithObjects:HTMRootnav,HTMDetailnav,nil];
    HTMSplit.tabBarItem.title=@"HTM";
    HTMSplit.tabBarItem.image=[UIImage imageNamed:@"htm.png"];
    [HTMRoot release];
    [HTMDetail release];
    
    ScreenShotViewController *ScreenShotdetail=[[ScreenShotViewController alloc]initWithNibName:@"ScreenShotViewController" bundle:nil];
    
    UINavigationController *navScreenShot=[[[UINavigationController alloc]initWithRootViewController:ScreenShotdetail] autorelease];
    
    navScreenShot.tabBarItem.title=@"Snapshot";
    navScreenShot.tabBarItem.image = [UIImage imageNamed:@"capture.png"];
    
    
    ConfigViewController *config=[[ConfigViewController alloc]initWithNibName:@"ConfigViewController" bundle:nil];
    
    UINavigationController *navConfig=[[[UINavigationController alloc]initWithRootViewController:config] autorelease];
    
    navConfig.tabBarItem.title=@"Configure";
    navConfig.tabBarItem.image = [UIImage imageNamed:@"gear.png"];
    
    
    tabBarController.viewControllers=[NSArray arrayWithObjects:KPMSplit,KPRLSplit,CYOSplit,HTMSplit,navScreenShot,navConfig,nil];
    
    
    
    
    
    
    tabBarController.view.backgroundColor=[UIColor whiteColor];
    tabBarController.delegate=self;
    self.window.rootViewController = self.tabBarController;
    [self.window addSubview:tabBarController.view];

    

}

-(BOOL)tabBarController:(UITabBarController *)tbController shouldSelectViewController:(UIViewController *)viewController{
    
    if (viewController == [tbController.viewControllers objectAtIndex:0] )
    {
        oldIndex=0;
        flag=YES;
    }
    if (viewController == [tbController.viewControllers objectAtIndex:1] )
    {
        oldIndex=1;
        flag=YES;
    }
    if (viewController == [tbController.viewControllers objectAtIndex:2] )
    {
        oldIndex=2;
        flag=YES;
    }
    if (viewController == [tbController.viewControllers objectAtIndex:3] )
    {
        oldIndex=3;
        flag=YES;
    }
    else
    {
        flag=NO;
    }
    
    a=[self screenshot];
    
    return YES;
    
}
- (void)tabBarController:(UITabBarController *)tbController didSelectViewController:(UIViewController *)viewController
{
    
    
  
    
    if (viewController == [tbController.viewControllers objectAtIndex:5] )
    {
        if (oldIndex==0) {
            
            MGSplitViewController *KPRLSplit=[[[MGSplitViewController alloc]init] autorelease];
            CKPRLRootViewController  *KPRLRoot=[[CKPRLRootViewController  alloc]initWithNibName:@"CKPRLRootViewController" bundle:nil];
            ConfigDetailController   *KPRLDetail=[[ConfigDetailController alloc]initWithNibName:@"ConfigDetailController" bundle:nil];
            // KPRLDetail.KPRLSplit=KPRLSplit;
            KPRLRoot.detail=KPRLDetail;
            KPRLSplit.delegate=KPRLDetail;
            
            UINavigationController  *KPRLRootnav=[[[UINavigationController alloc]initWithRootViewController:KPRLRoot] autorelease];
            UINavigationController  *KPRLDetailnav=[[[UINavigationController alloc]initWithRootViewController:KPRLDetail] autorelease];
            KPRLSplit.viewControllers=[NSArray arrayWithObjects:KPRLRootnav,KPRLDetailnav,nil];
            KPRLSplit.tabBarItem.title=@"Configure";
            KPRLSplit.tabBarItem.image = [UIImage imageNamed:@"gear.png"];
            // tabBarController.viewControllers inser
            // 
            NSMutableArray *arr=[tbController viewControllers];
            [arr replaceObjectAtIndex:5 withObject:KPRLSplit];
            tabBarController.viewControllers=arr;
            
        }
        else if(oldIndex==1)
        {
            MGSplitViewController *KPRLSplit=[[[MGSplitViewController alloc]init] autorelease];
            CKPRLRootViewController  *KPRLRoot=[[CKPRLRootViewController  alloc]initWithNibName:@"CKPRLRootViewController" bundle:nil];
            ConfigDetailController   *KPRLDetail=[[ConfigDetailController alloc]initWithNibName:@"ConfigDetailController" bundle:nil];
            // KPRLDetail.KPRLSplit=KPRLSplit;
            KPRLRoot.detail=KPRLDetail;
            KPRLSplit.delegate=KPRLDetail;
            
            UINavigationController  *KPRLRootnav=[[[UINavigationController alloc]initWithRootViewController:KPRLRoot] autorelease];
            UINavigationController  *KPRLDetailnav=[[[UINavigationController alloc]initWithRootViewController:KPRLDetail] autorelease];
            KPRLSplit.viewControllers=[NSArray arrayWithObjects:KPRLRootnav,KPRLDetailnav,nil];
            KPRLSplit.tabBarItem.title=@"Configure";
            KPRLSplit.tabBarItem.image = [UIImage imageNamed:@"gear.png"];
            // tabBarController.viewControllers inser
            // 
            NSMutableArray *arr=[tbController viewControllers];
            [arr replaceObjectAtIndex:5 withObject:KPRLSplit];
            tabBarController.viewControllers=arr;
        }
        else if(oldIndex==2)
        {
            
            MGSplitViewController *KPRLSplit=[[[MGSplitViewController alloc]init] autorelease];
            CKPRLRootViewController  *KPRLRoot=[[CKPRLRootViewController  alloc]initWithNibName:@"CKPRLRootViewController" bundle:nil];
            ConfigDetailController   *KPRLDetail=[[ConfigDetailController alloc]initWithNibName:@"ConfigDetailController" bundle:nil];
            // KPRLDetail.KPRLSplit=KPRLSplit;
            KPRLRoot.detail=KPRLDetail;
            KPRLSplit.delegate=KPRLDetail;
            
            UINavigationController  *KPRLRootnav=[[[UINavigationController alloc]initWithRootViewController:KPRLRoot] autorelease];
            UINavigationController  *KPRLDetailnav=[[[UINavigationController alloc]initWithRootViewController:KPRLDetail] autorelease];
            KPRLSplit.viewControllers=[NSArray arrayWithObjects:KPRLRootnav,KPRLDetailnav,nil];
            KPRLSplit.tabBarItem.title=@"Configure";
            KPRLSplit.tabBarItem.image = [UIImage imageNamed:@"gear.png"];
            // tabBarController.viewControllers inser
            // 
            NSMutableArray *arr=[tbController viewControllers];
            [arr replaceObjectAtIndex:5 withObject:KPRLSplit];
            tabBarController.viewControllers=arr;
        }
        else if(oldIndex==3)
        {
            MGSplitViewController *KPRLSplit=[[[MGSplitViewController alloc]init] autorelease];
            CKPRLRootViewController  *KPRLRoot=[[CKPRLRootViewController  alloc]initWithNibName:@"CKPRLRootViewController" bundle:nil];
            ConfigDetailController   *KPRLDetail=[[ConfigDetailController alloc]initWithNibName:@"ConfigDetailController" bundle:nil];
            // KPRLDetail.KPRLSplit=KPRLSplit;
            KPRLRoot.detail=KPRLDetail;
            KPRLSplit.delegate=KPRLDetail;
            
            UINavigationController  *KPRLRootnav=[[[UINavigationController alloc]initWithRootViewController:KPRLRoot] autorelease];
            UINavigationController  *KPRLDetailnav=[[[UINavigationController alloc]initWithRootViewController:KPRLDetail] autorelease];
            KPRLSplit.viewControllers=[NSArray arrayWithObjects:KPRLRootnav,KPRLDetailnav,nil];
            KPRLSplit.tabBarItem.title=@"Configure";
            KPRLSplit.tabBarItem.image = [UIImage imageNamed:@"gear.png"];
            // tabBarController.viewControllers inser
            // 
            NSMutableArray *arr=[tbController viewControllers];
            [arr replaceObjectAtIndex:5 withObject:KPRLSplit];
            tabBarController.viewControllers=arr;
        }
        
    }
    if (viewController == [tbController.viewControllers objectAtIndex:4] )
    {
        // if (flag) {
        ScreenShotViewController *ScreenShotdetail=[[ScreenShotViewController alloc]initWithNibName:@"ScreenShotViewController" bundle:nil];
        
        //ScreenShotdetail.navigationItem.title=[ScreenShotViewController getTabName];
        UINavigationController *navScreenShot=[[[UINavigationController alloc]initWithRootViewController:ScreenShotdetail] autorelease];
        navScreenShot.tabBarItem.title=@"Snapshot";
        navScreenShot.tabBarItem.image = [UIImage imageNamed:@"capture.png"];
        ScreenShotdetail.image=a;
        [ScreenShotdetail release];
        // tabBarController.viewControllers inser
        // 
        NSMutableArray *arr=[tbController viewControllers];
        [arr replaceObjectAtIndex:4 withObject:navScreenShot];
        tabBarController.viewControllers=arr;
      //       flag=NO;
      //   }
    }
    
    
}
- (UIImage*)screenshot 
{
    
    
    
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return screenshot;
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)devToken
{
    
#if !TARGET_IPHONE_SIMULATOR
	// Get Bundle Info for Remote Registration (handy if you have more than one app)
	NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
	NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	
	// Check what Notifications the user has turned on.  We registered for all three, but they may have manually disabled some or all of them.
	NSUInteger rntypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
	
	// Set the defaults to disabled unless we find otherwise...
	NSString *pushBadge = (rntypes & UIRemoteNotificationTypeBadge) ? @"enabled" : @"disabled";
	NSString *pushAlert = (rntypes & UIRemoteNotificationTypeAlert) ? @"enabled" : @"disabled";
	NSString *pushSound = (rntypes & UIRemoteNotificationTypeSound) ? @"enabled" : @"disabled";	
	
	// Get the users Device Model, Display Name, Unique ID, Token & Version Number
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
	NSString *deviceName = dev.name;
	NSString *deviceModel = dev.model;
	NSString *deviceSystemVersion = dev.systemVersion;
	
	// Prepare the Device Token for Registration (remove spaces and < >)
	NSString *deviceToken = [[[[devToken description] 
                               stringByReplacingOccurrencesOfString:@"<"withString:@""] 
                              stringByReplacingOccurrencesOfString:@">" withString:@""] 
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
	//dv=deviceToken;
	// Build URL String for Registration
	// !!! CHANGE "www.mywebsite.com" TO YOUR WEBSITE. Leave out the http://
	// !!! SAMPLE: "secure.awesomeapp.com"
	NSString *host = @"www.meta-x.com/kpinsight";
	
	// !!! CHANGE "/apns.php?" TO THE PATH TO WHERE apns.php IS INSTALLED 
	// !!! ( MUST START WITH / AND END WITH ? ). 
	// !!! SAMPLE: "/path/to/apns.php?"
	NSString *urlString = [NSString stringWithFormat:@"/apns.php?task=%@&appname=%@&appversion=%@&deviceuid=%@&devicetoken=%@&devicename=%@&devicemodel=%@&deviceversion=%@&pushbadge=%@&pushalert=%@&pushsound=%@", @"register", appName,appVersion, deviceUuid, deviceToken, deviceName, deviceModel, deviceSystemVersion, pushBadge, pushAlert, pushSound];
	
	// Register the Device Data
	// !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
	NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSLog(@"Register URL: %@", url);
	NSLog(@"Return Data: %@", returnData);
    
#endif
    
    // [UIApplication sharedApplication].statusBarHidden = NO;
    
}


/**
 * Failed to Register for Remote Notifications
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	
#if !TARGET_IPHONE_SIMULATOR
	
	NSLog(@"Error in registration. Error: %@", error);
	
#endif
}

/**
 * Remote Notification Received while application was open.
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	
#if !TARGET_IPHONE_SIMULATOR
    
    
	application.applicationIconBadgeNumber = 0;
    
    NSLog(@"remote notification: %@",[userInfo description]);
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
	
    NSString *alert = [apsInfo objectForKey:@"alert"];
    NSLog(@"Received Push Alert: %@", alert);
	
    NSString *sound = [apsInfo objectForKey:@"sound"];
    NSLog(@"Received Push Sound: %@", sound);
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	
    NSString *badge = [apsInfo objectForKey:@"badge"];
    NSLog(@"Received Push Badge: %@", badge);
    
    
    application.applicationIconBadgeNumber =[[apsInfo objectForKey:@"badge"] integerValue];
    
    
    
#endif
}			
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
