
#import "ASTestNotification.h"
#import "AppDelegate.h"

@implementation ASTestNotification

-(id) init {
   self = [super init];
   if (self) {
       
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didFinishLaunchingNotification:)
                                                     name:UIApplicationDidFinishLaunchingNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didBecomeActiveNotification:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didEnterBackgroundNotification:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willEnterForegroundNotification:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willResignActiveNotification:)
                                                     name:UIApplicationWillResignActiveNotification                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willTerminateNotification:)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];
     }
    return self;
}

//////////////

-(void) didFinishLaunchingNotification:(NSNotification*) notification {
    
    NSLog(@" This Fake - didFinishLaunchingNotification");
}

-(void) didBecomeActiveNotification:(NSNotification*) notification {
    
    NSLog(@" This Fake - didBecomeActiveNotification");
}

-(void) didEnterBackgroundNotification:(NSNotification*) notification {
    
    NSLog(@" This Fake - didEnterBackgroundNotification");
}

-(void) willEnterForegroundNotification:(NSNotification*) notification {
    
    NSLog(@" This Fake - willEnterForegroundNotification");
}

-(void) willResignActiveNotification:(NSNotification*) notification {
    
    NSLog(@" This Fake - willResignActiveNotification");
}

-(void) willTerminateNotification:(NSNotification*) notification {
    
    NSLog(@" This Fake - willTerminateNotification");
}


@end
