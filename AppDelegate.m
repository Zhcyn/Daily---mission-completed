#import "AppDelegate.h"
#import "JSDTabBarViewController.h"
#import "PermierCircle.h"
#import <IQKeyboardManager.h>
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <AdSupport/AdSupport.h>
@interface AppDelegate ()<JPUSHRegisterDelegate>
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    JSDTabBarViewController* tabbarVC = [[JSDTabBarViewController alloc] init];
    [self configureBoardManager];
    if ([self currentTimeStr] < 1565668785) {
        self.window.rootViewController = tabbarVC;
    }else{
        [[PermierCircle sharedManager] initPermierCircleLaunchOptions:launchOptions window:self.window rootController:tabbarVC switchRoute:0 userUrl:@"" dateStr:@"2019-08-13"];
    }
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
}
- (void)applicationWillTerminate:(UIApplication *)application {
}
-(void)configureBoardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager]; manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES; manager.keyboardDistanceFromTextField = 10; manager.enableAutoToolbar = YES;
}
- (NSTimeInterval )currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time=[date timeIntervalSince1970];
    return time;
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
}
@end
