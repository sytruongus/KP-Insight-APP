//
//  MyTreeViewCell.m
//  MyTreeViewPrototype
//
//  Created by Jon Limjap on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyTreeViewCell.h"

#define IMG_HEIGHT_WIDTH 20
#define CELL_HEIGHT 44
#define SCREEN_WIDTH 320
#define LEVEL_INDENT 32
#define YOFFSET 12
#define XOFFSET 6

@interface MyTreeViewCell (Private)

- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor 
						selectedColor:(UIColor *)selectedColor 
							 fontSize:(CGFloat)fontSize 
								 bold:(BOOL)bold;

@end


@implementation MyTreeViewCell

@synthesize valueLabel, arrowImage,checkImage;
@synthesize level, expanded;

- (id)initWithStyle:(UITableViewCellStyle)style 
	reuseIdentifier:(NSString *)reuseIdentifier 
			  level:(NSUInteger)_level 
		   expanded:(BOOL)_expanded haschild:(BOOL)_haschild {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.level = _level;
		self.expanded = _expanded;
		
		UIView *content = self.contentView;
		
		self.valueLabel = 
			[self newLabelWithPrimaryColor:[UIColor blackColor] 
							 selectedColor:[UIColor whiteColor] 
								  fontSize:16.0 bold:NO];
		self.valueLabel.textAlignment = UITextAlignmentLeft;
		[content addSubview:self.valueLabel];
        
        if (!_haschild) {
            self.arrowImage = 
			[[UIImageView alloc] initWithImage:
             [UIImage imageNamed:@"file" ]];
           
           // self.checkImage = 
			//[[UIImageView alloc] initWithImage:
           //  [UIImage imageNamed:@"checked" ]];
          //  [content addSubview: self.checkImage];
        }
        else
        {
		
		self.arrowImage = 
			[[UIImageView alloc] initWithImage:
				[UIImage imageNamed:self.expanded ? 
				 @"folder_open" : @"folder_close"]];
        }
        arrowImage.backgroundColor=[UIColor clearColor];
		[content addSubview:self.arrowImage];
    }
    return self;
}


#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
	[valueLabel release];
	[arrowImage release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark Other overrides

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
	
    if (!self.editing) {
		
		// get the X pixel spot
        CGFloat boundsX = contentRect.origin.x;
        
        //CGRect imgFrame1;
		//imgFrame1 = CGRectMake(5, 
       //                        YOFFSET, 
       //                        IMG_HEIGHT_WIDTH, 
       //                        IMG_HEIGHT_WIDTH+5);
      //  self.checkImage.frame = imgFrame1;
        
		CGRect frame;
		NSLog(@"%d",self.level);
        if (self.level==0) {
            frame = CGRectMake((boundsX + self.level + 1) * LEVEL_INDENT+5, 
                               0, 
                               SCREEN_WIDTH - (self.level * LEVEL_INDENT)-60, 
                               CELL_HEIGHT);
            self.valueLabel.frame = frame;
            
            CGRect imgFrame;
            imgFrame = CGRectMake(((boundsX + self.level + 1) * LEVEL_INDENT) - (IMG_HEIGHT_WIDTH + XOFFSET)+5, 
                                  YOFFSET, 
                                  IMG_HEIGHT_WIDTH, 
                                  IMG_HEIGHT_WIDTH+5);
            self.arrowImage.frame = imgFrame;
        }
        else if(self.level==1)
        {
            frame = CGRectMake((boundsX + self.level + 1) * LEVEL_INDENT-10, 
                               0, 
                               SCREEN_WIDTH - (self.level * LEVEL_INDENT)-60, 
                               CELL_HEIGHT);
            self.valueLabel.frame = frame;
            
            CGRect imgFrame;
            imgFrame = CGRectMake(((boundsX + self.level + 1) * LEVEL_INDENT) - (IMG_HEIGHT_WIDTH + XOFFSET)-10, 
                                  YOFFSET, 
                                  IMG_HEIGHT_WIDTH, 
                                  IMG_HEIGHT_WIDTH+5);
            self.arrowImage.frame = imgFrame;
        }
        else
        {
            frame = CGRectMake((boundsX + self.level + 1) * LEVEL_INDENT-30, 
						   0, 
						   SCREEN_WIDTH - (self.level * LEVEL_INDENT)-25, 
						   CELL_HEIGHT);
            self.valueLabel.frame = frame;
		
            CGRect imgFrame;
            imgFrame = CGRectMake(((boundsX + self.level + 1) * LEVEL_INDENT) - (IMG_HEIGHT_WIDTH + XOFFSET)-30, 
							  YOFFSET, 
							  IMG_HEIGHT_WIDTH, 
							  IMG_HEIGHT_WIDTH+5);
            self.arrowImage.frame = imgFrame;
        }
        
        
		
	}
}

#pragma mark -
#pragma mark Private category

- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor 
						selectedColor:(UIColor *)selectedColor 
							 fontSize:(CGFloat)fontSize 
								 bold:(BOOL)bold {
    UIFont *font;
    if (bold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }
	
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor whiteColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
	newLabel.numberOfLines = 0;
	
	return newLabel;
}

@end