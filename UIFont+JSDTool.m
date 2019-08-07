#import "UIFont+JSDTool.h"
static NSString* const kJSDFontName = @"Helvetica Neue";
@implementation UIFont (JSDTool)
+ (UIFont *)jsd_fontSize:(CGFloat)size {
    UIFont* font = [UIFont fontWithName:kJSDFontName size:size];
    return font;
}
@end
