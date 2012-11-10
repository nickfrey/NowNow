#import "libactivator.h"
#import "headers.h"

@interface LANowNow : NSObject<LAListener, UIAlertViewDelegate> {}
@end

@implementation LANowNow
- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {
	NSURL *googleApp = [objc_getClass("NSURL") URLWithString:@"googleapp://voice-search"];
	if([[objc_getClass("SpringBoard") sharedApplication] canOpenURL:googleApp]) {
	   [[objc_getClass("SpringBoard") sharedApplication] openURL:googleApp];
	} else {
	   UIAlertView *error = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"Google Search" message:@"The Google Search app must be installed from the App Store to activate NowNow." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"App Store", nil];
	   [error show];
	   [error release];
	}
	[event setHandled:YES]; // To prevent the default OS implementation
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(buttonIndex == 1) [[objc_getClass("SpringBoard") sharedApplication] openURL:[objc_getClass("NSURL") URLWithString:@"http://phobos.apple.com/WebObjects/MZSearch.woa/wa/search?submit=seeAllLockups&media=software&entity=software&term=Google%20Search"]];
}

+ (void)load {
	if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.springboard"])
	  [[objc_getClass("LAActivator") sharedInstance] registerListener:[self new] forName:@"com.nickf.nownow"];
}
@end

%hook GMOSearchApplication
%new
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	if([[url absoluteString] isEqualToString:@"googleapp://voice-search"]) {
	  if([self respondsToSelector:@selector(mainViewController)]) {
	    id mainViewController = [self mainViewController];
	    if([mainViewController respondsToSelector:@selector(enterVoiceMode)]) {
		[mainViewController enterVoiceMode];
	    	return YES;
	    }
	  }
	}
	return NO;
}
%end
