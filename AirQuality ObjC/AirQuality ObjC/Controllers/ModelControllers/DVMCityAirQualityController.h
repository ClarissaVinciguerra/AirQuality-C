//
//  DVMCityAirQualityController.h
//  AirQuality ObjC
//
//  Created by Clarissa Vinciguerra on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVMCityAirQuality.h"
#import "DVMWeather.h"
#import "DVMPollution.h"


NS_ASSUME_NONNULL_BEGIN

@interface DVMCityAirQualityController : NSObject

+ (void)fetchSupportedCountriesWithCompletion:(void(^)(NSArray<NSString *>* countriesArray, NSError *error))completion;

+ (void)fetchSupportedStatesInCountry:(NSString *)country completion:(void(^)(NSArray<NSString *>* statesArray, NSError *error))completion;

+ (void)fetchSupportedCitiesInState:(NSString *)state
                                country:(NSString *)country
                            completion:(void(^)(NSArray<NSString *>* citiesArray, NSError *error))completion;

+ (void)fetchDataForCity:(NSString *)city
                   state:(NSString *)state
                 country:(NSString *)country
              completion:(void(^)(DVMCityAirQuality *, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
