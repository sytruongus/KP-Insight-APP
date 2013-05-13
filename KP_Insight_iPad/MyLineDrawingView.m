//
//  MyLineDrawingView.m
//  DrawLines
//
//  Created by Reetu Raj on 11/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyLineDrawingView.h"
#import "ScreenShotViewController.h"
#define degreesToRadian(x) (M_PI * (x) / 180.0)


@implementation MyLineDrawingView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *pngFilePath = [NSString stringWithFormat:@"%@/screenshoot.png",docDir];
       
        UIImage *graphImage = [[UIImage alloc] initWithContentsOfFile: pngFilePath];
        // graphImage = [UIImage imageWithCGImage:graphImage.CGImage scale:graphImage.scale orientation:UIImageOrientationLeft];
       // myImage.image=graphImage;
      //  [self addSubview:myImage];
        
       // UIImage *imageRotate = [UIImage imageWithCGImage:graphImage.CGImage scale:graphImage.scale orientation:UIImageOrientationRight];
      //  UIImage* imageRotate=[self rotate:graphImage radians:90.0];
        UIColor *background = [[UIColor alloc] initWithPatternImage:graphImage];
      //  self.view.backgroundColor = background;
        
       
        self.backgroundColor=background;
        myPath=[[UIBezierPath alloc]init];
        myPath.lineCapStyle=kCGLineCapRound;
        myPath.miterLimit=0;
        myPath.lineWidth=10;
        
        //loadingView.opaque = NO;
      //  loadingView.backgroundColor = [UIColor grayColor];
        //loadingView.alpha = 0.5;
        brushPattern=[UIColor redColor];
        NSString *str=[ScreenShotViewController getLandscape];
        //  NSString *str1=[ScreenShotViewController getTitle];
        //    NSLog(@"%@",str1);
        
        
        
        if ([str isEqualToString:@"LandscapeLeft"]) 
        {
            CGAffineTransform transform = CGAffineTransformMakeRotation(degreesToRadian(-90));

            self.transform = transform;
        }

       // [background release];

        
    }
    return self;
}
- (UIImage *)rotate:(UIImage *)image radians:(float)rads
{
    float newSide = MAX([image size].width, [image size].height);
    CGSize size =  CGSizeMake(newSide, newSide);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, newSide/2, newSide/2);
    CGContextRotateCTM(ctx, rads);
    CGContextDrawImage(UIGraphicsGetCurrentContext(),CGRectMake(-[image size].width/2,-[image size].height/2,size.width, size.height),image.CGImage);
    //CGContextTranslateCTM(ctx, [image size].width/2, [image size].height/2);
    
    UIImage *i = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return i;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [brushPattern setStroke];
    [myPath strokeWithBlendMode:kCGBlendModeNormal alpha:0.5] ;
    //[myPath strokeWithBlendMode:kCGBlendModeOverlay alpha:0.5];
    // Drawing code
    //[myPath stroke];
    
    
    
}

#pragma mark - Touch Methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
    [myPath moveToPoint:[mytouch locationInView:self]];
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
    [myPath addLineToPoint:[mytouch locationInView:self]];
    [self setNeedsDisplay];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    
}

- (void)dealloc
{
    [brushPattern release];
    [super dealloc];
}

@end
