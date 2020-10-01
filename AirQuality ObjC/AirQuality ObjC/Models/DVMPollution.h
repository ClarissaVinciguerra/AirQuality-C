//
//  DVMPollution.h
//  AirQuality ObjC
//
//  Created by Clarissa Vinciguerra on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMPollution : NSObject

@property (nonatomic, readonly) NSInteger airQualityIndex;

-(instancetype) initWithAirQualityIndex: (NSInteger)airQualityIndex;
@end

@interface DVMPollution (JSONConvertable)

-(instancetype)initWithPollutionDictionary: (NSDictionary *)pollutionDictionary;

@end

NS_ASSUME_NONNULL_END
