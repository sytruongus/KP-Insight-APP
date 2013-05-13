//
//  ScreenShotViewController.m
//  CR2012
//
//  Created by Thanh Huynh on 1/14/12.
//  Copyright (c) 2012 MetaXceed. All rights reserved.
//

#import "ScreenShotViewController.h"
#import "Reachability.h"
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"
#import "MGSplitCornersView.h"
#import "MyLineDrawingView.h"

@implementation ScreenShotViewController
@synthesize image,drawImage,scrollView,isLandscape;
static NSString *isLandscape1;
static NSString *tabName;
static NSString *Title;
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
- (void)viewWillAppear:(BOOL)animated
{
    
	[super viewWillAppear:animated];
    
	
}
- (UIImage *)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    
    return cropped;
    
    
}

-(void)showImage
{
   
    UIImage *imageRotate=self.image;
    imageRotate=[self resizeImage:imageRotate width:728 height:971];
    NSString *str=[ScreenShotViewController getLandscape];
    //  NSString *str1=[ScreenShotViewController getTitle];
//    NSLog(@"%@",str1);
    
   

        if ([str isEqualToString:@"Protrait"]) {
            
             
            imageRotate=[self imageByCropping:imageRotate toRect:CGRectMake(0, 20, imageRotate.size.width, imageRotate.size.height)];
            
            
            drawImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, imageRotate.size.width, imageRotate.size.height)];
            
        }
        else if ([str isEqualToString:@"PortraitUpsideDown"]) {
            
             
            imageRotate=[self imageByCropping:imageRotate toRect:CGRectMake(0,0, imageRotate.size.width, imageRotate.size.height-20)];
            
            imageRotate = [UIImage imageWithCGImage:imageRotate.CGImage scale:imageRotate.scale orientation:UIImageOrientationDown];
            // imageRotate=[self imageByCropping:imageRotate toRect:CGRectMake(20, 0, imageRotate.size.width, imageRotate.size.height)];
            drawImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageRotate.size.width, imageRotate.size.height)];
            
            
        }
        else if ([str isEqualToString:@"LandscapeLeft"])
        {
            
            imageRotate=[self imageByCropping:imageRotate toRect:CGRectMake(0, 0, imageRotate.size.width-20, imageRotate.size.height)];
            
            imageRotate = [UIImage imageWithCGImage:imageRotate.CGImage scale:imageRotate.scale orientation:UIImageOrientationLeft];
            // imageRotate=[self imageByCropping:imageRotate toRect:CGRectMake(20, 0, imageRotate.size.width, imageRotate.size.height)];
            drawImage = [[UIImageView alloc] initWithFrame:CGRectMake(27, 0, imageRotate.size.width, imageRotate.size.height)];
            
            
            
            
            
        }
        else  if ([str isEqualToString:@"LandscapeRight"])
        {
            
            
            imageRotate=[self imageByCropping:imageRotate toRect:CGRectMake(20, 0, imageRotate.size.width, imageRotate.size.height)];
            imageRotate = [UIImage imageWithCGImage:imageRotate.CGImage scale:imageRotate.scale orientation:UIImageOrientationLeft];
            
            drawImage = [[UIImageView alloc] initWithFrame:CGRectMake(27, 0, imageRotate.size.width, imageRotate.size.height)];
            
            
        }
    else
    {
        imageRotate=[self imageByCropping:imageRotate toRect:CGRectMake(0, 20, imageRotate.size.width, imageRotate.size.height)];
        
        
        drawImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, imageRotate.size.width, imageRotate.size.height)];
    }
             
    drawImage.image=imageRotate;
   
    [self.view addSubview:drawImage];
        
    [self initImage];
        
        
        
    
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.navigationItem.title=@"Screen Capture for Email";
        
    
   // [self showImage];
    
    
    
    
    
    
    
    UIBarButtonItem  *btnSend =[[UIBarButtonItem alloc] 
                                initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(sendMail)];
    
    
    self.navigationItem.rightBarButtonItem=btnSend;
   
    [btnSend release];
    UIImage *imageRotate=self.image;
    imageRotate=[self resizeImage:imageRotate width:728 height:971];
    NSString *str=[ScreenShotViewController getLandscape];
    //  NSString *str1=[ScreenShotViewController getTitle];
    //    NSLog(@"%@",str1);
    
    
    
    if ([str isEqualToString:@"Protrait"]) {
        
        
        imageRotate=[self imageByCropping:imageRotate toRect:CGRectMake(0, 20, imageRotate.size.width, imageRotate.size.height)];
        
               
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *pngFilePath = [NSString stringWithFormat:@"%@/screenshoot.png",docDir];
        NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(imageRotate)];
        [data1 writeToFile:pngFilePath atomically:YES];
        
        MyLineDrawingView *drawScreen=[[MyLineDrawingView alloc]initWithFrame:CGRectMake(20, 0,imageRotate.size.width, imageRotate.size.height)];
        [self.view addSubview:drawScreen];
        [drawScreen release];  
    }
    else  if ([str isEqualToString:@"LandscapeLeft"])
    {
        
        
        imageRotate=[self imageByCropping:imageRotate toRect:CGRectMake(0, 0, imageRotate.size.width-20, imageRotate.size.height)];
       // imageRotate = [UIImage imageWithCGImage:imageRotate.CGImage scale:imageRotate.scale orientation:UIImageOrientationLeft];
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *pngFilePath = [NSString stringWithFormat:@"%@/screenshoot.png",docDir];
        NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(imageRotate)];
        [data1 writeToFile:pngFilePath atomically:YES];
     
        MyLineDrawingView *drawScreen=[[MyLineDrawingView alloc] initWithFrame:CGRectMake(135 +23, -135,imageRotate.size.width, imageRotate.size.height)];
        [self.view addSubview:drawScreen];
        [drawScreen release]; 
        
    }
    else
    {
        imageRotate=[self imageByCropping:imageRotate toRect:CGRectMake(0, 20, imageRotate.size.width, imageRotate.size.height)];
              
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
       
        NSString *pngFilePath = [NSString stringWithFormat:@"%@/screenshoot.png",docDir];
        NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(imageRotate)];
        [data1 writeToFile:pngFilePath atomically:YES];

        MyLineDrawingView *drawScreen=[[MyLineDrawingView alloc]initWithFrame:CGRectMake(20, 0,imageRotate.size.width, imageRotate.size.height)];
        [self.view addSubview:drawScreen];
        [drawScreen release];  
    }

    
}
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
   
     
   
      
    
}

