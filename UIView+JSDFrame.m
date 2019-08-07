#import "UIView+JSDFrame.h"
@implementation UIView (JSDFrame)
- (CGFloat)jsd_left {
    return self.frame.origin.x;
}
- (void)jsd_setleft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)jsd_top {
    return self.frame.origin.y;
}
- (void)jsd_settop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)jsd_right {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)jsd_setright:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)jsd_bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)jsd_setbottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)jsd_width {
    return self.frame.size.width;
}
- (void)jsd_setwidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)jsd_height {
    return self.frame.size.height;
}
- (void)jsd_setheight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGPoint)jsd_origin {
    return self.frame.origin;
}
- (void)jsd_setorigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGSize)jsd_size {
    return self.frame.size;
}
- (void)jsd_setsize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGFloat)jsd_centerX {
    return self.center.x;
}
- (void)setcenterX:(CGFloat)jsd_centerX {
    self.center = CGPointMake(jsd_centerX, self.center.y);
}
- (CGFloat)jsd_centerY {
    return self.center.y;
}
- (void)setcenterY:(CGFloat)jsd_centerY  {
    self.center = CGPointMake(self.center.x, jsd_centerY);
}
@end
