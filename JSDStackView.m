#import "JSDStackView.h"
@implementation JSDStackView
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self configuration];
    }
    return self;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self configuration];
    }
    return self;
}
- (void)configuration {
    self.axis = UILayoutConstraintAxisHorizontal;
    self.distribution = UIStackViewDistributionFillEqually;
    self.alignment = UIStackViewAlignmentCenter;
    self.spacing = 5;
}
@end
