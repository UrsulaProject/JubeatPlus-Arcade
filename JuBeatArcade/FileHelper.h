@interface FileHelper : NSObject
+ (NSString *)documentPath;
+ (void)setupBySupport:(NSMutableArray *)songData serverData:(NSDictionary *)serverData;
+ (void)setup:(NSMutableArray *)songData serverData:(NSDictionary *)serverData;
+ (void)removeMusic:(int)musicId;
+ (BOOL)hasMusic:(int)musicId;
@end