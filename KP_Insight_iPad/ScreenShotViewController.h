//
//  ScreenShotViewController.h
//  CR2012
//
//  Created by Thanh Huynh on 1/14/12.
//  Copyright (c) 2012 MetaXceed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface ScreenShotViewController : UIViewController<MFMailComposeViewControllerDelegate,UIAlertViewDelegate>{
    IBOutlet UIImageView* drawImage;
    IBOutlet UIScrollView *scrollView;
    UIImage *image;
    CGPoint lastPoint;
    BOOL mouseSwiped;	
	int mouseMoved;
    NSString* isLandscape;
    NSString* Subject;
    UIBezierPath *myPath;
    UIColor *brushPattern;
   
}
@property(nonatomic,retain)UIImageView *drawImage;
@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)UIImage *image;
@property(nonatomic,retain)NSString * isLandscape;
-(UIImage *)resizeImage:(UIImage *)image width:(int)width height:(int)height;
-(void)initImage;
+(NSString  *)getLandscape;
+(void)setLandscape:(NSString *)string;
+(NSString  *)getTabName;
+(void)setTabName:(NSString *)string;
+(NSString  *)getTitle;
+(void)setTitle:(NSString *)string;
@end
