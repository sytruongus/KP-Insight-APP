//
//  CYODetailController.h
//  Clinical_Reviewer_02
//
//  Created by Thanh Huynh on 11/24/11.
//  Copyright (c) 2011 MetaXceed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSplitViewController.h"
@interface CYODetailController : UITableViewController<MGSplitViewControllerDelegate>{
    id  detailItem;
   
}
@property(nonatomic,retain) id  detailItem;
@end
