@interface SpringBoard : NSObject
+ (id)sharedApplication;
- (BOOL)canOpenURL:(id)url;
- (BOOL)openURL:(id)url;
- (void)applicationOpenURL:(id)url publicURLsOnly:(BOOL)only animating:(BOOL)animating;
@end

@interface GMOSearchApplication : NSObject
- (id)mainViewController;
@end

@interface GMOMainViewController : NSObject
- (void)enterVoiceMode;
- (void)homeVoiceButtonPressed:(id)fp8;
@end
