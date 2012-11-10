@interface SBApplicationController
+ (id)sharedInstance;
- (id)applicationWithDisplayIdentifier:(NSString*)displayIdentifier;
@end

@interface SBUIController
+ (id)sharedInstance;
- (void)activateApplicationFromSwitcher:(id)app;
@end

@interface SpringBoard
+ (id)sharedApplication;
- (BOOL)canOpenURL:(id)url;
- (BOOL)openURL:(id)url;
@end

@interface GMOSearchApplication : NSObject
- (id)mainViewController;
@end

@interface GMOMainViewController : NSObject
- (void)startVoiceSearch;
- (void)enterVoiceMode;
@end