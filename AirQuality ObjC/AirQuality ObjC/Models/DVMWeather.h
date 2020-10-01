//
//  DVMWeather.h
//  AirQuality ObjC
//
//  Created by Clarissa Vinciguerra on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMWeather : NSObject

@property (nonatomic, copy, readonly) NSString *timestamp;
@property (nonatomic, readonly) NSInteger temperature;
@property (nonatomic, readonly) NSInteger atmosphericPressure;
@property (nonatomic, readonly) NSInteger humidity;
@property (nonatomic, readonly) NSInteger windSpeed;
@property (nonatomic, readonly) NSInteger windDirection;

- (instancetype) initWithTimestamp:(NSString *)timestamp
                       temperature:(NSInteger)temperature
               atmosphericPressure:(NSInteger)atmosphericPressure
                          humidity:(NSInteger)humidity
                         windSpeed:(NSInteger)windSpeed
                     windDirection:(NSInteger)windDirection;
@end

@interface DVMWeather (JSONConvertable)

//convenience initializer
-(instancetype) initWithWeatherDictionary:(NSDictionary <NSString *, id>*)weatherDictionary;

@end

NS_ASSUME_NONNULL_END
