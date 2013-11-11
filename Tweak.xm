#import "libactivator.h"
#import "headers.h"

static SpringBoard* springBoard = nil;

@interface LANowNow : NSObject<LAListener, UIAlertViewDelegate> {}
@end

@implementation LANowNow
- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {
	NSURL *googleApp = [NSURL URLWithString:@"googleapp://voice-search"];
	if([springBoard canOpenURL:googleApp]) {
	   if([springBoard respondsToSelector:@selector(openURL:)]) [springBoard openURL:googleApp];
	   else if([springBoard respondsToSelector:@selector(applicationOpenURL:)]) [springBoard applicationOpenURL:googleApp publicURLsOnly:NO animating:YES];
	} else {
	   UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Google Search" message:@"The Google Search app must be installed from the App Store to activate NowNow." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"App Store", nil];
	   [error show];
	   [error release];
	}
	[event setHandled:YES]; // To prevent the default OS implementation
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(buttonIndex == 1) {
	   NSURL *appStore = [NSURL URLWithString:@"http://phobos.apple.com/WebObjects/MZSearch.woa/wa/search?submit=seeAllLockups&media=software&entity=software&term=Google%20Search"];
	   if([springBoard respondsToSelector:@selector(openURL:)]) [springBoard openURL:appStore];
	   else if([springBoard respondsToSelector:@selector(applicationOpenURL:)]) [springBoard applicationOpenURL:appStore publicURLsOnly:NO animating:YES];
	}
}

+ (void)load {
	if([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.springboard"])
	  [[%c(LAActivator) sharedInstance] registerListener:[self new] forName:@"com.nickf.nownow"];
}
@end

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)fp8 {
	%orig;
	springBoard = self;
}
%end

%hook GMOSearchApplication
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	if([[url absoluteString] isEqualToString:@"googleapp://voice-search"]) {
	  if([self respondsToSelector:@selector(mainViewController)]) {
	    id mainViewController = [self mainViewController];
	    if([mainViewController respondsToSelector:@selector(enterVoiceMode)]) {
		[mainViewController enterVoiceMode];
	    } else if([mainViewController respondsToSelector:@selector(homeVoiceButtonPressed:)]) {
		[mainViewController homeVoiceButtonPressed:nil];
	    }
	  }
	  return YES;
	}
	return NO;
}
%end
