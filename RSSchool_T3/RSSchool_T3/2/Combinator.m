#import "Combinator.h"

double factorialWithNumber(double number) {
    double factorial = 1;
    for (int i = 2; i <= number; i++) {
        factorial *= i;
    }
    return factorial;
}

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    int m = array[0].doubleValue, n = array[1].doubleValue, k = 1.0;
    int C = factorialWithNumber(n)/(factorialWithNumber(k)*(factorialWithNumber(n-k)));
    for (k = 1; k < n; k++) {
        C = factorialWithNumber(n)/(factorialWithNumber(k)*(factorialWithNumber(n-k)));
        if (C >= m) {
            return [NSNumber numberWithDouble: k];
        }
    }
    return nil;
}
@end
