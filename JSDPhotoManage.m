#import "JSDPhotoManage.h"
#import <Photos/Photos.h>
NSString* const kJSDPhotoImageFiles = @"PhotoImage/coffee_";
NSString* const kJSDKitImageFiles = @"PhotoImage/kit_";
@interface JSDPhotoManage () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic, assign) JSDImagePickerSourceType sourceType;
@property (nonatomic, copy) void (^finishPicking)(UIImage *image);
@end
@implementation JSDPhotoManage
+ (instancetype)sharePhotoManage {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
#pragma mark - Method
+ (void)presentWithViewController:(UIViewController *)viewController sourceType:(JSDImagePickerSourceType)sourceType finishPicking:(void (^)(UIImage *))finishPicking
{
    [JSDPhotoManage sharePhotoManage].sourceType = sourceType;
    [JSDPhotoManage sharePhotoManage].finishPicking = finishPicking;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
    }];
    [[JSDPhotoManage sharePhotoManage] presentWithViewController:viewController];
}
#pragma mark - Private Method
- (void)presentWithViewController:(UIViewController *)viewController
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    switch (self.sourceType) {
        case JSDImagePickerSourceTypeCamera:
        {
            if (self.isCameraAvailable && [self doesCameraSupportTakingPhotos]) {
                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tips" message:@"This device does not support taking pictures." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                return;
            }
        }
            break;
        case JSDImagePickerSourceTypePhotoLibrary: {
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
            break;
            case JSDImagePickerSourceTypePhotosAlbum:
            controller.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
        default:
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
    }
    if (@available(iOS 11, *)) {
        controller.delegate = self;
        controller.allowsEditing = YES;
        [controller.navigationBar setTintColor:[UIColor jsd_mainGrayColor]];
        [viewController presentViewController:controller animated:YES completion:nil];
    } else {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusAuthorized) {
            controller.delegate = self;
            controller.allowsEditing = YES;
            [controller.navigationBar setTintColor:[UIColor jsd_mainGrayColor]];
            [viewController presentViewController:controller animated:YES completion:nil];
        } else {
            UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Please click to go to Settings to open the app album read permission, otherwise the photo will not be selected properly." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction* gotoAction = [UIAlertAction actionWithTitle:@"Go" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
            }];
            [alertVC addAction:cancelAction];
            [alertVC addAction:gotoAction];
            [JSDAppWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
        }
    }
}
- (void)clean
{
    self.sourceType = JSDImagePickerSourceTypePhotoLibrary;
    self.finishPicking = nil;
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusAuthorized) {
            UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
            self.finishPicking ? self.finishPicking(image) : NULL;
        } else {
            UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Please click to go to Settings to open the app album read permission, otherwise the photo will not be selected properly." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction* gotoAction = [UIAlertAction actionWithTitle:@"Go" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
            }];
            [alertVC addAction:cancelAction];
            [alertVC addAction:gotoAction];
            [JSDAppWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
        }
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}
- (BOOL)isCameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
- (BOOL)isRearCameraAvailable
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
- (BOOL)isFrontCameraAvailable
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
- (BOOL)doesCameraSupportTakingPhotos
{
    return YES;
}
- (BOOL)isPhotoLibraryAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL)canUserPickVideosFromPhotoLibrary
{
    return YES;
}
- (BOOL)canUserPickPhotosFromPhotoLibrary
{
    return YES;
}
- (BOOL)cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType
{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}
#pragma mark -- Image
+ (void)savaImageView:(UIImageView *)imageView fileName:(nonnull NSString *)fileName {
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, kJSDPhotoImageFiles];
    NSFileManager* fileManage = [NSFileManager defaultManager];
    if (![fileManage fileExistsAtPath: filePath]) {
        BOOL isSuccess = [fileManage createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        NSLog(@"isSiccess = %d",isSuccess);
    }
    NSData* data = UIImagePNGRepresentation(imageView.image);
    if (data) {
        NSError* error;
        NSString* imageName = [NSString stringWithFormat:@"%@/%@%@", documentsDirectory, kJSDPhotoImageFiles, fileName];
        BOOL result = [data writeToFile:imageName options:NSDataWritingAtomic error: &error];
        if (error) {
            NSLog(@"保存结果%d---%@", result, error);
        }
    } else {
        NSLog(@"图片转换 PNG 失败");
    }
}
+ (void)savaKitImageView:(UIImageView *)imageView fileName:(nonnull NSString *)fileName {
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, kJSDKitImageFiles];
    NSFileManager* fileManage = [NSFileManager defaultManager];
    if (![fileManage fileExistsAtPath: filePath]) {
        BOOL isSuccess = [fileManage createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        NSLog(@"isSiccess = %d",isSuccess);
    }
    NSData* data = UIImagePNGRepresentation(imageView.image);
    if (data) {
        NSError* error;
        NSString* imageName = [NSString stringWithFormat:@"%@/%@%@", documentsDirectory, kJSDKitImageFiles, fileName];
        BOOL result = [data writeToFile:imageName options:NSDataWritingAtomic error: &error];
        if (error) {
            NSLog(@"保存结果%d---%@", result, error);
        }
    } else {
        NSLog(@"图片转换 PNG 失败");
    }
}
@end
