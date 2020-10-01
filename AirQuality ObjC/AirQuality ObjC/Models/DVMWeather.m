//
//  DVMWeather.m
//  AirQuality ObjC
//
//  Created by Clarissa Vinciguerra on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "DVMWeather.h"

@implementation DVMWeather

- (instancetype)initWithTimestamp:(NSString *)timestamp temperature:(NSInteger)temperature atmosphericPressure:(NSInteger)atmosphericPressure humidity:(NSInteger)humidity windSpeed:(NSInteger)windSpeed windDirection:(NSInteger)windDirection
{
    if (self = [super init])
    {
        _timestamp = timestamp;
        _temperature = temperature;
        _atmosphericPressure = atmosphericPressure;
        _humidity = humidity;
        _windSpeed = windSpeed;
        _windDirection = windDirection;
    }
    return self;
}
@end

@implementation DVMWeather (JSONConvertable)
- (instancetype)initWithWeatherDictionary:(NSDictionary<NSString *,id> *)weatherDictionary
{
    NSString *timestamp = weatherDictionary[@"ts"];
    NSInteger temperature = [weatherDictionary[@"tp"]integerValue];
    NSInteger atmosphericPressure = [weatherDictionary[@"pr"]integerValue];
    NSInteger humidity = [weatherDictionary[@"hu"]integerValue];
    NSInteger windSpeed = [weatherDictionary[@"ws"]integerValue];
    NSInteger windDirection = [weatherDictionary[@"wd"]integerValue];
    
    return [self initWithTimestamp:timestamp temperature:temperature atmosphericPressure:atmosphericPressure humidity:humidity windSpeed:windSpeed windDirection:windDirection];
}
@end
