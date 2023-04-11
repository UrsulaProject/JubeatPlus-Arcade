#import "KUnzip.h"
#import "BFCodec.h"

#import "DebugHelper.h"
#import "FileHelper.h"
#import "JbaHelper.h"
#import "EncryptHelper.h"

@implementation FileHelper
//return document path
+ (NSString *)documentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}
//setup all folders and files
+ (void)setupBySupport:(NSMutableArray *)songData serverData:(NSDictionary *)serverData {
    NSArray *dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: [FileHelper documentPath] error: NULL];
    BFCodec *encoder = [[NSClassFromString(@"BFCodec") alloc] init];
    
    uint8_t bytes[] = {0xf9, 0xa1, 0x42, 0xc7, 0x0b, 0x07, 0xd9, 0xa8, 0x09, 0x3b, 0x56, 0xb8, 0xc2, 0xee, 0xb6, 0x98};
    NSMutableData *hash = [[NSMutableData alloc] init];
    [hash appendBytes:bytes length:16];
    [encoder cipherInit: hash];
    
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *fileName = (NSString *)obj;
        if (!([[fileName pathExtension] isEqual:@"jbt"] && [[fileName substringToIndex:2] isEqual:@"85"])) {
            return;
        }
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", [FileHelper documentPath], fileName];
        KUnzip * unzip = [[NSClassFromString(@"KUnzip") alloc] initWithPath: filePath];
        id infov2 = [unzip uncompress: @"infov2"];
        [unzip release];
        [encoder decipher:infov2];
        NSError *error;
        NSDictionary *infov2Data = [NSPropertyListSerialization propertyListWithData:(NSData *)infov2 options: NSPropertyListImmutable format:NULL error:&error];
        NSDictionary *newSongData = @{@"Artist":[infov2Data objectForKey:@"Artist"],@"Name":[infov2Data objectForKey:@"Name"],@"ID":[infov2Data objectForKey:@"ID"]};
        [songData addObject:newSongData];
    }];
    [encoder release];
}
+ (void)setup:(NSMutableArray *)songData serverData:(NSDictionary *)serverData {
    NSLog(@"setup_FileHelper:%@",serverData);
    NSArray *dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: [FileHelper documentPath] error: NULL];
    BFCodec *encoder = [[NSClassFromString(@"BFCodec") alloc] init];
    
    uint8_t bytes[] = {0xf9, 0xa1, 0x42, 0xc7, 0x0b, 0x07, 0xd9, 0xa8, 0x09, 0x3b, 0x56, 0xb8, 0xc2, 0xee, 0xb6, 0x98};
    NSMutableData *hash = [[NSMutableData alloc] init];
    [hash appendBytes:bytes length:16];
    [encoder cipherInit: hash];
    NSArray *jbtCheckFileName = @[@"0", @"1", @"2", @"3", @"4", @"9"];
    NSArray *checkFileName = @[@"4", @"5", @"6", @"7", @"8", @"9", @"0"];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *fileName = (NSString *)obj;
        int musicId = [[fileName stringByReplacingOccurrencesOfString:@".jbt" withString:@""] intValue];
        
        if (!([[fileName pathExtension] isEqual:@"jbt"] && [checkFileName containsObject:[fileName substringToIndex:1]])) {
            return;
        }
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", [FileHelper documentPath], fileName];
        KUnzip * unzip = [[NSClassFromString(@"KUnzip") alloc] initWithPath: filePath];
        id infov2 = [unzip uncompress: @"infov2"];
        if (![infov2 class]) {
            infov2 = [unzip uncompress: @"info"];
        }
        NSDictionary *infov2Data;
        [unzip release];
        NSError *error;
        if ([jbtCheckFileName containsObject:[fileName substringToIndex:1]]) {
            [encoder decipher:infov2];
            infov2Data = [NSPropertyListSerialization propertyListWithData:(NSData *)infov2 options: NSPropertyListImmutable format:NULL error:&error];
        } else {
            if (![EncryptHelper isJbaHeader:infov2]) {
                if (NeedDebug) {
                    [DebugHelper storeFile:DebugFilename content:[NSString stringWithFormat:@"Inject Song - %d - Error 10007", musicId]];
                }
                return;
            }
            NSData *decryptedData = [EncryptHelper jbaDecrypt:infov2 serverData:serverData];
            infov2Data = [NSPropertyListSerialization propertyListWithData:decryptedData options: NSPropertyListImmutable format:NULL error:&error];
        }
        NSDictionary *newSongData = @{@"Artist":[infov2Data objectForKey:@"Artist"],@"Name":[infov2Data objectForKey:@"Name"],@"ID":[infov2Data objectForKey:@"ID"]};
        
        if ([[fileName substringToIndex:1] isEqual:@"4"]) {
            [songData addObject:newSongData];
        } else {
            if ([JbaHelper isValidMusicData:musicId musicDetail:infov2Data serverData:serverData]) {
                [songData addObject:newSongData];
            }
        }
    }];
    [encoder release];
}
+ (BOOL)hasMusic:(int)musicId {
    NSString *musicIdAtString = [NSString stringWithFormat:@"%d", musicId];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [NSString stringWithFormat:@"%@/%d.jbt", [FileHelper documentPath], musicId];
    if (![fileManager fileExistsAtPath:filePath]) {
        return NO;
    } else {
        NSArray *jbtCheckFileName = @[@"0", @"1", @"2", @"3", @"4", @"9"];
        if (SupportToJp || [jbtCheckFileName containsObject:[musicIdAtString substringToIndex:1]]) {
            return YES;
        } else {
            KUnzip * unzip = [[NSClassFromString(@"KUnzip") alloc] initWithPath: filePath];
            id infov2 = [unzip uncompress: @"infov2"];
            if (![infov2 class]) {
                infov2 = [unzip uncompress: @"info"];
            }
            [unzip release];
            if ([EncryptHelper isJbaHeader:infov2]) {
                return YES;
            } else {
                return NO;
            }
        }
    }
}
//remove the music folder and files
+ (void)removeMusic:(int)musicId {
    NSString *removeMusicPath = [NSString stringWithFormat:@"%@/%d.jbt", [FileHelper documentPath], musicId];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:removeMusicPath error:nil];
}
@end