#import "JbaHelper.h"
#import "FileHelper.h"
#import "IO.h"
#import <UIKit/UIKit.h>
#import "EditDataManager.h"
#import "CocoaSecurity.h"
#import "MobileGestalt.h"
NSMutableDictionary *application;
NSMutableArray *songData;
/*typedef struct T_BLOWFISH{
    
   // SInt32 P[16 + 2];
  //  SInt32 S[4][256];
   short P[16 + 2];
   short S[4][256];
}T_BLOWFISH;
*/

NSString* UserWaterMarkContent;
id waterview;

BOOL isAskedServer=false;
/*NSMutableArray *keylist=[NSMutableArray arrayWithCapacity:20];
//Dump BFCodec
%hook BFCodec
-(unsigned int)encipher:(id)arg1{
    T_BLOWFISH TBF=MSHookIvar<T_BLOWFISH>(self,"_blf");
    
    NSMutableString* PBOXSTR=[[NSMutableString alloc] init];
    for(int i=1;i<=18;i++){
        int a=TBF.P[i];
        [PBOXSTR appendString:[NSString stringWithFormat:@",%i",a]];
        
        
    }
    NSLog(@"Key is:%@",PBOXSTR);
    return %orig;
    
    
}
%end*/
//End BFCodec Dump













/*@interface UIViewController (tweak)
- (UILabel*)circle;
@end

%hook UIViewController
- (void)viewDidAppear:(BOOL)animated{
    %orig;
waterview=[self circle];
    [self.view addSubview:waterview];
    [self.view bringSubviewToFront:waterview];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    %orig;
    [waterview removeFromSuperview];
    
    
    
    
}

%new
- (UILabel*)circle{
    UILabel* watermark;
    watermark=[[UILabel alloc] initWithFrame:CGRectMake(0,0,560,80)];
    watermark.backgroundColor=[UIColor clearColor];
    watermark.text=[NSString stringWithFormat:@"JBAC+"];
    
    
    
    watermark.textAlignment=UITextAlignmentCenter;
    
    watermark.lineBreakMode=UILineBreakModeCharacterWrap;
    watermark.userInteractionEnabled=NO;
    watermark.adjustsFontSizeToFitWidth=YES;
    watermark.textColor=[UIColor blueColor];
    return watermark;
}

%end*/


    
    
    
    
    
    
    
    

%hook jubeatLabAccess
- (void)startAccess{
    if(isAskedServer==true){
        UIAlertView* className = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Stop Posting Shit." delegate:nil cancelButtonTitle:@"Exit" otherButtonTitles:nil];
        [className show];
        [className release];
        
        }
    else{
    %orig;
    }
    }
%end





%hook StoreMusicListManager
//save score will call this function to check
- (BOOL)hasMusic:(int)arg1 {
  return [FileHelper hasMusic:arg1];
}
//return the orig music list and addition list
- (id)purchasedMusic {
    [application setObject:[NSNumber numberWithBool:YES] forKey:IsStartedKey];
    NSArray *orig = (NSArray *)%orig;
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
%end


//check the data what you need to decode, if the header is jba file , use own decode function
%hook BFCodec
- (BOOL)decipher:(id)arg1 {
    if (SupportToJp || ![JbaHelper decodeIfJba:application decodeData:(id)arg1]) {
        return %orig;
    }
    return YES;
}
%end


//add the server checking when start
%hook JubeatAppDelegate
-(BOOL)application:(id)fp8 didFinishLaunchingWithOptions:(id)fp12 {
    
    
    
    
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
  //  if (SupportToJp) {
         [JbaHelper startApplicationBySupport:application songData:songData];
   // } else {
   //      [JbaHelper startApplication:application songData:songData];
   // }
   
    
    
    return %orig;
}
%end
/*%hook MarkerManager
+ (BOOL)enableMarkerSelect{
    %orig;
    return true;
}
+ (BOOL)checkMarkerData:(id)arg1{
    %orig;
    return true;
}
+ (BOOL)checkMarkerBannerData:(id)arg1{
    %orig;
    return true;
}
+ (id)getMarkerList{
NSMutableArray* origarray=MSHookIvar<NSMutableArray*>(self,"downloadList");
    NSArray* newret=[NSArray arrayWithContentsOfFile:[IO GetPath:@"MarkerList.plist"]];
    origarray=[NSMutableArray arrayWithArray:newret];
    return newret;

    
}
%end
    */












