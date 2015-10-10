//
//  ASPensioner.m
//  HomeWork_10
//
//  Created by MD on 16.02.15.
//  Copyright (c) 2015 hh. All rights reserved.
//

#import "ASPensioner.h"

@implementation ASPensioner


-(id) init {
    
    
    self = [super init];
    
    if (self ) {
        
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        
        [nc addObserver:self selector:@selector(pensionChangedNotification:)
                   name:ASGovermentPensionDidChangeNotification
                 object:nil];
        
        
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
    
    NSLog(@"Пенсиоер заслужил свой отдых . Пенсионер уже спит ! - Цсссс ");
    
}

-(void) willEnterForegroundNotification:(NSNotification*) notification {
    
    NSLog(@"Пенсиоер проснулся и в 7 утра уже метро ! - Всем привет ");
    
}



-(void) averagePriceChangeNotification:(NSNotification*) notification {
    
    /*
    NSNumber* value        = [notification.userInfo objectForKey:ASGovermentAveragePriceUserInfoKey];
    CGFloat   averagePrice = [value floatValue];
    
    CGFloat flation;
    CGFloat deflation;
    
    
    
    if (self.averagePrice > averagePrice) {
        
        deflation = 100 - ((averagePrice*100)/self.averagePrice);
        NSLog(@"-|AveragePrice|  Пенсионер счастлив! Было %f Стало - %f !!!! Дефляция = %f",self.averagePrice , averagePrice,deflation);
    
    }
    
    else if (self.averagePrice < averagePrice) {
        flation = ((averagePrice - self.averagePrice)*100) / averagePrice;
        NSLog(@"-|AveragePrice|  Пенсионер Несчастлив! Было %f Стало - %f !!!! Инфляция = %f",self.averagePrice , averagePrice,flation);
        
    }
    
    
    self.averagePrice = averagePrice;*/
    
    NSNumber* value        = [notification.userInfo objectForKey:ASGovermentAveragePriceUserInfoKey];
    CGFloat   averagePrice = [value floatValue];
    
    
    if (self.averagePrice > averagePrice) {
        
        _deflation = 100 - ((averagePrice*100)/self.averagePrice);
        NSLog(@"-|AveragePrice| Средняя цена понизилась ! Было %f Стало %f . Дефляция = %f ",
              self.averagePrice , averagePrice ,_deflation);
        
        NSLog(@"-|Пенсионер| Наконец-то поживем на старости лет !!! \n\n");
        self.averagePrice = averagePrice;
        // self.deflation    = _deflation;
        
        NSDictionary* dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    
                                    [NSNumber numberWithFloat:_pension],
                                    ASGovermentPensionUserInfoKey,
                                    
                                    [NSNumber numberWithFloat:_flation = 0.0],
                                    ASFlationUserInfoKey,
                                    
                                    [NSNumber numberWithFloat:_deflation],
                                    ASDeflationUserInfoKey,
                                    nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ASGovermentPensionDidChangeNotification
                                                            object:nil
                                                          userInfo:dictionary];
    }
    
    else if (self.averagePrice < averagePrice) {
        
        _flation = ((averagePrice - self.averagePrice)*100) / averagePrice;
        
        NSLog(@"-|AveragePrice| Средняя цена повысилась ! Было %f Стало %f . Инфляция = %f ",
              self.averagePrice ,averagePrice , _flation);
        
        NSLog(@"-|Пенсионер| Да что же это делается ??! Жить спокойно не дают !!! \n\n");

        self.averagePrice = averagePrice;
        //  self.flation = _flation;
        
        NSDictionary* dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    
                                    [NSNumber numberWithFloat:_pension],
                                    ASGovermentPensionUserInfoKey,
                                    
                                    [NSNumber numberWithFloat:_flation],
                                    ASFlationUserInfoKey,
                                    
                                    [NSNumber numberWithFloat:_deflation = 0.0],
                                    ASDeflationUserInfoKey,
                                    nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ASGovermentPensionDidChangeNotification
                                                            object:nil
                                                          userInfo:dictionary];
        
    }
    self.averagePrice = averagePrice;
}

-(void) pensionChangedNotification: (NSNotification*) notification {
    /*
     NSNumber* value   = [notification.userInfo objectForKey:ASGovermentPensionUserInfoKey];
     CGFloat   pension = [value floatValue];
     
     if (pension < self.pension) {
     NSLog(@"-|Pension|  Pensioners NOT happy. Было %f Стало - %f !!!!",self.pension , pension);
     }
     else {
     
     NSLog(@"-|Pension| Pensioners ARE happy. Было %f Стало - %f !!!!",self.pension , pension);
     
     }
     
     self.pension = pension;*/
    
    NSNumber* valuePension   = [notification.userInfo objectForKey: ASGovermentPensionUserInfoKey];
    NSNumber* valueFlation   = [notification.userInfo objectForKey: ASFlationUserInfoKey];
    NSNumber* valueDeflation = [notification.userInfo objectForKey: ASDeflationUserInfoKey];
    
    
    
    CGFloat pension   = [valuePension    floatValue];
    CGFloat flation   = [valueFlation    floatValue];
    CGFloat deflation = [valueDeflation  floatValue];
    
    
    if (flation != 0.0) {
        
        
        pension -= ((pension / 100)* flation);
        
        if (pension < self.pension)
        {
            NSLog(@"-|Salary| Пенсия у Пенсионера упала ! Было %f Стало %f . Инфляция %f", self.pension, pension,flation);
            NSLog(@"-|Пенсионер| Сталина на этих ворюг нету !!!!");
            NSLog(@"--------------------------------------\n\n\n");

            self.pension = pension;
        }
        
        flation = deflation = 0;
    }
    
    if (deflation != 0.0)
    {
        pension += ((pension/100)* deflation);
        NSLog(@"-|Salary| Пенсия у Песнионера возрасла! Было %f Стало %f . Дефляция %f", self.pension, pension,deflation);
        NSLog(@"-|Пенсионер| Наконец-то про народ стали думать !!!!!");
        NSLog(@"--------------------------------------\n\n\n");


        self.pension = pension;
        flation = deflation = 0;
    }
    
    
}








@end
