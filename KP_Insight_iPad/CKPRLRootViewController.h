//
//  KPRLRootViewController.h
//  Clinical_Reviewer_02
//
//  Created by Thanh Huynh on 11/24/11.
//  Copyright (c) 2011 MetaXceed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigViewController.h"
#import "MyTreeNode.h"
@interface CKPRLRootViewController : UITableViewController{
    ConfigViewController *detail;
    MyTreeNode *treeNode;
    MyTreeNode *filteredtreeNode;
    NSMutableArray *jsonArray;
     UIView *loadingViewCenter;
    NSMutableArray *searchArray;
    BOOL flagwifi;
    UIView *loadingView;
 }
@property(nonatomic,retain) ConfigViewController *detail;
- (void)showLoadingInViewCenter:(UIView *)view Height:(float)height;
-(UIColor *) toUIColor: (NSString *) stringToConvert  ;
@end
