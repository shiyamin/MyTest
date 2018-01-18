//
//  Security3DES.h
//  3DES
//
//  Created by 1  on 16-11-2.
//  Copyright (c) 2014年 zhaojinxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import "GTMBase64.h"

@interface Security3DES : NSObject
// 加密
+ (NSString *) encryptUse3DES_V3:(NSString *)plainText key:(NSString *)key ivKey:(unsigned char *)iv;
/// 解密
+ (NSString *)decryptUse3DES_V3:(NSString *)plainText key:(NSString *)key ivKey:(NSString *)ivKey;


@end
