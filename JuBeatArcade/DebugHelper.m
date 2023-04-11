#import <Foundation/Foundation.h>

#import "DebugHelper.h"

@implementation DebugHelper
+(void)storeFile:(NSString *)fileName content:(NSString *)content {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *realPath = [NSString stringWithFormat:@"%@/%@", documentPath, fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:realPath]) {
        NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
        [[NSFileManager defaultManager] createFileAtPath:realPath contents:data attributes:nil];
    } else {
        NSString *orig = [NSString stringWithContentsOfFile:realPath encoding:NSUTF8StringEncoding error:nil];
        content = [content stringByAppendingString:@"\n"];
        content = [content stringByAppendingString:orig];
        [content writeToFile:(NSString *)realPath atomically:(BOOL)false encoding:(NSStringEncoding)NSUTF8StringEncoding error:(NSError **)nil];
    }
}
+(void)storeData:(NSString *)fileName content:(NSData *)content {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *realPath = [NSString stringWithFormat:@"%@/%@", documentPath, fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:realPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:realPath error:NULL];
    }
    [[NSFileManager defaultManager] createFileAtPath:realPath contents:content attributes:nil];
}
+(NSString *)hexStringFromString:(NSString *)string {
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    NSString *hexStr = @"";
    for (int i = 0; i < [myD length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i] & 0xff];
        if ([newHexStr length] == 1) {
            hexStr = [NSString stringWithFormat:@"%@0%@", hexStr, newHexStr];
        } else {
            hexStr = [NSString stringWithFormat:@"%@%@", hexStr, newHexStr];
        }
    }
    return hexStr;
}
@end