-(UIImage *)resizeImage:(UIImage *)image width:(int)width height:(int)height {
	
	CGImageRef imageRef = [image CGImage];
	CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
	
	if (alphaInfo == kCGImageAlphaNone)
        alphaInfo = kCGImageAlphaNoneSkipLast;
	
	CGContextRef bitmap = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), 4 * width, CGImageGetColorSpace(imageRef), alphaInfo);
	CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), imageRef);
	CGImageRef ref = CGBitmapContextCreateImage(bitmap);
	UIImage *result = [UIImage imageWithCGImage:ref];
	
	CGContextRelease(bitmap);
	CGImageRelease(ref);
	
	return result;	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
      
    return  YES;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        
        NSLog(@"Button 1 was selected. %d",buttonIndex);
        if (buttonIndex==0) {
            
           // UIImage *img = [UIImage imageNamed:@"ImageName.png"];  
            
            // Request to save the image to camera roll
            UIImageWriteToSavedPhotosAlbum(drawImage.image, self, 
                                           @selector(image:didFinishSavingWithError:contextInfo:), nil);
            
        }
        
        
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error 
contextInfo:(void *)contextInfo
    {
        // Was there an error?
        if (error != NULL)
        {
            // Show error message...
            
        }
        else  // No errors
        {
            // Show message image successfully saved
        }
    }
    
    
