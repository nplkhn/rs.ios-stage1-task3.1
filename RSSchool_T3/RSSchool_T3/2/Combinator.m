#import "Combinator.h"

long long factorialWithNumber(long long number) {
    long long factorial = 1;
    for (int i = 2; i <= number; i++) {
        factorial *= i;
    }
    return factorial;
}

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    long long m = array[0].unsignedLongLongValue, n = array[1].unsignedLongLongValue, k = 1;
    long long C = factorialWithNumber(n)/(factorialWithNumber(k)*(factorialWithNumber(n-k)));
    for (k = 1; k < n; k++) {
        C = factorialWithNumber(n)/(factorialWithNumber(k)*(factorialWithNumber(n-k)));
        if (C >= m) {
            return [NSNumber numberWithUnsignedLongLong: k];
        }
    }
    return nil;
}
@end
