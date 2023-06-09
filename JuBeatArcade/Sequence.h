//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@interface Sequence : NSObject
{
    CDStruct_a1d368ec *events;
    unsigned int numEvent;
    unsigned int numPlayEvent;
    unsigned int endSector;
    char musicBar[60];
    unsigned int currentIndex;
    unsigned int judgedIndex;
    unsigned int currentTempo;
    unsigned int oldTempo;
    unsigned int lastHakuSector;
    unsigned int nextHakuSector;
    unsigned int lastMeasureSector;
    unsigned int nextMeasureSector;
    short lastJudge[16];
    unsigned int lastJudgeSector[16];
    CDStruct_c6ce2fc0 gameScore;
    unsigned int replaceTable[16];
    unsigned short _firstMarker;
    unsigned int _currentSector;
    unsigned int _firstMarkerSector;
    double _currentTime;
}

+ (short)rankOfPoint:(unsigned int)arg1;
+ (void)getMusicBarData:(char *)arg1 raw:(id)arg2;
@property(readonly, nonatomic) unsigned int firstMarkerSector; // @synthesize firstMarkerSector=_firstMarkerSector;
@property(readonly, nonatomic) unsigned short firstMarker; // @synthesize firstMarker=_firstMarker;
@property(readonly, nonatomic) unsigned int currentSector; // @synthesize currentSector=_currentSector;
@property(readonly, nonatomic) double currentTime; // @synthesize currentTime=_currentTime;
- (void)dealloc;
- (void)judge:(int)arg1;
- (void)addJudge:(short)arg1;
@property(readonly, nonatomic) float playPosition;
@property(readonly, nonatomic) float measurePhase;
@property(readonly, nonatomic) float hakuPhase;
- (const char *)getMusicBar;
- (short)rank;
- (BOOL)isExcellent;
- (BOOL)isFullcombo;
- (const CDStruct_c6ce2fc0 *)getScore;
- (void)getMarkerState:(int *)arg1;
- (void)seekToTime:(double)arg1;
- (void)reset;
- (id)initWithCustomData:(id)arg1 tableData:(id)arg2;//arg1&arg2 =NSArray
- (id)initWithData:(id)arg1;
- (void)replaceFirstMarker;
- (void)createRandomTable;

@end

