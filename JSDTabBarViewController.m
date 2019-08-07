#import "JSDTabBarViewController.h"
#import "JSDAddTargetButton.h"
#import "JSDPublic.h"
@interface JSDTabBarViewController ()
@end
@implementation JSDTabBarViewController
- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -1.5);
    CYLTabBarController* tabBarVC = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers  tabBarItemsAttributes:[self tabBarItemsAttributesForController] imageInsets:imageInsets titlePositionAdjustment:titlePositionAdjustment];
    [self customizeTabBarAppearance:tabBarVC];
    return (self = (JSDTabBarViewController *)tabBarVC);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [JSDAddTargetButton registerPlusButton];
}
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    [tabBarController setTintColor:[UIColor jsd_mainBlueColor]];
}
- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"Standard",
                                                 CYLTabBarItemImage : @"target_item_normal",
                                                 CYLTabBarItemSelectedImage : @"target_item_selected",  
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"Mine",
                                                  CYLTabBarItemImage : @"my_item_normal",
                                                  CYLTabBarItemSelectedImage : @"my_item_selected",
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       ];
    return tabBarItemsAttributes;
}
#pragma mark -- set  && get
- (NSArray *)viewControllers {
    JSDTargetVC *homeViewController = [[JSDTargetVC alloc] init];
    JSDBaseNavigationController *homeNavigationController = [[JSDBaseNavigationController alloc]
                                                  initWithRootViewController:homeViewController];
    [homeViewController cyl_setHideNavigationBarSeparator:YES];
    UIViewController *myCenterVC = [[JSDMyCenterVC alloc] init];
    UIViewController *myNavigationController = [[JSDBaseNavigationController alloc]
                                                  initWithRootViewController:myCenterVC];
    [myCenterVC cyl_setHideNavigationBarSeparator: YES];
    NSArray *viewControllers = @[
                                 homeNavigationController,
                                 myNavigationController,
                                 ];
    return viewControllers;
}
@end
