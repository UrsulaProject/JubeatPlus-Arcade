#define GameTitle @"Jubeat Addition"

#define IsLoadedKey @"IsLoaded"
#define IsStartedKey @"IsStarted"
#define IsAskedServerKey @"IsAskedServer"
#define ServerDataKey @"ServerData"

#define MusicId @"ID"
#define MusicGroup @"Code"
#define MusicVersion @"Version"

#define BlockKey @"BlockKey"
#define DeleteKey @"DeleteKey"

#define GroupPublic @"PUBLIC"
#define GroupPrivate @"PRIVATE"
#define GroupHK @"HK"
#define GroupOther @"OTHER"
#define GroupCN @"CN"
#define GroupSows @"SOWS"

#define SupportToJp NO

@interface JbaHelper : NSObject
+ (BOOL)decodeIfJba:(NSMutableDictionary *)application decodeData:(id)arg1;
+ (void)startApplicationBySupport:(NSMutableDictionary *)application songData:(NSMutableArray *)songData;
+ (void)startApplication:(NSMutableDictionary *)application songData:(NSMutableArray *)songData;
+ (NSDictionary *)validationKey:(NSString *)musicGroup;
+ (BOOL)isValidMusicData:(int)musicId musicDetail:(NSDictionary *)musicDetail serverData:(NSDictionary *)serverData;
@end
