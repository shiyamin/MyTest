//
//  Security3DES.m
//  3DES
//
//  Created by 赵进雄 on 16-11-2.
//  Copyright (c) 2014年 zhaojinxiong. All rights reserved.
//

#import "Security3DES.h"
@implementation Security3DES

//3DES加密  VERSION 3
+ (NSString *) encryptUse3DES_V3:(NSString *)plainText key:(NSString *)key ivKey:(unsigned char *)iv;
{
    //key
    NSData *data = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *bData = [GTMBase64 decodeData:data];
    unsigned char *pKey = (unsigned char *)[bData bytes];
    
    unsigned char iv1[8] = {1,2,3,4,5,6,7,8};
    iv = iv1;

    //原文
//    size_t plainTextBufferSize = [plainText length];   //明文的data长度
    size_t plainTextBufferSize = [self convertToInt:plainText] ;
    const void *vplainText = (const void *)[plainText UTF8String];  //明文的byte形式
    
    //数据输出
    size_t bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    uint8_t *bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    //--
    size_t movedBytes = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,           //加密or解密
                                          kCCAlgorithm3DES,     //算法，DESor3DES等
                                          kCCOptionPKCS7Padding,//加密模式
                                          pKey,                 //key  const void *
                                          kCCKeySize3DES,       //key的长度  size_t
                                          iv,                   //iv向量   const void *
                                          vplainText,            //数据输入  const void *
                                          plainTextBufferSize,           //数据长度  size_t
                                          (void *)bufferPtr,               //数据输出，缓冲区  void *
                                          bufferPtrSize,        //缓冲区的长度  size_t
                                          &movedBytes);  //size_t *
    NSString *ciphertext = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:bufferPtr length:(NSUInteger)movedBytes];
        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    }
    return ciphertext;
}

// 解密
+ (NSString *)decryptUse3DES_V3:(NSString *)plainText key:(NSString *)key ivKey:(NSString *)ivKey
{
    //key
//    unsigned char pKey[24] = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x'};
    NSData *data = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *bData = [GTMBase64 decodeData:data];
    unsigned char *pKey = (unsigned char *)[bData bytes];

    
    //iv
    unsigned char iv[8] = {1,2,3,4,5,6,7,8};
    
    //原文
    NSData * EncryptData = [GTMBase64 decodeData:[plainText
                                                  dataUsingEncoding:NSUTF8StringEncoding]];
    
    size_t plainTextBufferSize = plainTextBufferSize= [EncryptData length];
    const void *  vplainText =[EncryptData bytes];
    
    
    //数据输出
    size_t bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    uint8_t *bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    //--
    size_t movedBytes = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,           //加密or解密
                                          kCCAlgorithm3DES,     //算法，DESor3DES等
                                          kCCOptionPKCS7Padding,//加密模式
                                          pKey,                 //key  const void *
                                          kCCKeySize3DES,       //key的长度  size_t
                                          iv,                   //iv向量   const void *
                                          vplainText,            //数据输入  const void *
                                          plainTextBufferSize,           //数据长度  size_t
                                          (void *)bufferPtr,               //数据输出，缓冲区  void *
                                          bufferPtrSize,        //缓冲区的长度  size_t
                                          &movedBytes);  //size_t *
    NSString * result;
    if (cryptStatus == kCCSuccess) {
        result = [[NSString alloc] initWithData:[NSData
                                                 dataWithBytes:(const void *)bufferPtr
                                                 length:(NSUInteger)movedBytes]
                                       encoding:NSUTF8StringEncoding];
        ;
        
    }
    return result;
    
}

///判断中英混合的的字符串长度
+ (int)convertToInt:(NSString*)strtemp {
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+(strlength-strtemp.length));
    
}




@end
