//
//  DVMPollution.m
//  AirQuality ObjC
//
//  Created by Clarissa Vinciguerra on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "DVMPollution.h"

@implementation DVMPollution

- (instancetype)initWithAirQualityIndex:(NSInteger)airQualityIndex
{
    if (self = [super init])
    {
        _airQualityIndex;
    }
    return self;
}
@end

@implementation DVMPollution (JSONConvertable)

- (instancetype)initWithPollutionDictionary:(NSDictionary *)pollutionDictionary
{
    NSInteger airQualityIndex = [pollutionDictionary[@"aqius"]integerValue];
    
    return [self initWithAirQualityIndex:airQualityIndex];
}

@end
