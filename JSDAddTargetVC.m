#import "JSDAddTargetVC.h"
#import "JSDStackView.h"
#import "JSDSelectedImageView.h"
#import <BRPickerView.h>
#import <UIViewController+KeyboardAnimation.h>
@interface JSDAddTargetVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;
@property (weak, nonatomic) IBOutlet UILabel *targetTitleLabel;
@property (weak, nonatomic) IBOutlet MDCTextField *targetTextField;
@property (strong, nonatomic) MDCTextInputControllerUnderline *targetTextFieldController;
@property (weak, nonatomic) IBOutlet UILabel *selectedTargetTitleLabel;
@property (weak, nonatomic) IBOutlet JSDSelectedImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UILabel *finishTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishSubtitleLabel;
@property (weak, nonatomic) IBOutlet JSDStackView *selectedFinishView;
@property (weak, nonatomic) IBOutlet UILabel *tipTimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipSubtitleLabel;
@property (weak, nonatomic) IBOutlet MDCButton *addTimerButton;
@property (weak, nonatomic) IBOutlet MDCFloatingButton *showTipTimerButton;
@property (weak, nonatomic) IBOutlet UILabel *sayingTitleLabel;
@property (weak, nonatomic) IBOutlet MDCTextField *sayingTextField;
@property (strong, nonatomic) MDCTextInputControllerUnderline *sayingTextFieldController;
@property (weak, nonatomic) IBOutlet MDCButton *addTargetButton;
@property (nonatomic, strong) NSMutableArray* selectedFinishArr;
@property (nonatomic, strong) JSDTargetManage* manage;
@property (strong, nonatomic) NSArray<UIButton*> *finishButtons;
@end
@implementation JSDAddTargetVC
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}
#pragma mark - 2.SettingView and Style
- (void)setupNavBar {
    if (self.edit) {
        self.title = @"Edit Target";
    } else {
        self.title = @"Add Target";
    }
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(didTapBack:)];
    UIImage *backImage = [UIImage imageNamed:@"back"];
    backButton.image = backImage;
    backButton.tintColor = [UIColor jsd_colorWithHexString:@"#333333"];
    self.navigationItem.leftBarButtonItem = backButton;
}
- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollContentView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouchTap:)];
    [self.scrollContentView addGestureRecognizer:tap];
    self.targetTitleLabel.font = [UIFont jsd_fontSize: 19];
    self.targetTitleLabel.textColor = [UIColor jsd_mainBlackColor];
    self.targetTitleLabel.text = @"Target name";
    [self targetTextFieldController];
    self.selectedTargetTitleLabel.font = [UIFont jsd_fontSize:19];
    self.selectedTargetTitleLabel.textColor = [UIColor jsd_mainBlackColor];
    self.selectedTargetTitleLabel.text = @"Pick icon";
    self.finishTitleLabel.font = [UIFont jsd_fontSize:19];
    self.finishTitleLabel.textColor = [UIColor jsd_mainBlackColor];
    self.finishTitleLabel.text = @"Opening time";
    self.finishSubtitleLabel.font = [UIFont jsd_fontSize:16];
    self.finishSubtitleLabel.textColor = [UIColor jsd_subTitleColor];
    self.finishSubtitleLabel.text = @"/When is the week?";
    NSArray* titles = @[@"Mon", @"Tue", @"Wed", @"Thur", @"Fri", @"Sat", @"Sun"];
    CGFloat width = (ScreenWidth - 30 - (6 * 5)) / 7;
    NSMutableArray* btns = NSMutableArray.new;
    for (NSInteger i = 0; i < 7; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i + 1;
        if (i == 6) { 
            btn.tag = 0;
        }
        [btn addTarget:self action:@selector(onTouchFinishTimer:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont jsd_fontSize:13]];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor jsd_colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [btn jsd_setBackgroundColor:[UIColor jsd_colorWithHexString:@"#E2E2E2"] forState:UIControlStateNormal];
        [btn jsd_setBackgroundColor:[UIColor jsd_mainBlueColor] forState:UIControlStateSelected];
        [self.selectedFinishView addArrangedSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(btn.mas_width);
        }];
        btn.layer.cornerRadius = width / 2;
        btn.layer.masksToBounds = YES;
        [btns addObject:btn];
    }
    self.finishButtons = btns.copy;
    self.tipTimerLabel.font = [UIFont jsd_fontSize:19];
    self.tipTimerLabel.textColor = [UIColor jsd_mainBlackColor];
    self.tipTimerLabel.text = @"Set reminder time";
    self.tipSubtitleLabel.font = [UIFont jsd_fontSize:16];
    self.tipSubtitleLabel.textColor = [UIColor jsd_mainBlackColor];
    self.tipSubtitleLabel.text = @"Remind unfinished tasks";
    self.tipSubtitleLabel.numberOfLines = 0;
    self.addTimerButton.backgroundColor = [UIColor jsd_colorWithHexString:@"#E2E2E2"];
    self.addTimerButton.layer.cornerRadius = 25;
    [self.addTimerButton setImage:[UIImage imageNamed:@"add_timer"] forState:UIControlStateNormal];
    self.addTimerButton.layer.masksToBounds = YES;
    [self.addTimerButton addTarget:self action:@selector(onTouchSetupTimer:) forControlEvents:UIControlEventTouchUpInside];
    [self.showTipTimerButton setTitleFont:[UIFont jsd_fontSize:17] forState:UIControlStateNormal];
    [self.showTipTimerButton setTintColor:[UIColor jsd_mainBlueColor]];
    [self.showTipTimerButton setBackgroundColor:[UIColor jsd_colorWithHexString:@"#D5ECFD"]];
    [self.showTipTimerButton setTitle:@"10:50" forState:UIControlStateNormal];
    [self.showTipTimerButton setImageTintColor:[UIColor jsd_colorWithHexString:@"#f5b853"] forState:UIControlStateNormal];
    self.showTipTimerButton.hidden = YES;
    self.sayingTitleLabel.font = [UIFont jsd_fontSize:19];
    self.sayingTitleLabel.textColor = [UIColor jsd_mainBlackColor];
    self.sayingTitleLabel.text = @"Write a sentence to motivate yourself";
    [self sayingTextFieldController];
    [self.addTargetButton setBackgroundColor:[UIColor jsd_mainBlueColor]];
    [self.addTargetButton setTitleFont:[UIFont jsd_fontSize:17] forState:UIControlStateNormal];
    [self.addTargetButton setTintColor:[UIColor whiteColor]];
    if (self.edit) {
        [self.addTargetButton setTitle:@"Confirm editorial goal" forState:UIControlStateNormal];
    } else {
        [self.addTargetButton setTitle:@"Determine add target" forState:UIControlStateNormal];
    }
    [self selectedFinishArr];
}
- (void)reloadView {
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    self.model = nil;
    self.targetTextField.text = nil;
    self.sayingTextField.text = @"Persistence is victory";
    for (UIButton* btn in self.finishButtons) {
        btn.selected = NO;
    }
    self.selectedFinishArr = nil;
    [self selectedFinishArr];
    [self.selectedImageView setupLastButton:100];
    self.showTipTimerButton.hidden = YES;
    MDCSnackbarManager* manager = [MDCSnackbarManager defaultManager];
    MDCSnackbarMessage* message = [MDCSnackbarMessage messageWithText:@"Target added successfully, automatically displayed on the home page when the open time meets the target setting"];
    [manager showMessage:message];
    self.tabBarController.selectedIndex = 0;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)editComplection {
    MDCSnackbarManager* manager = [MDCSnackbarManager defaultManager];
    MDCSnackbarMessage* message = [MDCSnackbarMessage messageWithText:@"The target is successfully edited and will be automatically displayed on the home page when the open time matches the target setting."];
    [manager showMessage:message];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 3.Request Data
- (void)setupData {
    if (self.edit) {
        self.targetTextField.text = self.model.title;
        self.sayingTextField.text = self.model.encourage;
        [self.selectedImageView setupLastButton:self.model.imageIndex];
        for (NSInteger i = 0; i < self.model.finishWeekDays.count; i++) {
            NSInteger index = self.model.finishWeekDays[i].integerValue;
            UIButton* btn;
            if (index == 0) {
               btn = self.finishButtons[6];
            } else {
               btn = self.finishButtons[--index];
            }
            btn.selected = YES;
        }
        self.selectedFinishArr = self.model.finishWeekDays;
    }
}
#pragma mark - 4.UITableViewDataSource and UITableViewDelegate
#pragma mark - 5.Event Response
- (void)onTouchFinishTimer:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (sender.selected) {
        if (![self.selectedFinishArr containsObject:@(sender.tag).stringValue]) {
            [self.selectedFinishArr addObject:@(sender.tag).stringValue];
        }
    } else {
        if ([self.selectedFinishArr containsObject:@(sender.tag).stringValue]) {
            [self.selectedFinishArr removeObject:@(sender.tag).stringValue];
        }
    }
}
- (void)didTapBack:(id)sender {
    if (self.edit) {
        [self.navigationController popViewControllerAnimated: YES];
    } else {
        self.tabBarController.selectedIndex = 0;
        self.tabBarController.tabBar.hidden = NO;
    }
}
- (void)onTouchTap:(id)sender {
    [self.scrollContentView endEditing: YES];
}
- (void)onTouchSetupTimer:(MDCButton *)sender {
    [BRDatePickerView showDatePickerWithTitle:@"Set notification time" dateType:BRDatePickerModeHM defaultSelValue:@"08:00" resultBlock:^(NSString *selectValue) {
        NSLog(@"选中时间%@", selectValue);
        self.showTipTimerButton.hidden = NO;
        [self.showTipTimerButton setTitle:selectValue forState:UIControlStateNormal];
    }];
}
- (IBAction)onTouchConfirmAddButton:(MDCButton *)sender {
    BOOL havaTitle = JSDIsString(self.targetTextField.text);
    if (havaTitle) {
        if (self.edit) {
            [self editTargetData];
        } else {
            if ([self.manage checkContainsTargetTitle:self.targetTextField.text]) {
                MDCSnackbarManager* manager = [MDCSnackbarManager defaultManager];
                MDCSnackbarMessage* message = [MDCSnackbarMessage messageWithText:@"This target is currently included, please re-add after modification"];
                [manager showMessage:message];
            } else {
                [self savaTargetData];
            }
        }
    } else {
        MDCSnackbarManager* manager = [MDCSnackbarManager defaultManager];
        MDCSnackbarMessage* message = [MDCSnackbarMessage messageWithText:@"Please add a title"];
        [manager showMessage:message];
    }
}
- (void)savaTargetData {
    self.model.title = self.targetTextField.text;
    self.model.encourage = self.sayingTextField.text;
    if (self.selectedImageView.lastButton) {
        self.model.imageView = [NSString stringWithFormat:@"target_%ld_selected", self.selectedImageView.lastButton.tag];
    } else {
        self.model.imageView = @"target_0_selected";
    }
    self.model.imageIndex = self.selectedImageView.lastButton.tag;
    if (!self.selectedFinishArr.count) { 
        self.model.finishWeekDays = @[@"1"].mutableCopy;
    } else {
        self.model.finishWeekDays = self.selectedFinishArr;
    }
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    self.model.monthDay = [formatter stringFromDate:date];
    [self.manage addTargetModel:self.model];
    [self reloadView];
}
- (void)editTargetData {
    self.model.title = self.targetTextField.text;
    self.model.encourage = self.sayingTextField.text;
    if (self.selectedImageView.lastButton) {
        self.model.imageView = [NSString stringWithFormat:@"target_%ld_selected", self.selectedImageView.lastButton.tag];
    } else {
        self.model.imageView = @"target_0_selected";
    }
    self.model.imageIndex = self.selectedImageView.lastButton.tag;
    if (!self.selectedFinishArr.count) { 
        self.model.finishWeekDays = @[@"1"].mutableCopy;
    } else {
        self.model.finishWeekDays = self.selectedFinishArr;
    }
    [self.manage editTargetModel:self.model];
    [self editComplection];
}
#pragma mark - 6.Private Methods
- (void)setupNotification {
}
#pragma mark - 7.GET & SET
- (MDCTextInputControllerUnderline *)targetTextFieldController {
    if (!_targetTextFieldController) {
        _targetTextFieldController = [[MDCTextInputControllerUnderline alloc] initWithTextInput: self.targetTextField];
        _targetTextFieldController.normalColor = ColorWithFROMRGB(0xdddddd, 1);
        _targetTextFieldController.activeColor = [UIColor blueColor];
        _targetTextFieldController.borderFillColor = [UIColor jsd_colorWithHexString:@"#F5F5F5"];
        _targetTextFieldController.placeholderText = @"Enter the goal you want to stick to";
    }
    return _targetTextFieldController;
}
- (MDCTextInputControllerUnderline *)sayingTextFieldController {
    if (!_sayingTextFieldController) {
        _sayingTextFieldController = [[MDCTextInputControllerUnderline alloc] initWithTextInput: self.sayingTextField];
        _sayingTextFieldController.normalColor = ColorWithFROMRGB(0xdddddd, 1);
        _sayingTextFieldController.activeColor = [UIColor blueColor];
        _sayingTextFieldController.borderFillColor = [UIColor jsd_colorWithHexString:@"#F5F5F5"];
        _sayingTextFieldController.placeholderText = @"Persistence is victory";
        self.sayingTextField.text = @"Persistence is victory";
    }
    return _sayingTextFieldController;
}
- (JSDTargetModel *)model {
    if (!_model) {
        _model = [[JSDTargetModel alloc] init];
    }
    return _model;
}
- (NSMutableArray *)selectedFinishArr {
    if (!_selectedFinishArr) {
        JSDCalendarViewModel* calendar = [[JSDCalendarViewModel alloc] init];
        [calendar updateTarget];
        _selectedFinishArr = @[@(calendar.targetWeekDay).stringValue].mutableCopy;
        NSInteger index = calendar.targetWeekDay;
        UIButton* btn;
        if (index == 0) {
            btn = self.finishButtons.lastObject;
        } else {
            btn = self.finishButtons[--index];
        }
        btn.selected = YES;
    }
    return _selectedFinishArr;
}
- (JSDTargetManage *)manage {
    if (!_manage) {
        _manage = [JSDTargetManage sharedInstance];
    }
    return _manage;
}
@end
