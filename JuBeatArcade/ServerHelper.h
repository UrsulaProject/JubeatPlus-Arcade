#define HTTP @"ifuJD9R/bI0="//http://
#define DOMAINS @"EXUS4FBaekFv0YWBQ7MvC8OzfsL2hDfw" //rbarcade.82flex.com/   key:@"WHYTRYTOFINDKEY"
#define QUERY @"5zzysjkthbA=" //jba.php
#define KEY1 @"M0Q4"

#define MAX_NUMBER(a,b) ( ((a) > (b)) ? (a) : (b) )
#define MIN_NUMBER(a,b) ( ((a) < (b)) ? (a) : (b) )

#define LAST_VERSION 100
#define MAX_SESSION_SEC 172800

#define CanDebugCustomText @"CAN"
#define CanDebugOfficialText @"YES"

#define PasswordField @"u"
#define ServerMessageField @"e"
#define ServerMessageButtonField @"b"
#define ServerLastVersionField @"n"
#define ServerTimeField @"t"

#define PrivateBlockKey @"z"
#define PrivateDeleteKey @"y"
#define HkBlockKey @"c"
#define HkDeleteKey @"x"
#define OtherBlockKey @"l"
#define OtherDeleteKey @"a"
#define CnBlockKey @"g"
#define CnDeleteKey @"k"
#define SowsBlockKey @"p"
#define SowsDeleteKey @"v"
#define PublicBlockKey @"i"
#define PublicDeleteKey @"m"

@interface ServerHelper : NSObject
+ (NSString *)urlKey;
+ (NSString *)serverPath;
+ (NSString *)key:(NSString *)key3;
+ (NSString *)decrypt:(NSString *)encryptedString;
+ (NSArray *)lists:(NSString *)encryptedString;
+ (BOOL)allKeysExists:(NSDictionary *)serverData;
+ (BOOL)serverIsClosed:(NSDictionary *)serverData;
+ (BOOL)isLastVersion:(NSDictionary *)serverData;
+ (BOOL)sessionValid:(NSDictionary *)serverData;
@end