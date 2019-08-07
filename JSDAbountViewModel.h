#import "JSDBaseModel.h"
NS_ASSUME_NONNULL_BEGIN
@class JSDAbountModel;
@interface JSDAbountViewModel : JSDBaseModel
@property (nonatomic, strong) NSArray<JSDAbountModel *>* listArray;
@end
@interface JSDAbountModel : JSDBaseModel
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* detail;
@end
NS_ASSUME_NONNULL_END
