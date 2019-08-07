#import "JSDSelectedImageView.h"
#import "JSDStackView.h"
@interface JSDSelectedImageView ()
@property (nonatomic, strong) JSDStackView* topStackView;
@property (nonatomic, strong) JSDStackView* centerStackView;
@property (nonatomic, strong) JSDStackView* bottomStackView;
@property (nonatomic, strong) NSArray* stackViews;
@property (nonatomic, strong) NSArray<UIButton* >* buttonS;
@end
@implementation JSDSelectedImageView
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
        [self configuration];
    }
    return self;
}
- (void)setupView {
    self.topStackView = [[JSDStackView alloc] init];
    self.centerStackView = [[JSDStackView alloc] init];
    self.bottomStackView = [[JSDStackView alloc] init];
    self.topStackView.alignment = UIStackViewAlignmentFill;
    self.centerStackView.alignment = UIStackViewAlignmentFill;
    self.bottomStackView.alignment = UIStackViewAlignmentFill;
    [self addSubview:self.topStackView];
    [self addSubview:self.centerStackView];
    [self addSubview:self.bottomStackView];
    [self.topStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
    }];
    [self.centerStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.topStackView.mas_bottom);
        make.height.mas_equalTo(self.topStackView.mas_height);
    }];
    [self.bottomStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.centerStackView.mas_bottom);
        make.height.mas_equalTo(self.topStackView.mas_height);
    }];
}
- (void)configuration {
    NSArray* topArray = @[@"target_0_normal",@"target_1_normal",@"target_2_normal",@"target_3_normal",@"target_4_normal"];
    NSArray* centerArray = @[@"target_5_normal",@"target_6_normal",@"target_7_normal",@"target_8_normal",@"target_9_normal"];
     NSArray* bottomArray = @[@"target_10_normal",@"target_11_normal",@"target_12_normal",@"target_13_normal",@"target_14_normal"];
    NSArray<NSArray* >* stackImages = @[topArray, centerArray, bottomArray];
    NSArray* selectedTopArray = @[@"target_0_selected",@"target_1_selected",@"target_2_selected",@"target_3_selected",@"target_4_selected"];
    NSArray* selectedCenterArray = @[@"target_5_selected",@"target_6_selected",@"target_7_selected",@"target_8_selected",@"target_9_selected"];
    NSArray* selectedBottomArray = @[@"target_10_selected",@"target_11_selected",@"target_12_selected",@"target_13_selected",@"target_14_selected"];
    NSArray<NSArray* >* stackSelectedImages = @[selectedTopArray, selectedCenterArray, selectedBottomArray];
    self.stackViews = @[self.topStackView, self.centerStackView, self.bottomStackView];
    NSMutableArray<UIButton *>* btnArray = NSMutableArray.new;
    for (NSInteger i = 0; i < self.stackViews.count; i++) {
        for (NSInteger y = 0; y < stackImages[i].count; y++) {
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            NSInteger number = i * 5;
            btn.tag = number + y;
            [btn setImage:[UIImage imageNamed:stackImages[i][y]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:stackSelectedImages[i][y]] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(onTouchButton:) forControlEvents:UIControlEventTouchUpInside];
            [btnArray addObject:btn];
            [self.stackViews[i] addArrangedSubview:btn];
        }
    }
    self.buttonS = btnArray.copy;
}
- (void)onTouchButton:(UIButton *)sender {
    if (self.lastButton) { 
        if ([self.lastButton isEqual:sender]) {
            self.lastButton.selected = false;
            self.lastButton = nil;
        } else {
            self.lastButton.selected = false;
            sender.selected = true;
            self.lastButton = sender;
        }
    } else { 
        sender.selected = true;
        self.lastButton = sender;
    }
}
- (void)setupLastButton:(NSInteger)imageIndex {
    if (imageIndex == 100) {
        self.lastButton.selected = NO;
        self.lastButton = nil;
    } else {
        self.lastButton = self.buttonS[imageIndex];
        self.buttonS[imageIndex].selected = YES;
    }
}
@end
