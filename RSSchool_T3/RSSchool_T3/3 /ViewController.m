#import "ViewController.h"

@interface ViewController()

// View
@property (nonatomic, strong) UIView *viewResultColor;

// Labels
@property (nonatomic, strong) UILabel *labelResultColor;
@property (nonatomic, strong) UILabel *labelRed;
@property (nonatomic, strong) UILabel *labelGreen;
@property (nonatomic, strong) UILabel *labelBlue;

// Textfields
@property (nonatomic, strong) UITextField *textFieldRed;
@property (nonatomic, strong) UITextField *textFieldGreen;
@property (nonatomic, strong) UITextField *textFieldBlue;

// Button
@property (nonatomic, strong) UIButton *buttonProcess;

@end


@implementation ViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLabels];
    [self initTextFields];
    [self initProcessButton];
    [self initColorBlockView];
    [self setAccessibilityIdentifiers];
    [self addTargetToProcessButton];
    [self subscribeOnTapOnTextFieldEvents];
    [self hideKeyboardThenTappedAround];
}

- (void)initLabels {
    CGFloat x = 20.0;
    CGFloat y = 100.0;
    CGFloat width = 100.0;
    CGFloat height = 26.0;
    
    // color label
    self.labelResultColor = [[UILabel alloc] init];
    [self setLabel:self.labelResultColor X:x Y:y Width:width Height:height Text:@"Color"];
    
    // red color label
    width -= 30.0;
    y = self.labelResultColor.frame.origin.y + self.labelResultColor.frame.size.height + 45.0;
    self.labelRed = [[UILabel alloc]init];
    [self setLabel:self.labelRed X:x Y:y Width:width Height:height Text:@"RED"];
    
    // green color label
    y = self.labelRed.frame.origin.y + self.labelRed.frame.size.height + 40.0;
    self.labelGreen = [[UILabel alloc]init];
    [self setLabel:self.labelGreen X:x Y:y Width:width Height:height Text:@"GREEN"];
    
    // blue color label
    y = self.labelGreen.frame.origin.y + self.labelGreen.frame.size.height + 40.0;
    self.labelBlue = [[UILabel alloc]init];
    [self setLabel:self.labelBlue X:x Y:y Width:width Height:height Text:@"BLUE"];
    
}

- (void)setLabel:(UILabel*)label X:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height Text:(NSString*)text {
    CGRect frame = CGRectMake(x, y, width, height);
    label.frame = frame;
    [label setText:text];
    [self.view addSubview:label];
}

- (void)initTextFields {
    CGFloat x = self.labelRed.frame.origin.x + self.labelRed.frame.size.width + 15.0;
    CGFloat y = self.labelRed.frame.origin.y - 2;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 45.0 - self.labelRed.frame.origin.x - self.labelResultColor.frame.size.width;
    CGFloat height = 30.0;
    
    // red color text field
    self.textFieldRed = [[UITextField alloc] init];
    [self setTextField:self.textFieldRed X:x Y:y Width:width Height:height];
    
    // green color text field
    y = self.labelGreen.frame.origin.y - 2;
    self.textFieldGreen = [[UITextField alloc] init];
    [self setTextField:self.textFieldGreen X:x Y:y Width:width Height:height];
    
    // blue color text field
    y = self.labelBlue.frame.origin.y - 2;
    self.textFieldBlue = [[UITextField alloc] init];
    [self setTextField:self.textFieldBlue X:x Y:y Width:width Height:height];
}

- (void)setTextField:(UITextField*)textField X:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height {
    CGRect frame = CGRectMake(x, y, width, height);
    textField.frame = frame;
    textField.layer.borderColor = UIColor.lightGrayColor.CGColor;
    textField.layer.borderWidth = 1.0;
    textField.layer.cornerRadius = 5.0;
    [textField setPlaceholder:@"0..255"];
    [self.view addSubview:textField];
}

- (void)initProcessButton {
    self.buttonProcess = [[UIButton alloc] init];
    [self.buttonProcess setTitle:@"Process" forState:UIControlStateNormal];
    CGFloat width = 100.0;
    CGFloat x = UIScreen.mainScreen.bounds.size.width/2 - width/2;
    CGFloat y = self.labelBlue.frame.origin.y + 100.0;
    CGFloat height = 20.0;
    CGRect frame = CGRectMake(x, y, width, height);
    self.buttonProcess.frame = frame;
    [self.buttonProcess setTitleColor:UIColor.blueColor forState:UIControlStateNormal];

    [self.view addSubview:self.buttonProcess];
}

