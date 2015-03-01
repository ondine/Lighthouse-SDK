# Lighthouse-SDK
The Mocana Atlas Lighthouse Software Development Kit (SDK) here on in referred to as ‘the SDK’ provides a simple way for developers to add certificate based 2-factor authentication for iOS and Android apps.  The benefit of this to the user is that it presents a single login screen that consolidates VPN login, device management login and the app login. 

In addition to the simple and transparently secure login experience, the SDK also enables always connected user experience even if the device moves from cellular to WiFi or the app is back grounded. While the app to the backend connection can be torn down, the app seamlessly reconnects using a secure re-connection token allowing the user to live a login-free app experience. 

By virtue of incorporating the SDK, analytics about the user, app, device and network are automatically captured and piped to log visualization platforms such as Splunk, ArcSight, etc. This capability is delivered without incorporating expensive enterprise grade analytics SDK or relying on insecure consumer grade analytics SDK. 

This capability is invoked as part of the build process in Xcode for iOS and in any Android development Integrated Development Environment (IDE) such as Eclipse, IntelliJ, etc., 

Features of the SDK 

-	A simple way to add X.509 certificate based 2 factor authentication 
-	Consolidation of multiple login screens into one ‘in-app’ login 
-	Allows any iOS and Android app to use Atlas authentication as the primary app login
-	Always connected user experience for end user 
-	App Usage Analytics without an analytics SDK 
-	Uniform model for both iOS and Android apps  
-	Functionality is part of the development process in the IDE of choice for the developer 
-	Integrated debug capability to test code paths 
-	Supports iOS 7 and above 
-	Supports Android 4.0 and above 
-	Supported Development Environments for iOS app development 
o	Xcode version 6 
o	OS X 10.9.4 
-	Revision controlled code base hosted at https://github.com/MocanaDevNetwork
