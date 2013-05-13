//
//  TextViewWithHolder.h
//  SASConferenceIndex
//
//  Created by Phan Quang Ha on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewWithHolder : UITextView
{
    NSString *placeholder;
    UIColor *placeholderColor;
    @private UILabel *placeHolderLabel;
}
   

@property (nonatomic, retain) UILabel   *placeHolderLabel;
@property (nonatomic, retain) NSString  *placeholder;
@property (nonatomic, retain) UIColor   *placeholderColor;

- (void) textChanged:(NSNotification*)notification;

@end

