//
//  Copyright (c) SRG. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "UIBezierPath+RTSMediaPlayerUtils.h"

@implementation UIBezierPath (RTSMediaPlayerUtils)

- (UIImage *)rts_imageWithColor:(UIColor *)color
{
    // Adjust bounds to account for extra space needed for lineWidth
    CGFloat width = self.bounds.size.width + self.lineWidth * 2;
    CGFloat height = self.bounds.size.height + self.lineWidth * 2;
    CGRect bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, width, height);

    UIView *view = [[UIView alloc] initWithFrame:bounds];

    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [[UIScreen mainScreen] scale]);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    CGContextRef context = UIGraphicsGetCurrentContext();

    // Translate matrix so that the path will be centered in bounds
    CGContextTranslateCTM(context, -(bounds.origin.x - self.lineWidth), -(bounds.origin.y - self.lineWidth));
    [color set];
    
    [self stroke];
    [self fill];

    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return viewImage;
}

@end
