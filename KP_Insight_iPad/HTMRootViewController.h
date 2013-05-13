//
//  HTMRootViewController.h
//  Clinical_Reviewer_02
//
//  Created by Thanh Huynh on 11/24/11.
//  Copyright (c) 2011 MetaXceed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTMDetailController.h"
#import "MyTreeNode.h"
@interface HTMRootViewController : UITableViewController{
    HTMDetailController *detail;
    MyTreeNode *treeNode;
    NSMutableArray *jsonArray;
 }
@property(nonatomic,retain) HTMDetailController *detail;
@property (nonatomic, retain) NSMutableArray *jsonArray;
@end
