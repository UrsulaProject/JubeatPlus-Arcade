#import <Foundation/Foundation.h>
#include <stdio.h>
#import <UIKit/UIKit.h>

#import "AFHTTPRequestOperationManager.h"

#import "BFCodec.h"
#import "KUnzip.h"
#import "DebugHelper.h"
#import "EncryptHelper.h"
#import "FileHelper.h"
#import "JbaHelper.h"
#import "ServerHelper.h"

@implementation JbaHelper
+ (BOOL)decodeIfJba:(NSMutableDictionary *)application decodeData:(id)arg1 {
    NSMutableData *decodeData = (NSMutableData *)arg1;
    if ([EncryptHelper isJbaHeader:(NSData *)arg1]) {
        NSDictionary *serverData = [application objectForKey:ServerDataKey];
        NSData *decryptedData = [EncryptHelper jbaDecrypt:decodeData serverData:serverData];
        [decodeData setData:decryptedData];
        return YES;
    }
    return NO;
}
+ (void)startApplicationBySupport:(NSMutableDictionary *)application songData:(NSMutableArray *)songData {
    NSDictionary *serverData = @{
                                 @"n": @"BoQGnWNBBc0=",
                                 @"u": @"cBCFtMBlGVngLvwBpTVBUQ==",
                                 @"e": @"Hjg9idmAptb7ataIe6tCCM6dxESAfjrUXDAnKrF/LdS/5Z8fm9HrNIoRLXXi2JRdQJ/BXlJ+U6QUCltA4I/KhVpYUBXxhOE9H3d3HZXG1useBieG67tqfQ715KuwXN3NX/1moKjG91KHZfVJ6QOeRQ==",
                                 @"b": @"7MaUbvgDBFQ=",
                                 @"i": @"2SCz0OnEW6k=",
                                 @"z": @"jIkgE969yjA=",
                                 @"p": @"fXvsb7gE2X8=",
                                 @"l": @"NuZXZ8FHP8E=",
                                 @"c": @"oxhWIy8Eho4=",
                                 @"g": @"Gl0y3NlNkJE=",
                                 @"m": @"GpjbVefWWVk=",
                                 @"y": @"jIjkpCWJbGI=",
                                 @"v": @"8wTOO44uwk0=",
                                 @"a": @"jeBoPPFBms4=",
                                 @"x": @"ThJoN7Xzluc=",
                                 @"k": @"ilv7pt/QtjFfn9+vVc5Mng==",
                                 @"t": @"DDkLdruk0HDzqgLVNCOqvA=="
                                 };
    [serverData retain];
    [application setObject:serverData forKey:ServerDataKey];
   // [FileHelper setupBySupport:songData serverData:serverData];
    [FileHelper setup:songData serverData:serverData];
}
+ (void)startApplication:(NSMutableDictionary *)application songData:(NSMutableArray *)songData {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[ServerHelper serverPath] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *serverData = (NSDictionary *)responseObject;
        [application setObject:[serverData retain] forKey:ServerDataKey];
        UIAlertView *className;
        NSLog(@"Server Data:%@",serverData);
        if (![ServerHelper allKeysExists:serverData]) {
            className = [[UIAlertView alloc] initWithTitle:GameTitle message:@"Please check your network." delegate:nil cancelButtonTitle:@"Exit" otherButtonTitles:nil];
        } else if ([ServerHelper serverIsClosed:serverData]) {
            className = [[UIAlertView alloc] initWithTitle:GameTitle message:@"The game is closed." delegate:nil cancelButtonTitle:@"Exit" otherButtonTitles:nil];
        } else if (![ServerHelper isLastVersion:serverData]) {
            className = [[UIAlertView alloc] initWithTitle:GameTitle message:@"Please update your plugin." delegate:nil cancelButtonTitle:@"Exit" otherButtonTitles:nil];
        } else if (![ServerHelper sessionValid:serverData]) {
            className = [[UIAlertView alloc] initWithTitle:GameTitle message:@"Please check your plugin." delegate:nil cancelButtonTitle:@"Exit" otherButtonTitles:nil];
        } else {
            if ([[application objectForKey:IsStartedKey] boolValue]) {
                className = [[UIAlertView alloc] initWithTitle:GameTitle message:@"Please check your network." delegate:nil cancelButtonTitle:@"Exit" otherButtonTitles:nil];
            } else {
                [application setObject:[NSNumber numberWithBool:YES] forKey:IsAskedServerKey];
                className = [[UIAlertView alloc] initWithTitle:GameTitle message:[ServerHelper decrypt:[serverData valueForKey:ServerMessageField]] delegate:nil cancelButtonTitle:[ServerHelper decrypt:[serverData valueForKey:ServerMessageButtonField]] otherButtonTitles:nil];
                [className show];
                [className release];
                [FileHelper setup:songData serverData:serverData];
            }
        }
        if (![[application objectForKey:IsAskedServerKey] boolValue]) {
            [className show];
            [className release];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Connect Failed:%@",error.localizedDescription);
        UIAlertView *className = [[UIAlertView alloc] initWithTitle:GameTitle message:@"Please check your network." delegate:nil cancelButtonTitle:@"Exit" otherButtonTitles:nil];
        [className show];
        [className release];
    }];
}
//filter the validation key from music group
+ (NSDictionary *)validationKey:(NSString *)musicGroup {
    if ([musicGroup isEqual:GroupPrivate]) {
        return @{BlockKey: PrivateBlockKey, DeleteKey: PrivateDeleteKey};
    } else if ([musicGroup isEqual:GroupHK]) {
        return @{BlockKey: HkBlockKey, DeleteKey: HkDeleteKey};
    } else if ([musicGroup isEqual:GroupOther]) {
        return @{BlockKey: OtherBlockKey, DeleteKey: OtherDeleteKey};
    } else if ([musicGroup isEqual:GroupCN]) {
        return @{BlockKey: CnBlockKey, DeleteKey: CnDeleteKey};
    } else if ([musicGroup isEqual:GroupSows]) {
        return @{BlockKey: SowsBlockKey, DeleteKey: SowsDeleteKey};
    }
    //public
    return @{BlockKey: PublicBlockKey, DeleteKey: PublicDeleteKey};
}
//checking the official music data need block or delete
+ (BOOL)isValidMusicData:(int)musicId musicDetail:(NSDictionary *)musicDetail serverData:(NSDictionary *)serverData {
    NSString *musicGroup = [musicDetail valueForKey:MusicGroup];
    NSDictionary *validationKey = [JbaHelper validationKey:musicGroup];
    NSString *blockKey = [validationKey valueForKey:BlockKey];
    NSString *deleteKey = [validationKey valueForKey:DeleteKey];
    NSString *musicIdAtString = [NSString stringWithFormat:@"%d", musicId];
    if (![musicIdAtString isEqual:[NSString stringWithFormat:@"%d", [[musicDetail valueForKey:MusicId] intValue]]]) {
        if (NeedDebug) {
            [DebugHelper storeFile:DebugFilename content:[NSString stringWithFormat:@"Inject Song - %d - Error 10001", musicId]];
        }
        return NO;
    }
    if ([[ServerHelper lists:[serverData valueForKey:blockKey]] containsObject:@"ALL"]) {
        if (NeedDebug) {
            [DebugHelper storeFile:DebugFilename content:[NSString stringWithFormat:@"Inject Song - %d - Error 10002", musicId]];
        }
        return NO;
    }
    if ([[ServerHelper lists:[serverData valueForKey:deleteKey]] containsObject:musicIdAtString]) {
        if (NeedDebug) {
            [DebugHelper storeFile:DebugFilename content:[NSString stringWithFormat:@"Inject Song - %d - Error 10003", musicId]];
        }
        [FileHelper removeMusic:musicId];
        return NO;
    }
    if ([[ServerHelper lists:[serverData valueForKey:deleteKey]] containsObject:@"ALL"]) {
        if (NeedDebug) {
            [DebugHelper storeFile:DebugFilename content:[NSString stringWithFormat:@"Inject Song - %d - Error 10004", musicId]];
        }
        [FileHelper removeMusic:musicId];
        return NO;
    }
    if ([[ServerHelper lists:[serverData valueForKey:blockKey]] containsObject:musicIdAtString]) {
        if (NeedDebug) {
            [DebugHelper storeFile:DebugFilename content:[NSString stringWithFormat:@"Inject Song - %d - Error 10005", musicId]];
        }
        return NO;
    }
    if (LAST_VERSION < [[musicDetail valueForKey:MusicVersion] intValue]) {
        if (NeedDebug) {
            [DebugHelper storeFile:DebugFilename content:[NSString stringWithFormat:@"Inject Song - %d - Error 10006", musicId]];
        }
        return NO;
    }
    return YES;
}
@end