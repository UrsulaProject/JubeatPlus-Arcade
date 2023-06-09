//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//
@class NSMutableArray, NSMutableData, NSMutableDictionary;

@interface EditDataManager : NSObject
{
    NSMutableArray *sequenceTable;//XML-Format Custom Sheet
    NSMutableDictionary *editorInfo;
    NSMutableDictionary *editSimpleData;
    NSMutableData *writeData;//Raw Binary Custom Sheet
    NSMutableDictionary *scoreData;
    unsigned int version;
    char musicBarTable[60];
    BOOL _bEnableCopy;
    BOOL _bIsDownload;
}

+ (id)sharedManager;
@property(nonatomic) BOOL bIsDownload; // @synthesize bIsDownload=_bIsDownload;
@property(readonly, nonatomic) BOOL bEnableCopy; // @synthesize bEnableCopy=_bEnableCopy;
- (id)getCurrentCustomData;
- (int)getEditSlotLimit;
- (int)getMusicNum;
- (id)getMusicIDList;
- (void)scoreUpdate:(int)arg1 fullCombo:(BOOL)arg2 tuneID:(int)arg3;
- (BOOL)checkScoreHash;
- (id)getScoreHash:(int)arg1;
- (BOOL)IsExistEditFile:(int)arg1;
- (void)setLastEditFileName:(int)arg1 fileName:(id)arg2;
- (id)getLastEditFilePath:(int)arg1;
- (id)getLastEditFileName:(int)arg1;
- (void)setSequenceTable:(id)arg1;
- (id)getSequenceTable;
- (void)resetEditorInfo;
- (void)clearEditData;
- (void)setEditSimpleData:(id)arg1;
- (id)getEditSimpleData;
- (void)setEditorInfo:(id)arg1;
- (id)getEditorInfo;
- (void)setScoreData:(id)arg1;
- (id)getScoreData;
- (void)disableEdit;
- (BOOL)isEnableEdit;
- (id)getFileInfoList:(unsigned int)arg1;
- (BOOL)encodeBinary;
- (BOOL)decodeBinary;
- (id)pickUpSequenceTable:(char *)arg1;
- (id)pickUpEditSimpleData:(char *)arg1;
- (id)pickUpEditorInfo:(char *)arg1;
- (id)pickUpScoreData:(char *)arg1;
- (void)scoreDataReset;
- (BOOL)validateHash:(id)arg1;
- (unsigned long)getCharArrayValue:(char *)arg1 byte:(int)arg2;
- (void)setCharArray:(char *)arg1 setData:(unsigned long)arg2 byte:(int)arg3;
- (id)pickUpEditorInfoFromData:(id)arg1;
- (BOOL)localSaveDLFile:(id)arg1 serial:(id)arg2 usrTag:(int)arg3;
- (BOOL)checkDownloadFile:(id)arg1;
- (BOOL)checkDownLoad:(char *)arg1;
- (id)createDLString:(char *)arg1 isDL:(BOOL)arg2;
- (id)exeBFDec:(id)arg1;
- (id)exeBFEnc:(id)arg1;
- (id)exeLoadBFDec:(id)arg1;
- (id)exeSaveBFEnc:(id)arg1;
- (BOOL)createEditDataWithNSData:(id)arg1;
- (BOOL)saveJCF:(id)arg1;//ARG1 =NSPathStore //Can Type-Casting To NSString
- (BOOL)loadJCF:(id)arg1;//ARG1 =NSPathStore //Can Type-Casting To NSString
- (BOOL)deleteJCF:(id)arg1;//ARG1 =NSPathStore //Can Type-Casting To NSString
- (id)createJCFName;
- (id)getDirectoryPath:(int)arg1;
- (BOOL)addIgnoreBackUpAttribute:(id)arg1;
- (void)deleteCustomSequenceDirectory:(id)arg1;
- (id)getCustomSequenceDirectoryList;
- (id)init;

@end

