//
//  CYORootViewController.h
//  Clinical_Reviewer_02
//
//  Created by Thanh Huynh on 11/24/11.
//  Copyright (c) 2011 MetaXceed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYODetailController.h"
#import "MyTreeNode.h"
@interface CYORootViewController : UITableViewController{
    CYODetailController *detail;
    MyTreeNode *treeNode;
    NSMutableArray *jsonArray;
 }
@property(nonatomic,retain) CYODetailController *detail;
@property (nonatomic, retain) NSMutableArray *jsonArray;
@end
