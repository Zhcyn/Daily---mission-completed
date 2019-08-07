#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface JSDSelectedImageView : UIView
@property (strong, nonatomic, nullable) UIButton *lastButton; 
- (void)setupLastButton:(NSInteger)imageIndex;
@end
NS_ASSUME_NONNULL_END
