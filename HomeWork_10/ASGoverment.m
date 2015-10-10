#import "ASGoverment.h"
@implementation ASGoverment

 NSString* const ASGovermentTaxLevelDidChangeNotification = @"ASGovermentTaxLevelDidChangeNotification";
 NSString* const ASGovermentBusinessCacheDidChangeNotification =@"ASGovermentBusinessCacheDidChangeNotification";
 NSString* const ASGovermentSalaryDidChangeNotification   = @"ASGovermentSalaryDidChangeNotification";
 NSString* const ASGovermentPensionDidChangeNotification  = @"ASGovermentPensionDidChangeNotification";
 NSString* const ASGovermentAveragePriceDidChangeNotification = @"ASGovermentAveragePriceDidChangeNotification";

 NSString* const ASFlation   = @"ASFlation";
 NSString* const ASDeflation = @"ASDeflation";

 NSString* const ASGovermentTaxLevelUserInfoKey      = @"ASGovermentTaxLevelUserInfoKey";
 NSString* const ASGovermentBusinessCacheUserInfoKey = @"ASGovermentBusinessCacheUserInfoKey";
 NSString* const ASGovermentSalaryUserInfoKey        = @"ASGovermentSalaryUserInfoKey";
 NSString* const ASGovermentPensionUserInfoKey       = @"ASGovermentPensionUserInfoKey";
 NSString* const ASGovermentAveragePriceUserInfoKey  = @"ASGovermentAveragePriceUserInfoKey";

 NSString* const ASFlationUserInfoKey   = @"ASFlationUserInfoKey";
 NSString* const ASDeflationUserInfoKey = @"ASDeflationUserInfoKey";

-(id) init {
    
    self =  [super init];
    if (self) {
        
        _taxLevel = 5.f;
        _businessCache = 300;
        _pension  = 500;

        _salary   = 100;
        _averagePrice = 10.f;
        
        _flation   = 0.f;
        _deflation = 0.f;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didEnterBackgroundNotification:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willEnterForegroundNotification:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        
        
    }
    return self;
}

-(void) dealloc {
  
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


-(void) didEnterBackgroundNotification:(NSNotification*) notification {
    
    NSLog(@" Правительство СПИТ !");
}

-(void) willEnterForegroundNotification: (NSNotification*) notification {
    
    NSLog(@" Правительство проснулось  !");

}



-(void) setTaxLevel:(CGFloat)taxLevel {
    
    
    _taxLevel = taxLevel;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:taxLevel] forKey:ASGovermentTaxLevelUserInfoKey];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ASGovermentTaxLevelDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
    
}



-(void) setBusinessCache:(CGFloat)businessCache {
    
    _businessCache = businessCache;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:businessCache] forKey:ASGovermentBusinessCacheUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ASGovermentBusinessCacheDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
}

-(void) setSalary:(CGFloat)salary {
    
    _salary = salary;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:salary] forKey:ASGovermentSalaryUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ASGovermentSalaryDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
}

-(void)  setPension:(CGFloat)pension {
    
    _pension = pension;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:pension] forKey:ASGovermentPensionUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ASGovermentPensionDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
}

-(void) setAveragePrice:(CGFloat)averagePrice {
    
    
    _averagePrice = averagePrice;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:averagePrice] forKey:ASGovermentAveragePriceUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ASGovermentAveragePriceDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
}



@end
