#import "ASBusinessman.h"

@implementation ASBusinessman


-(id) init {
    
    self = [super init];
    if (self) {
        
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        
        // Tax Level
        [nc addObserver:self selector:@selector(taxLevelChangedNotification:)
                   name:ASGovermentTaxLevelDidChangeNotification
                 object:nil];
        
        
        [nc addObserver:self selector:@selector(businessCacheChangeNotification:)
                   name:ASGovermentBusinessCacheDidChangeNotification
                 object:nil];
        
        
        //Average Price
        [nc addObserver:self selector:@selector(averagePriceChangeNotification:)
                   name:ASGovermentAveragePriceDidChangeNotification
                 object:nil];
        
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
    
    NSLog(@"Бизнесмен заслужил свой отдых . Бизнесмен не заплатил налоги и плохо спит ! - Цсссс ");
}

-(void) willEnterForegroundNotification:(NSNotification*) notification {
    
    NSLog(@"Бизнесмен проснулся  ! - Всем привет ");
}



// Tax Level
-(void) taxLevelChangedNotification:(NSNotification*) notification {
    
    NSNumber *value = [notification.userInfo objectForKey:ASGovermentTaxLevelUserInfoKey];
    CGFloat   taxLevel = [value floatValue];
    
    
    if (taxLevel < self.taxLevel) {
        NSLog(@"-|TaxLevel|      Busines ARE happy. Было %f Стало - %f !!!!",self.taxLevel ,taxLevel);
    }
    else {
        NSLog(@"-|TaxLevel|      Busines NOT happy. Было %f Стало - %f !!!!",self.taxLevel ,taxLevel);
     }
    
    self.taxLevel = taxLevel;
}








// Average Price
-(void) averagePriceChangeNotification:(NSNotification*) notification {
    
    /*  NSNumber* value        = [notification.userInfo objectForKey:ASGovermentAveragePriceUserInfoKey];
    CGFloat   averagePrice = [value intValue];

    CGFloat flation;
    CGFloat deflation;
    
    if (self.averagePrice > averagePrice) {
        
    deflation = 100 - ((averagePrice*100)/self.averagePrice);
    NSLog(@"-|AveragePrice|  Бизнес счастлив! Было %f Стало - %f !!!! Дефляция = %f",self.averagePrice , averagePrice,deflation);
    }
    
    else if (self.averagePrice < averagePrice) {
        flation = ((averagePrice - self.averagePrice)*100) / averagePrice;
        NSLog(@"-|AveragePrice|  Бизнес Несчастлив! Было %f Стало - %f !!!! Инфляция = %f",self.averagePrice , averagePrice,flation);

    }
    
    self.averagePrice = averagePrice;*/
    
    NSNumber* value        = [notification.userInfo objectForKey:ASGovermentAveragePriceUserInfoKey];
    CGFloat   averagePrice = [value floatValue];
    
    
    if (self.averagePrice > averagePrice) {
        
        _deflation = 100 - ((averagePrice*100)/self.averagePrice);
        NSLog(@"-|Бизнесмен| Еху!!! Средняя цена понизилась ! Было %f Стало %f . Дефляция = %f ",
              self.averagePrice , averagePrice ,_deflation);
        
        NSLog(@"-|Бизнесмен| - Презедент , так держать ! Мой бизнес идет в гору !!!\n\n");
        
        self.averagePrice = averagePrice;
        // self.deflation    = _deflation;
        
        NSDictionary* dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    
                                    [NSNumber numberWithFloat:_businessCache],
                                    ASGovermentBusinessCacheUserInfoKey,
                                    
                                    [NSNumber numberWithFloat:_flation = 0.0],
                                    ASFlationUserInfoKey,
                                    
                                    [NSNumber numberWithFloat:_deflation],
                                    ASDeflationUserInfoKey,
                                    nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ASGovermentBusinessCacheDidChangeNotification
                                                            object:nil
                                                          userInfo:dictionary];
    }
    
    else if (self.averagePrice < averagePrice) {
        
        _flation = ((averagePrice - self.averagePrice)*100) / averagePrice;
        
        NSLog(@"-|Бизнесмен| Средняя цена повысилась ! Было %f Стало %f . Инфляция = %f ",
              self.averagePrice ,averagePrice , _flation);
        
        NSLog(@"-|Бизнесмен| - Мой бизнес загнется с такой инфляцией !!!!\n\n");
        self.averagePrice = averagePrice;
        //  self.flation = _flation;
        
        NSDictionary* dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    
                                    [NSNumber numberWithFloat:_businessCache],
                                     ASGovermentBusinessCacheUserInfoKey,
                                    
                                    [NSNumber numberWithFloat:_flation],
                                    ASFlationUserInfoKey,
                                    
                                    [NSNumber numberWithFloat:_deflation = 0.0],
                                    ASDeflationUserInfoKey,
                                    nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ASGovermentBusinessCacheDidChangeNotification
                                                            object:nil
                                                          userInfo:dictionary];
        
    }
    self.averagePrice = averagePrice;

}



-(void) businessCacheChangeNotification:(NSNotification*) notification {
    
    NSNumber* valueCache     = [notification.userInfo objectForKey: ASGovermentBusinessCacheUserInfoKey];
    NSNumber* valueFlation   = [notification.userInfo objectForKey: ASFlationUserInfoKey];
    NSNumber* valueDeflation = [notification.userInfo objectForKey: ASDeflationUserInfoKey];
    
    
    
    CGFloat cache     = [valueCache      floatValue];
    CGFloat flation   = [valueFlation    floatValue];
    CGFloat deflation = [valueDeflation  floatValue];
    
    
    if (flation != 0.0) {
        
        
        cache -= ((cache / 100)* flation);
        
        if (cache < self.businessCache)
        {
            NSLog(@"-|Сache| Прибыль Бизнесмена упала ! Было %f Стало %f . Инфляция %f", self.businessCache, cache,flation);
            NSLog(@"-|Бизнесмен| - В стране все плохо ! Бизнес сворачивается !!!!");
            NSLog(@"--------------------------------------\n\n\n");

            self.businessCache = cache;
        }
        
        flation = deflation = 0;
    }
    
    if (deflation != 0.0)
    {
        cache += ((cache/100)* deflation);
        NSLog(@"-|Сache| Прибыль у Бизнесмена возрасла! Было %f Стало %f . Дефляция %f", self.businessCache, cache,deflation);
        NSLog(@"-|Бизнесмен| - Бизнес идет в гору ! Все супер !!!!");
        NSLog(@"--------------------------------------\n\n\n");

        
        self.businessCache = cache;
        flation = deflation = 0;
    }
    
  
    
}


@end
