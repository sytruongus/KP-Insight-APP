//
//  CYODetailController.h
//  Clinical_Reviewer_02
//
//  Created by Thanh Huynh on 11/24/11.
//  Copyright (c) 2011 MetaXceed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSplitViewController.h"
#import "TextViewWithHolder.h"
@interface ConfigDetailController : UITableViewController<MGSplitViewControllerDelegate,UITextViewDelegate>{
    id  detailItem;
    TextViewWithHolder          *txtTitle;
}
@property(nonatomic,retain) id  detailItem;
-(UIColor *) toUIColor: (NSString *) stringToConvert ;
@end
