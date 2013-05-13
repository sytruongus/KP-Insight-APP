//
//  SearchWebview.h
//  Conference_Ipad
//
//  Created by Thanh Huynh on 10/17/11.
//  Copyright 2011 MetaXceed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (SearchWebView)

- (NSInteger)highlightAllOccurencesOfString:(NSString*)str;
- (void)removeAllHighlights;

@end