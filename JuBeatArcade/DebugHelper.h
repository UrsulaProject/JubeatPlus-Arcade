#define NeedDebug NO
#define DebugFilename @"debug.log"

@interface DebugHelper:NSObject {}
+(void)storeFile:(NSString *)fileName content:(NSString *)content;
+(void)storeData:(NSString *)fileName content:(NSData *)content;
+(NSString *)hexStringFromString:(NSString *)string;
@end