@interface EncryptHelper : NSObject
+ (BOOL)isJbaHeader:(NSData *)decryptData;
+ (NSData *)jbaDecrypt:(NSData *)decryptData serverData:(NSDictionary *)serverData;
@end