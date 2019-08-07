#import "JSDAboutUSVC.h"
#import <MDCCollectionViewTextCell.h>
#import "JSDAbountViewModel.h"
NSString* const kJSDAppleID = @"1475734146";
@interface JSDAboutUSVC ()
@property (nonatomic, strong) JSDAbountViewModel* viewModel;
@end
@implementation JSDAboutUSVC
static NSString * const reuseIdentifier = @"Cell";
#pragma mark - 1.View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setupView];
    [self setupData];
    [self setupNotification];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 2.SettingView and Style
- (void)setupNavBar {
    self.navigationItem.title = @"About US";
}
- (void)setupView {
    self.view.backgroundColor = [UIColor jsd_mainGrayColor];
    self.styler.cellStyle = MDCCollectionViewCellStyleCard;
    self.collectionView.backgroundColor = [UIColor jsd_mainGrayColor];
    [self.collectionView registerClass:[MDCCollectionViewTextCell class] forCellWithReuseIdentifier:reuseIdentifier];
}
- (void)reloadView {
}
#pragma mark - 3.Request Data
- (void)setupData {
}
#pragma mark - 4.UITableViewDataSource and UITableViewDelegate
#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.listArray.count;;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MDCCollectionViewTextCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    JSDAbountModel* model = self.viewModel.listArray[indexPath.item];
    cell.detailTextLabel.numberOfLines = 0;
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.detail;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    if (indexPath.row == 0) {
    } else if (indexPath.row == 1) {
        NSString* appId = kJSDAppleID;
        NSString *urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8&action=write-review", appId];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [super collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    return CGSizeMake(size.width, 100);
}
#pragma mark <UICollectionViewDelegate>
#pragma mark <UICollectionViewLayoutDelegate>
#pragma mark - 5.Event Response
#pragma mark - 6.Private Methods
- (void)setupNotification {
}
#pragma mark - 7.GET & SET
- (JSDAbountViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[JSDAbountViewModel alloc] init];
    }
    return _viewModel;
}
@end
