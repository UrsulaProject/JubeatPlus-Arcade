@interface BFCodec : NSObject
{
    unsigned char _iv[8];
    struct T_BLOWFISH *_blf;
}

- (void)dealloc;
- (BOOL)decipher:(id)arg1;
- (unsigned int)encipher:(id)arg1;
- (void)cipherInit:(id)arg1;
- (void)cipherInit:(const char *)arg1 length:(int)arg2;
- (id)init;

@end

