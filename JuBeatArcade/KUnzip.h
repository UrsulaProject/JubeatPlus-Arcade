@interface KUnzip : NSObject
{
    void *zipfile;
    unsigned char buffer[65536];
    NSFileHandle *_fileHandle;
    NSData *_data;
    unsigned int _dataCurrentPos;
    struct _NSRange _dataRange;
}

@property(readonly, nonatomic) struct _NSRange dataRange; // @synthesize dataRange=_dataRange;
@property(nonatomic) unsigned int dataCurrentPos; // @synthesize dataCurrentPos=_dataCurrentPos;
@property(retain, nonatomic) NSData *data; // @synthesize data=_data;
@property(retain, nonatomic) NSFileHandle *fileHandle; // @synthesize fileHandle=_fileHandle;
- (void)dealloc;
- (id)uncompress:(id)arg1;
- (id)fileList;
- (unsigned long)uncompressedSize:(id)arg1;
- (BOOL)fileExists:(id)arg1;
- (id)initWithData:(id)arg1 range:(struct _NSRange)arg2;
- (id)initWithPath:(id)arg1 tail:(unsigned int)arg2;
- (id)initWithPath:(id)arg1;

@end

