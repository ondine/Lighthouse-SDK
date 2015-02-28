//
//  MAPSDK.h
//
//  Copyright (c) 2014 Mocana Corp. All rights reserved.
//  Build: 3.3.3.8787
//  Generated on Fri, Feb 27 12:16:49 PST 2015
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
