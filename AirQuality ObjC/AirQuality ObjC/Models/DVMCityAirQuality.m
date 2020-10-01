//
//  DVMCityAirQuality.m
//  AirQuality ObjC
//
//  Created by Clarissa Vinciguerra on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "DVMCityAirQuality.h"

@implementation DVMCityAirQuality

- (instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(DVMWeather *)weather pollution:(DVMPollution *)pollution
{
    if (self = [super init])
    {
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;
    }
    return self;
}
@end

@implementation DVMCityAirQuality (JSONConvertable)
- (instancetype)initWithLocationDictionary:(NSDictionary<NSString *,id> *)locationDictionary
{
    NSString *city = locationDictionary[@"city"];
    NSString *state = locationDictionary[@"state"];
    NSString *country = locationDictionary[@"country"];
    
    NSDictionary *currentDictionary = locationDictionary[@"current"];
    DVMWeather *weather = [[DVMWeather alloc] initWithWeatherDictionary:currentDictionary[@"weather"]];
    DVMPollution *pollution = [[DVMPollution alloc] initWithPollutionDictionary:currentDictionary[@"pollution"]];
    
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
}
@end
