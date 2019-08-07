#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
extern NSString* const kJSDPhotoImageFiles;
extern NSString* const kJSDKitImageFiles;
typedef NS_ENUM(NSInteger, JSDImagePickerSourceType) {
    JSDImagePickerSourceTypePhotoLibrary = 0,
    JSDImagePickerSourceTypeCamera,
    JSDImagePickerSourceTypePhotosAlbum,
};
@interface JSDPhotoManage : NSObject
+ (void)presentWithViewController:(UIViewController *)viewController
                       sourceType:(JSDImagePickerSourceType)sourceType
                    finishPicking:(void (^)(UIImage *image))finishPicking;
+ (void)savaImageView:(UIImageView *)imageView fileName:(NSString *)fileName;
+ (void)savaKitImageView:(UIImageView *)imageView fileName:(nonnull NSString *)fileName;
@end
NS_ASSUME_NONNULL_END
