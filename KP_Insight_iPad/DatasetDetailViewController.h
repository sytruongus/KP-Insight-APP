//
//  DatasetDetailViewController.h
//  newCR
//
//  Created by Thanh Huynh on 11/18/11.
//  Copyright (c) 2011 MetaXceed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSplitViewController.h"
@interface DatasetDetailViewController : UIViewController<MGSplitViewControllerDelegate>
{
    UISplitViewController  *datasetSplit;
    id detailItem;
    
    //=======
    NSString *folderName;
    NSString *fileName;
    NSURL *myURl;
     NSURLRequest *myRequest;
    IBOutlet UIWebView   *webview;
    	IBOutlet UITextField *textfield;
    IBOutlet UIBarButtonItem  *btnSearch;
    NSString *pathFile;
    NSString *isLandscape;
    
    
}
@property(nonatomic,retain) UISplitViewController  *datasetSplit;
@property (nonatomic, retain) id detailItem;
@property (nonatomic, retain)  NSString *folderName;
@property (nonatomic, retain)  NSString *fileName;
@property (nonatomic, retain)  IBOutlet UIWebView   *webview;
@property (nonatomic, retain)   UIBarButtonItem  *btnSearch;
-(IBAction)search:(id)sender;
-(IBAction)clear:(id)sender;
- (void)configureView;
@end
