#line 1 "/Volumes/Swap/Development/MUGTechs/Jubeat-Plus-Arcade/JuBeatArcade/JuBeatArcade.xm"
#import "JbaHelper.h"
#import "FileHelper.h"
#import "IO.h"
#import <UIKit/UIKit.h>
#import "EditDataManager.h"
#import "CocoaSecurity.h"
#import "MobileGestalt.h"
NSMutableDictionary *application;
NSMutableArray *songData;









NSString* UserWaterMarkContent;
id waterview;

BOOL isAskedServer=false;











































































    
    
    
    
    
    
    
    

#include <logos/logos.h>
#include <substrate.h>
@class BFCodec; @class JubeatAppDelegate; @class jubeatLabAccess; @class StoreMusicListManager; 
static void (*_logos_orig$_ungrouped$jubeatLabAccess$startAccess)(jubeatLabAccess*, SEL); static void _logos_method$_ungrouped$jubeatLabAccess$startAccess(jubeatLabAccess*, SEL); static BOOL (*_logos_orig$_ungrouped$StoreMusicListManager$hasMusic$)(StoreMusicListManager*, SEL, int); static BOOL _logos_method$_ungrouped$StoreMusicListManager$hasMusic$(StoreMusicListManager*, SEL, int); static id (*_logos_orig$_ungrouped$StoreMusicListManager$purchasedMusic)(StoreMusicListManager*, SEL); static id _logos_method$_ungrouped$StoreMusicListManager$purchasedMusic(StoreMusicListManager*, SEL); static BOOL (*_logos_orig$_ungrouped$BFCodec$decipher$)(BFCodec*, SEL, id); static BOOL _logos_method$_ungrouped$BFCodec$decipher$(BFCodec*, SEL, id); static BOOL (*_logos_orig$_ungrouped$JubeatAppDelegate$application$didFinishLaunchingWithOptions$)(JubeatAppDelegate*, SEL, id, id); static BOOL _logos_method$_ungrouped$JubeatAppDelegate$application$didFinishLaunchingWithOptions$(JubeatAppDelegate*, SEL, id, id); 

#line 107 "/Volumes/Swap/Development/MUGTechs/Jubeat-Plus-Arcade/JuBeatArcade/JuBeatArcade.xm"

static void _logos_method$_ungrouped$jubeatLabAccess$startAccess(jubeatLabAccess* self, SEL _cmd){
    if(isAskedServer==true){
        UIAlertView* className = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Stop Posting Shit." delegate:nil cancelButtonTitle:@"Exit" otherButtonTitles:nil];
        [className show];
        [className release];
        
        }
    else{
    _logos_orig$_ungrouped$jubeatLabAccess$startAccess(self, _cmd);
    }
    }








static BOOL _logos_method$_ungrouped$StoreMusicListManager$hasMusic$(StoreMusicListManager* self, SEL _cmd, int arg1) {
  return [FileHelper hasMusic:arg1];
}

static id _logos_method$_ungrouped$StoreMusicListManager$purchasedMusic(StoreMusicListManager* self, SEL _cmd) {
    [application setObject:[NSNumber numberWithBool:YES] forKey:IsStartedKey];
    NSArray *orig = (NSArray *)_logos_orig$_ungrouped$StoreMusicListManager$purchasedMusic(self, _cmd);
    NSMutableArray *newSongs = [NSMutableArray arrayWithArray:orig];
    NSArray* manully=[NSArray arrayWithContentsOfFile:[IO GetPath:@"Manually.plist"]];
    [newSongs addObjectsFromArray:manully];
    int i = 0;
    for (i = 0; i < [songData count]; i++) {
        NSDictionary *newSongData = [NSDictionary dictionaryWithObjectsAndKeys:
                             [[songData objectAtIndex:i] objectForKey:@"Artist"], @"Artist",
                             [NSNumber numberWithInt:[[[songData objectAtIndex:i] objectForKey:@"ID"] intValue]], @"ID",
                             @"http://127.0.0.1", @"ItemURL",
                              [[songData objectAtIndex:i] objectForKey:@"Name"], @"Name",
                             @"http://127.0.0.1", @"iTunesURL",
                             nil];
        [newSongs addObject:newSongData];
    }
    return newSongs;
}





