#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIView (JSDFrame)
- (CGFloat)jsd_left;
- (void)jsd_setleft:(CGFloat)x;
- (CGFloat)jsd_top;
- (void)jsd_settop:(CGFloat)y;
- (CGFloat)jsd_right;
- (void)jsd_setright:(CGFloat)right;
- (CGFloat)jsd_bottom;
- (void)jsd_setbottom:(CGFloat)bottom;
- (CGFloat)jsd_width;
- (void)jsd_setwidth:(CGFloat)width;
- (CGFloat)jsd_height;
- (void)jsd_setheight:(CGFloat)height;
- (CGPoint)jsd_origin;
- (void)jsd_setorigin:(CGPoint)origin;
- (CGSize)jsd_size;
- (void)jsd_setsize:(CGSize)size;
- (CGFloat)jsd_centerX;
- (void)setcenterX:(CGFloat)centerX;
- (CGFloat)jsd_centerY;
- (void)setcenterY:(CGFloat)centerY;
@end
NS_ASSUME_NONNULL_END
