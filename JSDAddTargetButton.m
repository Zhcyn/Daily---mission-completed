#import "JSDAddTargetButton.h"
#import <CYLTabBarController.h>
@implementation JSDAddTargetButton
+ (id)plusButton {
    JSDAddTargetButton* flatButton = [[JSDAddTargetButton alloc] init];
    [flatButton setImage:[UIImage imageNamed:@"addTarget_item"] forState:UIControlStateNormal];
    flatButton.backgroundColor = [UIColor jsd_mainBlueColor];
    flatButton.layer.masksToBounds = YES;
    flatButton.layer.cornerRadius = 30;
    [flatButton jsd_setsize:CGSizeMake(60, 60)];
    return flatButton;
}
+ (UIViewController *)plusChildViewController {
    JSDAddTargetVC* addVC = [[JSDAddTargetVC alloc] init];
    JSDBaseNavigationController* addTypenavigationVC = [[JSDBaseNavigationController alloc] initWithRootViewController:addVC];
     [addVC cyl_setHideNavigationBarSeparator:YES];
    return addTypenavigationVC;
}
+ (NSUInteger)indexOfPlusButtonInTabBar {
    return 1;
}
+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return 0.1;
}
@end