- (void)initColorBlockView {
    self.viewResultColor = [[UIView alloc] init];
    
    CGFloat x = self.labelResultColor.frame.origin.x + self.labelResultColor.frame.size.width + 15.0;
    CGFloat y = self.labelResultColor.frame.origin.y - 10.0;
    CGFloat width = UIScreen.mainScreen.bounds.size.width - self.labelResultColor.frame.origin.x - self.labelResultColor.frame.size.width - (UIScreen.mainScreen.bounds.size.width - self.textFieldRed.frame.origin.x - self.textFieldRed.frame.size.width) - 15.0;
    CGFloat height = 46.0;
    
    CGRect frame = CGRectMake(x, y, width, height);
    self.viewResultColor.frame = frame;
    self.viewResultColor.layer.backgroundColor = UIColor.clearColor.CGColor;
    
    [self.view addSubview: self.viewResultColor];
}

- (void)setAccessibilityIdentifiers {
    self.view.accessibilityIdentifier = @"mainView";
    self.textFieldRed.accessibilityIdentifier = @"textFieldRed";
    self.textFieldGreen.accessibilityIdentifier = @"textFieldGreen";
    self.textFieldBlue.accessibilityIdentifier = @"textFieldBlue";
    self.buttonProcess.accessibilityIdentifier = @"buttonProcess";
    self.labelRed.accessibilityIdentifier = @"labelRed";
    self.labelGreen.accessibilityIdentifier = @"labelGreen";
    self.labelBlue.accessibilityIdentifier = @"labelBlue";
    self.labelResultColor.accessibilityIdentifier = @"labelResultColor";
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
}

- (void)setTextFieldsToDefaultState {
    [self.textFieldRed setText:@""];
    [self.textFieldGreen setText:@""];
    [self.textFieldBlue setText:@""];
}

- (void)addTargetToProcessButton {
    [self.buttonProcess addTarget:self
                           action:@selector(processThanTapped)
                 forControlEvents:UIControlEventTouchUpInside];
}

- (void) processThanTapped {
    [self hideKeyboard];
    if ([self checkIfFieldsFilled]) {
        [self showColor];
    } else {
        [self errorCase];
    }
}

- (void)showColor {
    CGFloat r = self.textFieldRed.text.intValue;
    CGFloat g = self.textFieldGreen.text.intValue;
    CGFloat b = self.textFieldBlue.text.intValue;
    
    self.viewResultColor.layer.backgroundColor = [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:1.0].CGColor;
    NSString *resultColor = [NSString stringWithFormat:@"0x%02X%02X%02X", (unsigned int)r, (unsigned int)g, (unsigned int)b];
    [self.labelResultColor setText:resultColor];
    
    [self setTextFieldsToDefaultState];
}

- (BOOL)checkIfFieldsFilled {
    BOOL redTextField = ![self.textFieldRed.text isEqualToString:@""] && self.textFieldRed.text.intValue >= 0 && self.textFieldRed.text.intValue <= 255;
    BOOL greenTextField = ![self.textFieldGreen.text isEqualToString:@""] && self.textFieldGreen.text.intValue >= 0 && self.textFieldRed.text.intValue <= 255;
    BOOL blueTextField = ![self.textFieldBlue.text isEqualToString:@""] && self.textFieldBlue.text.intValue >= 0 && self.textFieldRed.text.intValue <= 255;
    
    if (redTextField && greenTextField && blueTextField && [self checkIfFieldsFilledRight]) {
        return true;
    }
    return false;
}

- (BOOL)checkIfFieldsFilledRight {
    NSCharacterSet *set = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *redSet = [NSCharacterSet characterSetWithCharactersInString:self.textFieldRed.text];
    NSCharacterSet *greenSet = [NSCharacterSet characterSetWithCharactersInString:self.textFieldGreen.text];
    NSCharacterSet *blueSet = [NSCharacterSet characterSetWithCharactersInString:self.textFieldBlue.text];
    
    if ([set isSupersetOfSet:redSet] && [set isSupersetOfSet:greenSet] && [set isSupersetOfSet:blueSet]) {
        return true;
    }
    return false;
}

- (void)errorCase {
    [self.labelResultColor setText:@"Error"];
    [self setTextFieldsToDefaultState];
}

- (void)hideKeyboard {
    [self.view endEditing:true];
}

- (void)setResultColorLabelToDefaultState {
    if (![self.labelResultColor.text isEqualToString:@"Color"]) {
        [self.labelResultColor setText:@"Color"];
    }
}

- (void)subscribeOnTapOnTextFieldEvents {
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(setResultColorLabelToDefaultState)
                                               name:UITextFieldTextDidBeginEditingNotification
                                             object:nil];
}

- (void)hideKeyboardThenTappedAround {
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(hideKeyboard)];
    
    [self.view addGestureRecognizer:gesture];
}

@end
