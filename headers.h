@interface SpringBoard : NSObject
+ (id)sharedApplication;
- (BOOL)canOpenURL:(id)url;
- (BOOL)openURL:(id)url;
- (void)applicationOpenURL:(id)url publicURLsOnly:(BOOL)only animating:(BOOL)animating;
@end

@interface GMOSearchApplication : UIResponder <UIApplicationDelegate>
- (id)mainViewController;
@end

@interface GMOMainViewController : NSObject
- (void)enterVoiceMode;
- (void)homeVoiceButtonPressed:(id)fp8;
@end

@interface GMORootViewController : NSObject
- (UINavigationController *)paneNavigationController;
@end

@interface GMOHomePageController : NSObject
- (UIButton *)voiceButton;
@end
