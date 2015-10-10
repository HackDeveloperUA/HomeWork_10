

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


// Name for - Notification
extern NSString* const ASGovermentTaxLevelDidChangeNotification;
extern NSString* const ASGovermentAveragePriceDidChangeNotification;
extern NSString* const ASGovermentBusinessCacheDidChangeNotification;
extern NSString* const ASGovermentSalaryDidChangeNotification;
extern NSString* const ASGovermentPensionDidChangeNotification;

extern NSString* const ASFlation;
extern NSString* const ASDeflation;


// Name for - UserInfo
extern NSString* const ASGovermentTaxLevelUserInfoKey;
extern NSString* const ASGovermentAveragePriceUserInfoKey;
extern NSString* const ASGovermentBusinessCacheUserInfoKey;
extern NSString* const ASGovermentSalaryUserInfoKey;
extern NSString* const ASGovermentPensionUserInfoKey;

extern NSString* const ASFlationUserInfoKey;
extern NSString* const ASDeflationUserInfoKey;


@interface ASGoverment : NSObject

@property (assign , nonatomic) CGFloat taxLevel;
@property (assign , nonatomic) CGFloat averagePrice;
@property (assign , nonatomic) CGFloat businessCache;
@property (assign , nonatomic) CGFloat salary;
@property (assign , nonatomic) CGFloat pension;

@property (assign , nonatomic) CGFloat flation;
@property (assign , nonatomic) CGFloat deflation;


@end
