//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIViewController.h"

#import "GamePauseViewDelegate.h"
#import "ShareManagerDelegate.h"
#import "UIPopoverControllerDelegate.h"

@class CADisplayLink, EAGLView, EvaluateJcfView, GamePauseView, MainGameRenderer, NSData, Sequence, ShareManager, TuneInfo, UIButton, UIImageView, UIView, jubeatLabAccess;

@interface GameViewController : UIViewController <UIPopoverControllerDelegate, GamePauseViewDelegate, ShareManagerDelegate>
{
    BOOL isPad;
    BOOL isSession;
    BOOL scoreSaved;
    BOOL isCustom;
    BOOL isDownload;
    double music_time;
    BOOL isMusicPlaying;
    float buttonTouchWidth;
    unsigned int buttonDown;
    unsigned int buttonUp;
    unsigned int buttonPress;
    unsigned int buttonPressOld;
    unsigned int draw_count;
    double past_time;
    float fps;
    int oldBestScore;
    UIView *coverView;
    EvaluateJcfView *evaluateView;
    jubeatLabAccess *playCountAccess;
    BOOL bGoodJobPress;
    jubeatLabAccess *goodJobCommit;
    TuneInfo *_currentTune;
    unsigned int _currentDiff;
    unsigned int _currentMarker;
    ShareManager *_shareManager;
    NSData *_musicData;
    EAGLView *_glView;
    MainGameRenderer *_mainGameRenderer;
    CADisplayLink *_displayLink;
    Sequence *_sequence;
    UIButton *_btnPause;
    UIImageView *_btnGoodJob;
    UIImageView *_goodJobTxt;
    GamePauseView *_pauseView;
}

@property(retain, nonatomic) GamePauseView *pauseView; // @synthesize pauseView=_pauseView;
@property(retain, nonatomic) UIImageView *goodJobTxt; // @synthesize goodJobTxt=_goodJobTxt;
@property(retain, nonatomic) UIImageView *btnGoodJob; // @synthesize btnGoodJob=_btnGoodJob;
@property(retain, nonatomic) UIButton *btnPause; // @synthesize btnPause=_btnPause;
@property(retain, nonatomic) Sequence *sequence; // @synthesize sequence=_sequence;
@property(retain, nonatomic) CADisplayLink *displayLink; // @synthesize displayLink=_displayLink;
@property(retain, nonatomic) MainGameRenderer *mainGameRenderer; // @synthesize mainGameRenderer=_mainGameRenderer;
@property(retain, nonatomic) EAGLView *glView; // @synthesize glView=_glView;
@property(retain, nonatomic) NSData *musicData; // @synthesize musicData=_musicData;
@property(retain, nonatomic) ShareManager *shareManager; // @synthesize shareManager=_shareManager;
@property(nonatomic) unsigned int currentMarker; // @synthesize currentMarker=_currentMarker;
@property(nonatomic) unsigned int currentDiff; // @synthesize currentDiff=_currentDiff;
@property(retain, nonatomic) TuneInfo *currentTune; // @synthesize currentTune=_currentTune;
- (void).cxx_destruct;
- (void)pushBtnGoodJob;
- (void)createGoodJobBtn;
- (void)dealloc;
- (void)jubeatLabAccessFinished:(id)arg1;
- (void)jubeatLabAccessError:(id)arg1;
- (void)requestAddPlayCount;
- (BOOL)shouldAutorotate;
- (unsigned int)supportedInterfaceOrientations;
- (BOOL)shouldAutorotateToInterfaceOrientation:(int)arg1;
- (void)viewDidDisappear:(BOOL)arg1;
- (void)viewWillDisappear:(BOOL)arg1;
- (void)viewDidAppear:(BOOL)arg1;
- (void)viewWillAppear:(BOOL)arg1;
- (void)viewDidUnload;
- (void)didReceiveMemoryWarning;
- (void)terminate;
- (void)resume;
- (void)suspend;
- (void)shareManager:(id)arg1 receiveFinalScore:(int)arg2 bonus:(int)arg3 fullCombo:(BOOL)arg4;
- (void)shareManager:(id)arg1 receiveScore:(int)arg2;
- (void)shareManagerMusicStartTimeOut:(id)arg1;
- (void)shareManager:(id)arg1 startMusicTime:(float)arg2;
- (void)shareManagerAllClientLoaded:(id)arg1;
- (void)shareManagerFailWithError:(id)arg1;
- (void)shareManager:(id)arg1 disconnectClient:(id)arg2;
- (void)shareManagerDisconnect:(id)arg1;
- (void)closeEvaluate:(id)arg1;
- (void)removeEvaluate;
- (void)sessionDisconnect:(BOOL)arg1;
- (void)end;
- (void)endInPauseView;
- (void)resumeInPauseView;
- (void)pushBtnPause:(id)arg1;
- (void)startGame;
- (void)loop:(id)arg1;
- (void)finishMusic:(id)arg1;
- (void)stopAnimation;
- (void)startAnimation;
- (void)saveScore;
- (void)releaseResources;
- (void)loadResources;
- (void)loadView;
- (id)soundName:(id)arg1;
- (id)init;

@end

