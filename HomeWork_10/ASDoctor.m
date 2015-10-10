#import "ASDoctor.h"
#import "ASGoverment.h"

@implementation ASDoctor


-(id) init {

    self = [super init];
    if (self) {
        
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        
        // подписываемя на зарплату бюджетникам
        [nc addObserver:self selector:@selector(salaryChangedNotification:)
                   name:ASGovermentSalaryDidChangeNotification
                 object:nil];
        
        // подписываемя на среднею стоимость
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

-(void) didEnterBackgroundNotification:(NSNotification*) notification {
    
    NSLog(@"Доктор заслужил свой отдых . Доктор Спит ! - Цсссс ");
    
}

-(void) willEnterForegroundNotification:(NSNotification*) notification {
    
    NSLog(@"Доктор отдохнул ! Доктор проснулся ! - Всем привет ");
    
}




-(void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) averagePriceChangeNotification:(NSNotification*) notification {
    
    NSNumber* value        = [notification.userInfo objectForKey:ASGovermentAveragePriceUserInfoKey];
    CGFloat   averagePrice = [value floatValue];

    // Если новая средняя цена  меньше чем предыдущая , то это - дефляция
    // Тогда высчитываем дефляцию и отправляем нотификацию ASGovermentSalaryDidChangeNotification
    
    if (self.averagePrice > averagePrice) {
        
        _deflation = 100 - ((averagePrice*100)/self.averagePrice);
        NSLog(@"-|Доктор| Ура ??! Средняя цена понизилась ! Было %f Стало %f . Дефляция = %f ",
              self.averagePrice , averagePrice ,_deflation);
        
        NSLog(@"-|Доктор| - Так держать ! Я смогу купить больше !!!\n\n");

        self.averagePrice = averagePrice;
        
        NSDictionary* dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    
                                    [NSNumber numberWithFloat:_salary],
                                    ASGovermentSalaryUserInfoKey,
                                    
                                    [NSNumber numberWithFloat:_flation = 0.0],
                                    ASFlationUserInfoKey,
                                    
                                    [NSNumber numberWithFloat:_deflation],
                                    ASDeflationUserInfoKey,
                                    nil];
        
   [[NSNotificationCenter defaultCenter] postNotificationName:ASGovermentSalaryDidChangeNotification
                                                            object:nil
                                                          userInfo:dictionary];
     }
    
    // Если новая средняя цена  больше чем предыдущая , то это - инфляция
    // Тогда высчитываем инфляцию и отправляем нотификацию ASGovermentSalaryDidChangeNotification
    
    
    else if (self.averagePrice < averagePrice) {
        
          _flation = ((averagePrice - self.averagePrice)*100) / averagePrice;
        
           NSLog(@"-|Доктор| Средняя цена повысилась ! Было %f Стало %f . Инфляция = %f ",
                 self.averagePrice ,averagePrice , _flation);
     
        NSLog(@"-|Доктор| - Сейчас мы Вам тут устроим переворот за такую инфляцию !!!!\n\n");
        self.averagePrice = averagePrice;
     
        NSDictionary* dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    
                                    [NSNumber numberWithFloat:_salary],
                                    ASGovermentSalaryUserInfoKey,
                                    
                                    [NSNumber numberWithFloat:_flation],
                                    ASFlationUserInfoKey,
                                    
                                    [NSNumber numberWithFloat:_deflation = 0.0],
                                    ASDeflationUserInfoKey,
                                    nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ASGovermentSalaryDidChangeNotification
                                                            object:nil
                                                          userInfo:dictionary];
    }
    self.averagePrice = averagePrice;
}



-(void) salaryChangedNotification:(NSNotification*) notification {
    
    NSNumber* valueSalary    = [notification.userInfo objectForKey: ASGovermentSalaryUserInfoKey];
    NSNumber* valueFlation   = [notification.userInfo objectForKey: ASFlationUserInfoKey];
    NSNumber* valueDeflation = [notification.userInfo objectForKey: ASDeflationUserInfoKey];
    
    CGFloat salary    = [valueSalary     floatValue];
    CGFloat flation   = [valueFlation    floatValue];
    CGFloat deflation = [valueDeflation  floatValue];
    // Если инфляция не равна нулю , тогда высчитываем ее
    if (flation != 0.0)
    {
        salary -= ((salary / 100)* flation);
        
        if (salary < self.salary)
        {
        NSLog(@"-|Salary| Зарплата у Доктора упала ! Было %f Стало %f . Инфляция %f", self.salary, salary,flation);
        NSLog(@"-|Доктор| - Сейчас мы вам устроим , сволочи !!!!!");
        NSLog(@"--------------------------------------\n\n\n");
        self.salary = salary;
        }
        flation = deflation = 0;
    }
    // Если дефляция не равна нулю , тогда высчитываем ее
    if (deflation != 0.0)
    {
        salary += ((salary/100)* deflation);
    NSLog(@"-|Salary| Зарплата у Доктора возрасла! Было %f Стало %f . Дефляция %f", self.salary, salary,deflation);
    NSLog(@"-|Доктор| - Слава презеденту ! Наконец-то бюджетникам зарпалты повысили !!!!!!");
    NSLog(@"--------------------------------------\n\n\n");

    self.salary = salary;
    flation = deflation = 0;
    }
}




@end
