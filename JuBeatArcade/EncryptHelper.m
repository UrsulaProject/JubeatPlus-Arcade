#import <Foundation/Foundation.h>

#import "Base64.h"
#import "RNDecryptor.h"

#import "EncryptHelper.h"
#import "ServerHelper.h"

@implementation EncryptHelper
//pass the decrypy data to check the header is it jba encrypt files
+ (BOOL)isJbaHeader:(NSData *)decryptData {
    NSUInteger length = [decryptData length];
    if (length <= 12) {
        return NO;
    }
    NSArray *jbaHeader = @[@"3d", @"4a", @"42", @"41", @"44", @"44", @"49", @"54", @"49", @"4f", @"4e", @"3d"];
    NSMutableArray *bytes = [NSMutableArray array];
    for (NSUInteger i = 0; i < 12; i++) {
        unsigned char byte;
        [decryptData getBytes:&byte range:NSMakeRange(i, 1)];
        [bytes insertObject:[NSString stringWithFormat:@"%x", byte] atIndex:i];
    }
    for (NSUInteger i = 0; i < 12; i++) {
        if (![[bytes objectAtIndex:i] isEqual:[jbaHeader objectAtIndex:i]]) {
            return NO;
        }
    }
    return YES;
}
//pass the decrypt data and server data, get the password from server 
+ (NSData *)jbaDecrypt:(NSData *)decryptData serverData:(NSDictionary *)serverData {
    NSString *decryptDataString = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
    decryptDataString = [decryptDataString substringFromIndex:12];
    NSData *jbaDecryptData = [NSData dataWithBase64EncodedString:decryptDataString];
    NSError *error;
    NSString *password = [ServerHelper decrypt:[serverData valueForKey:PasswordField]];
    return [RNDecryptor decryptData:jbaDecryptData withPassword:@"g3s5u8j6b8" error:&error];
}
@end