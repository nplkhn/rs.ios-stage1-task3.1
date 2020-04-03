#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    if ([numbers isEqualToArray:@[]]) {
        return nil;
    }
    NSMutableString *resultString = [[NSMutableString alloc] init];
    [numbers enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.intValue > 1 && [resultString isEqualToString:@""]) {
            [resultString appendFormat:@"%@", obj];
        } else if (obj.intValue < 1 && [resultString isEqualToString:@""]) {
            [resultString appendFormat:@"- %d", abs(obj.intValue)];
        } else if (obj.intValue > 1) {
            [resultString appendFormat:@" + %@", obj];
        } else if (obj.intValue < -1) {
            [resultString appendFormat:@" - %d", abs(obj.intValue)];
        } else if (obj.intValue == 1) {
            [resultString appendString:@" + "];
        } else if (obj.intValue == -1) {
            [resultString appendString:@" - "];
        }
        
        if (obj.intValue && numbers.count - idx - 1 > 1) {
            [resultString appendFormat:@"x^%lu",numbers.count - idx - 1];
        } else if (obj.intValue && numbers.count - idx - 1 == 1) {
            [resultString appendString:@"x"];
        }
    }];
    return resultString;
}
@end
