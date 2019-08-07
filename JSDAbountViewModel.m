#import "JSDAbountViewModel.h"
@implementation JSDAbountViewModel
- (NSArray<JSDAbountModel *> *)listArray {
    if (!_listArray) {
        NSArray* array = @[
                           @{@"title": @"App Version",
                             @"detail": @"V1.0.0",
                             },
                           @{@"title": @"App Rating",
                             @"detail": @"Thank you very much for using our app. If you like easy small goals, click to go to the comments page to comment!",
                             },
                           ];
        _listArray = [JSDAbountModel mj_objectArrayWithKeyValuesArray:array];
    }
    return _listArray;
}
@end
@implementation JSDAbountModel
@end
