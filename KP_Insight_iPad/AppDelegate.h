//
//  AppDelegate.h
//  TreeView
//
//  Created by Thanh Huynh on 5/15/12.
//  Copyright (c) 2012 MetaXceed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder<UIApplicationDelegate,UITabBarControllerDelegate>
{
    UITabBarController *tabBarController;
  
    UIImageView *background;
    UIActivityIndicatorView *indicatorView;
    NSTimer *timer;
    UILabel *lbLoading;
    int oldIndex;
     UIImage *a;
     BOOL flag;
}

@property (strong, nonatomic)IBOutlet UIWindow *window;
@property  (strong, nonatomic)IBOutlet UITabBarController *tabBarController;

@end
