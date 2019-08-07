#import "JSDBaseViewController.h"
#import "JSDTargetManage.h"
#import "JSDTargetViewModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface JSDAddTargetVC : JSDBaseViewController
@property (strong, nonatomic, nullable) JSDTargetModel *model;
@property (assign, nonatomic) BOOL edit;
@end
NS_ASSUME_NONNULL_END
