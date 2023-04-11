@interface DesHelper : NSObject {}
+ (NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key;
+ (NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;
@end