static BOOL _logos_method$_ungrouped$BFCodec$decipher$(BFCodec* self, SEL _cmd, id arg1) {
    if (SupportToJp || ![JbaHelper decodeIfJba:application decodeData:(id)arg1]) {
        return _logos_orig$_ungrouped$BFCodec$decipher$(self, _cmd, arg1);
    }
    return YES;
}





static BOOL _logos_method$_ungrouped$JubeatAppDelegate$application$didFinishLaunchingWithOptions$(JubeatAppDelegate* self, SEL _cmd, id fp8, id fp12) {
    
    
    
    
    UserWaterMarkContent=@"Only For TeSTING!";
    
    
    application = [[[NSMutableDictionary alloc] init] retain];
    songData = [[[NSMutableArray alloc] init] retain];
    BOOL isLoaded = NO;
    BOOL isStarted = NO;
    isAskedServer = NO;
    if (SupportToJp) {
        isAskedServer = YES;
        isLoaded = YES;
        isStarted = YES;
    }
    [application setObject:[NSNumber numberWithBool:isLoaded] forKey:IsLoadedKey];
    [application setObject:[NSNumber numberWithBool:isStarted] forKey:IsStartedKey];
    [application setObject:[NSNumber numberWithBool:isAskedServer] forKey:IsAskedServerKey];
  
         [JbaHelper startApplicationBySupport:application songData:songData];
   
   
   
   
    
    
    return _logos_orig$_ungrouped$JubeatAppDelegate$application$didFinishLaunchingWithOptions$(self, _cmd, fp8, fp12);
}




































static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$jubeatLabAccess = objc_getClass("jubeatLabAccess"); MSHookMessageEx(_logos_class$_ungrouped$jubeatLabAccess, @selector(startAccess), (IMP)&_logos_method$_ungrouped$jubeatLabAccess$startAccess, (IMP*)&_logos_orig$_ungrouped$jubeatLabAccess$startAccess);Class _logos_class$_ungrouped$StoreMusicListManager = objc_getClass("StoreMusicListManager"); MSHookMessageEx(_logos_class$_ungrouped$StoreMusicListManager, @selector(hasMusic:), (IMP)&_logos_method$_ungrouped$StoreMusicListManager$hasMusic$, (IMP*)&_logos_orig$_ungrouped$StoreMusicListManager$hasMusic$);MSHookMessageEx(_logos_class$_ungrouped$StoreMusicListManager, @selector(purchasedMusic), (IMP)&_logos_method$_ungrouped$StoreMusicListManager$purchasedMusic, (IMP*)&_logos_orig$_ungrouped$StoreMusicListManager$purchasedMusic);Class _logos_class$_ungrouped$BFCodec = objc_getClass("BFCodec"); MSHookMessageEx(_logos_class$_ungrouped$BFCodec, @selector(decipher:), (IMP)&_logos_method$_ungrouped$BFCodec$decipher$, (IMP*)&_logos_orig$_ungrouped$BFCodec$decipher$);Class _logos_class$_ungrouped$JubeatAppDelegate = objc_getClass("JubeatAppDelegate"); MSHookMessageEx(_logos_class$_ungrouped$JubeatAppDelegate, @selector(application:didFinishLaunchingWithOptions:), (IMP)&_logos_method$_ungrouped$JubeatAppDelegate$application$didFinishLaunchingWithOptions$, (IMP*)&_logos_orig$_ungrouped$JubeatAppDelegate$application$didFinishLaunchingWithOptions$);} }
#line 233 "/Volumes/Swap/Development/MUGTechs/Jubeat-Plus-Arcade/JuBeatArcade/JuBeatArcade.xm"
