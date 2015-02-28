//
//  MAPSDK.m
//
//  Copyright (c) 2014 Mocana Corp. All rights reserved.
//  Build: 3.2.0.developer-build
//  Generated on Wed, Sep 17 14:22:39 PDT 2014
//

#import "MAPSDK.h"
#import <Foundation/NSDictionary.h>

#import "MAPSDK.h"

#ifdef DEBUG
//
//When debugging, the following values can be changed by calling the proper 
//setup functions (available only when compiling with the DEBUG flag
//The following values provide a default that will not work out of the box
//

static NSString * sCertificateFileName      = nil;
static NSString * sCertificateFileExtension = nil;
static NSString * sCertificatePassword      = nil;
static NSString * sUsername                 = nil;

#endif


@interface MAPSDK_CertificateProvider : NSObject

+(void) initCertificateForDebug:(NSString *)filename extension:(NSString *)ext password:(NSString *) pwd;
+(void) initUserForDebug: (NSString *)username;

+(BOOL) hasUserIdentityCertificate;
+(SecIdentityRef) getUserIdentityCertificate;
+(NSString *) getUsername;
@end

@implementation MAPSDK_CertificateProvider

+(void) initCertificateForDebug: (NSString *)filename extension: (NSString *)ext password:  (NSString *)pwd
{
#ifdef DEBUG
    sCertificateFileName = filename;
    sCertificateFileExtension =ext;
    sCertificatePassword = pwd;
#endif
}

+(void) initUserForDebug: (NSString *) username
{
#ifdef DEBUG
    sUsername = username;
#endif
}

+(BOOL) hasUserIdentityCertificate
{
#ifdef DEBUG
    NSLog(@"MAPSDK_CertificateProvider:hasUserIdentityCertificate");
    NSString *path = [[NSBundle mainBundle] pathForResource:sCertificateFileName ofType:sCertificateFileExtension];
    return (path != nil);
#else
    return FALSE;
#endif
}

+(SecIdentityRef) getUserIdentityCertificate
{
#ifdef DEBUG
    NSLog(@"MAPSDK_CertificateProvider:getUserIdentityCertificate");
    NSString *path = [[NSBundle mainBundle] pathForResource:sCertificateFileName ofType:sCertificateFileExtension];
    if (path != nil)
    {
        NSData *p12data = [NSData dataWithContentsOfFile:path];
        if (p12data != nil)
        {
            CFDataRef inP12data = (__bridge CFDataRef)p12data;
            CFStringRef password = (__bridge CFStringRef)sCertificatePassword;
            const void *keys[] = { kSecImportExportPassphrase };
            const void *values[] = { password };
            
            CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
            
            CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
            OSStatus securityError = SecPKCS12Import(inP12data, options, &items);
            if (securityError == 0 && CFArrayGetCount(items) > 0) {
                CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex(items, 0);
                SecIdentityRef identity = (SecIdentityRef)CFDictionaryGetValue(myIdentityAndTrust, kSecImportItemIdentity);
                return identity;
            }
            
            if (options) {
                CFRelease(options);
            }
        }
    }
#endif
    return NULL;
}


+(NSString *) getUsername
{
#ifdef DEBUG
    return sUsername;
#else
    return NULL;
#endif
}

@end


void MAP_initCertificateForDebug(
     NSString *p12Name,
     NSString *p12Extension,
     NSString *p12Password)
{
    [MAPSDK_CertificateProvider initCertificateForDebug:p12Name extension:p12Extension password:p12Password];
}

void MAP_initUserForDebug(NSString *username)
{
    [MAPSDK_CertificateProvider initUserForDebug: username];
}

BOOL MAP_hasUserIdentityCertificate()
{
    NSLog(@"MAP_hasUserIdentityCertificate");
    return [ MAPSDK_CertificateProvider hasUserIdentityCertificate];
}

SecIdentityRef MAP_getUserIdentityCertificate()
{
    NSLog(@"MAP_getUserIdentityCertificate");
    return [MAPSDK_CertificateProvider getUserIdentityCertificate];
}

NSString *MAP_getUsername()
{
    NSLog(@"MAP_getUsername");
    return [MAPSDK_CertificateProvider getUsername];
}
