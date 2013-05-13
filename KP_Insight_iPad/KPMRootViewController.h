//
//  KPMRootViewController.h
//  Clinical_Reviewer_02
//
//  Created by Thanh Huynh on 11/24/11.
//  Copyright (c) 2011 MetaXceed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPMDetailController.h"
#import "MyTreeNode.h"
@interface KPMRootViewController : UITableViewController{
    KPMDetailController *detail;
    MyTreeNode *treeNode;
    NSMutableArray *jsonArray;
 }
@property(nonatomic,retain) KPMDetailController *detail;
@property (nonatomic, retain) NSMutableArray *jsonArray;
@end
