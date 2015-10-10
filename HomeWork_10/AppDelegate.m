#import "AppDelegate.h"
#import "ASGoverment.h"
#import "ASDoctor.h"
#import "ASPensioner.h"
#import "ASBusinessman.h"

#import "ASTestNotification.h"

@interface AppDelegate ()

@property (strong , nonatomic) ASGoverment* goverment;
@property (strong , nonatomic) ASDoctor*      doctor;
@property (strong , nonatomic) ASPensioner*   pensioner;
@property (strong , nonatomic) ASBusinessman* businessman;

@property (strong , nonatomic) ASTestNotification *testNotification;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(govermentNotification:)
                                                 name:ASGovermentTaxLevelDidChangeNotification
                                               object:nil];
    /*
    ASGoverment* goverment = [ASGoverment new];
    
    ASDoctor*      doctor      = [[ASDoctor alloc] init];
    ASPensioner*   pensioner   = [ASPensioner new];
    ASBusinessman* businessman = [ASBusinessman new];*/
    
    self.testNotification = [ASTestNotification new];
    
    self.goverment = [ASGoverment new];
    self.doctor    = [ASDoctor    new];
    self.pensioner = [ASPensioner new];
    self.businessman = [ASBusinessman new];
   
    
    self.doctor.salary          = self.goverment.salary;
    self.pensioner.pension      = self.goverment.pension;
    self.businessman.taxLevel   = self.goverment.businessCache;
    
    // Значение всех пенсий, кэшов, зарплат врачам, средние цены, инфляции/дефляции заданы в -(id) init класса ASGoverment
    // Все изменения рассчитываются через averagePrice , как оно поменялось , в большую сторону значит - инфляции , тогда
    //  все зарплаты урезаются с учетом инфляции
    
    // Если в меньшую тогда высчитывается дефляция и зарплаты , прибыли бизнеса увеличиваются с учетом дефляции.
    self.doctor.averagePrice = self.pensioner.averagePrice = self.businessman.averagePrice = self.goverment.averagePrice;
    
    NSLog(@"\n\nПовышаем AveragePrice ! \n\n\n");
    self.goverment.averagePrice = 15.f;
    
    NSLog(@"\n\nПонижаем AveragePrice ! \n\n\n");
    self.goverment.averagePrice = 8.f;
    
    NSLog(@"\n\nПовышаем AveragePrice ! \n\n\n");
   self.goverment.averagePrice = 25.f;
   
    return YES;
}

-(void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void) govermentNotification:(NSNotification*) notification {

    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"Original - applicationWillResignActive ");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
      NSLog(@"Original - applicationDidEnterBackground ");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
     NSLog(@"Original - applicationWillEnterForeground ");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   NSLog(@"Original - applicationDidBecomeActive ");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"Original - applicationWillTerminate ");

}

@end