-(void)sendMail{
     UIImage *imageRotate=[self screenshot];
     NSString *str2=[ScreenShotViewController getLandscape];
     if ([str2 isEqualToString:@"LandscapeLeft"])
    {
        
        imageRotate=[self imageByCropping:imageRotate toRect:CGRectMake(0, 0, imageRotate.size.width-20, imageRotate.size.height)];
        
        imageRotate = [UIImage imageWithCGImage:imageRotate.CGImage scale:imageRotate.scale orientation:UIImageOrientationLeft];
        // imageRotate=[self imageByCropping:imageRotate toRect:CGRectMake(20, 0, imageRotate.size.width, imageRotate.size.height)];
        drawImage = [[UIImageView alloc] initWithFrame:CGRectMake(27, 0, imageRotate.size.width, imageRotate.size.height)];
        
        
        drawImage.image=imageRotate;
        
        [self.view addSubview:drawImage];
        
        [self initImage];
        
        
    }
   

    
    NetworkStatus internetStatus = [[Reachability reachabilityWithHostName:@"google.com"] currentReachabilityStatus];
    
	if ((internetStatus != kReachableViaWiFi) && (internetStatus != kReachableViaWWAN)) {
        
        NSString *str=[NSString stringWithFormat:@"You do not currently have Internet connection. Do you wish to save the screenshot into your camera roll?"];
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"WARNING"
														  message:str
														 delegate:nil
												cancelButtonTitle:@"OK"
												otherButtonTitles:nil];
		[message addButtonWithTitle:@"Cancel"];
		[message show];
		message.delegate=self;
		
		[message release];
        
    }
    else
    {
    
     if ([MFMailComposeViewController canSendMail] == NO) return;
     
        NSString *str1=[ScreenShotViewController getLandscape];
        //  NSString *str1=[ScreenShotViewController getTitle];
        //    NSLog(@"%@",str1);
        
        NSData *data;
        UIImage *imageSend=[self screenshot];
        
        if ([str1 isEqualToString:@"LandscapeLeft"]) {
            /*
            
            imageSend = [UIImage imageWithCGImage:imageSend.CGImage scale:imageSend.scale orientation:UIImageOrientationLeft];
             drawImage = [[UIImageView alloc] initWithFrame:CGRectMake(27, 0, imageSend.size.width, imageSend.size.height)];
             drawImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, imageSend.size.width, imageSend.size.height)];
              [self.view addSubview:drawImage];
             [self initImage];*/
            data=UIImagePNGRepresentation(drawImage.image);
            [drawImage removeFromSuperview];
            
        }
        else
        {
           data =UIImagePNGRepresentation(imageSend); 
        }
                                     
   // NSData *data =UIImagePNGRepresentation(imageSend);

    MFMailComposeViewController *mailComposer = [MFMailComposeViewController new];
    [mailComposer addAttachmentData:data mimeType:@"image/png" fileName:@"screeshoot.png"];
         
        NSString *str=[NSString stringWithFormat:@"KP Report Library: %@",[ScreenShotViewController getTitle]];
     [mailComposer setSubject:str]; // Use the document file name for the subject
     
    // mailComposer.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    // mailComposer.modalPresentationStyle = UIModalPresentationFormSheet;
     
     mailComposer.mailComposeDelegate = self; // Set the delegate
     
     [self presentModalViewController:mailComposer animated:YES];
     
     [mailComposer release]; // Cleanup
        
        
      
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
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	mouseSwiped = NO;
	UITouch *touch = [touches anyObject];
	
	if ([touch tapCount] == 2) {
      //  [self showImage];
		//drawImage.image = nil;
		return;
	}
	lastPoint = [touch locationInView:self.view];
	//lastPoint.y -=0;
    lastPoint.x -=27;
    
    
    
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	mouseSwiped = YES;
	
	UITouch *touch = [touches anyObject];	
	CGPoint currentPoint = [touch locationInView:self.view];
	//currentPoint.y  -=0;
	currentPoint.x -=27;
	
	UIGraphicsBeginImageContext(drawImage.image.size);
	[drawImage.image drawInRect:CGRectMake(0, 0, drawImage.image.size.width,drawImage.image.size.height)];
	CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
	CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 7.0);
	CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
	CGContextBeginPath(UIGraphicsGetCurrentContext());
	CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
	CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
	CGContextStrokePath(UIGraphicsGetCurrentContext());
	drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	lastPoint = currentPoint;
    
	mouseMoved++;
	
	if (mouseMoved == 10) {
		mouseMoved = 0;
	}
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	
	if ([touch tapCount] == 2) {
		// [self showImage];
		return;
	}
	
	
	if(!mouseSwiped) {
		UIGraphicsBeginImageContext(drawImage.image.size);
		[drawImage.image drawInRect:CGRectMake(0, 0,drawImage.image.size.width,drawImage.image.size.height)];
		CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
		CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 7.0);
		CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
		CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextStrokePath(UIGraphicsGetCurrentContext());
		CGContextFlush(UIGraphicsGetCurrentContext());
		drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
	}
}*/
-(void)initImage
{
    UIGraphicsBeginImageContext(drawImage.image.size);
    [drawImage.image drawInRect:CGRectMake(0, 0,drawImage.image.size.width,drawImage.image.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 0.1);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(),0, 0);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 0, 0);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    CGContextFlush(UIGraphicsGetCurrentContext());
    drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    // switchng the result  
    switch (result) {  
        case MFMailComposeResultCancelled:  
            NSLog(@"Mail send canceled.");  
            /* 
             Execute your code for canceled event here ... 
             */  
            break;  
        case MFMailComposeResultSaved:  
            NSLog(@"Mail saved.");  
            /* 
             Execute your code for email saved event here ... 
             */  
            break;  
        case MFMailComposeResultSent:  
            NSLog(@"Mail sent.");  
            /* 
             Execute your code for email sent event here ... 
             */  
            break;  
        case MFMailComposeResultFailed:  
            NSLog(@"Mail send error: %@.", [error localizedDescription]);  
            /* 
             Execute your code for email send failed event here ... 
             */  
            break;  
        default:  
            break;  
    }  
    // hide the modal view controller  
    [self dismissModalViewControllerAnimated:YES];  
}
- (void)dealloc {
    [super dealloc];
    [drawImage release];
    [image release];
    [isLandscape release];
    isLandscape=nil;
    
}
+(NSString  *)getLandscape{
        
        
    return isLandscape1;
        
}
+(void)setLandscape:(NSString *)string{
        
        isLandscape1=string;
}
+(NSString  *)getTabName{
    
    
    return tabName;
    
}
+(void)setTabName:(NSString *)string{
    
    tabName=string;
}
+(NSString  *)getTitle{
    
    
    return Title;
    
}
+(void)setTitle:(NSString *)string{
    
    Title=string;
}
@end
