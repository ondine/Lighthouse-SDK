//
//  MAPSDK.h
//
//  Copyright (c) 2014 Mocana Corp. All rights reserved.
//  Build: 3.2.0.developer-build
//  Generated on Wed, Sep 17 14:22:39 PDT 2014
//

#import <Security/Security.h>

#ifdef __cplusplus
extern "C" {
#endif

void MAP_initCertificateForDebug(NSString *p12Name, NSString *p12Extension, NSString *p12Password);
void MAP_initUserForDebug(NSString *username);

BOOL MAP_hasUserIdentityCertificate();
SecIdentityRef MAP_getUserIdentityCertificate();
NSString *MAP_getUsername();

#ifdef __cplusplus
}
#endif
