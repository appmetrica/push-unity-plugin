
#import <Foundation/Foundation.h>

@interface AMPUTokenStorage : NSObject

+ (void)saveToken:(NSData *)token;
+ (NSData *)getToken;

@end
