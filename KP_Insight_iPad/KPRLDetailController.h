//
//  KPRLDetailController.h
//  Clinical_Reviewer_02
//
//  Created by Thanh Huynh on 11/24/11.
//  Copyright (c) 2011 MetaXceed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSplitViewController.h"
@interface KPRLDetailController : UITableViewController<MGSplitViewControllerDelegate>{
    id  detailItem;
    NSMutableDictionary *dic;
   
}
@property(nonatomic,retain) id  detailItem;
@property(nonatomic,retain)  NSMutableDictionary *dic;
@end
