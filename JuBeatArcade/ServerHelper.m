#import "GTMBase64.h"

#import "DesHelper.h"
#import "ServerHelper.h"
#import "MobileGestalt.h"
#import "CocoaSecurity.h"
@implementation ServerHelper
//get the url encode key
+ (NSString *)urlKey {
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@%@%@", @"ZT", @"Uz", @"RG", @"cz", @"Yl", @"c="];
    NSData *data = [GTMBase64 decodeString:url];
    return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
}
//init server path
+ (NSString *)serverPath {
    
return @"http://navillezhang.me/jba.php";
}
//init des key
+ (NSString *)key:(NSString *)key3 {
    NSString *key2 = @"YTlo";
    return [NSString stringWithFormat:@"%@%@%@", KEY1, key2, key3];
}
//decode des action
+ (NSString *)decrypt:(NSString *)encryptedString {
    NSData *data = [GTMBase64 decodeString:[ServerHelper key:@"MEM="]];
    NSString *key = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSString* resultString= [DesHelper decryptUseDES:encryptedString key:key];
   // NSLog(@"resultKey:%@ DECRYPTKEY:%@ encryptedString:%@ data:%@",resultString,key,encryptedString,data);
    return resultString;
}
//decode and init string [xxx,xxx,xxx] to array
+ (NSArray *)lists:(NSString *)encryptedString {
    NSString *songList = [ServerHelper decrypt:encryptedString];

    NSArray *replaceKeys = @[
        @"[", @"]",  @"(", @")", @"{", @"}", @"<", @">",
        @"[[", @"]]", @"((", @"))", @"{{", @"}}", @"<<", @">>",
        @"[[[", @"]]]", @"(((", @")))", @"{{{", @"}}}", @"<<<", @">>>",
        @"[[[[", @"]]]]", @"((((", @"))))", @"{{{{", @"}}}}", @"<<<<", @">>>>"
    ];
    for (NSUInteger i = 0; i < [replaceKeys count]; i++) {
        songList = [songList stringByReplacingOccurrencesOfString:[replaceKeys objectAtIndex:i] withString:@""];
    }
    return [songList componentsSeparatedByString:@","];
}
//checking all the keys are existing
+ (BOOL)allKeysExists:(NSDictionary *)serverData {
    NSArray *checkKeys = @[
        PasswordField,
        ServerMessageField,
        ServerMessageButtonField,
        ServerLastVersionField,
        ServerTimeField,
        PrivateBlockKey,
        PrivateDeleteKey,
        HkBlockKey,
        HkDeleteKey,
        OtherBlockKey,
        OtherDeleteKey,
        CnBlockKey,
        CnDeleteKey,
        SowsBlockKey,
        SowsDeleteKey,
        PublicBlockKey,
        PublicDeleteKey
    ];
    for (NSUInteger i = 0; i < [checkKeys count]; i++) {
        if (![[serverData allKeys] containsObject:[checkKeys objectAtIndex:i]]) {
            return NO;
        }
    }
    return YES;
}
//checking the server is closed
+ (BOOL)serverIsClosed:(NSDictionary *)serverData {
    if ([[ServerHelper decrypt:[serverData valueForKey:ServerLastVersionField]] intValue] == 0) {
        return YES;
    }
    return NO;
}
//checking the last version
+ (BOOL)isLastVersion:(NSDictionary *)serverData {
    if ([[ServerHelper decrypt:[serverData valueForKey:ServerLastVersionField]] intValue] > LAST_VERSION) {
        return NO;
    }
    return YES;
}
//checking the session
+ (BOOL)sessionValid:(NSDictionary *)serverData {
    double serverTime = [[ServerHelper decrypt:[serverData valueForKey:ServerTimeField]] doubleValue];
    double currentTime = [[NSDate date] timeIntervalSince1970];
    double max = MAX_NUMBER(serverTime, currentTime);
    double min = MIN_NUMBER(serverTime, currentTime);
    if (max - min > MAX_SESSION_SEC) {
        return NO;
    }
    return YES;
}
@end