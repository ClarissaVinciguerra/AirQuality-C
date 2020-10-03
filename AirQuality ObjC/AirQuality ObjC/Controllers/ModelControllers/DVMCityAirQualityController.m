//
//  DVMCityAirQualityController.m
//  AirQuality ObjC
//
//  Created by Clarissa Vinciguerra on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "DVMCityAirQualityController.h"

static NSString * const baseURLString = @"https://api.airvisual.com/";
static NSString * const versionComponent = @"v2";
static NSString * const countryComponent = @"countries";
static NSString * const stateComponent = @"states";
static NSString * const cityComponent = @"cities";
static NSString * const cityDetailsComponent = @"city";
static NSString * const apiKey = @"27aec701-5d3f-4dd9-b317-f0b5c03da60e";

@implementation DVMCityAirQualityController
  
+ (void)fetchSupportedCountriesWithCompletion:(void (^)(NSArray<NSString *> * , NSError *))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *countryURL = [versionURL URLByAppendingPathComponent:countryComponent];
    
    // Adding Query Items 1. create a mutable array that holds objects of type NSURLQueryItem. The NEW is a combination of alloc and init.
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    // Query items go here! Allocate memory and initialize with key and value
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    // Add the the object to the array queryItems here
    [queryItems addObject:apiKeyQuery];
    
    // Allocate memory for NSURLComponents and initialize with the countryURL
    NSURLComponents *urlComponents = [[NSURLComponents alloc]initWithURL:countryURL resolvingAgainstBaseURL:true];
    // set query items to URLComponents (which previously let us add this to country URL)
    [urlComponents setQueryItems:queryItems];
    // final URL with query items
    NSURL *finalURL = [urlComponents URL];
    NSLog(@"Final country URL: %@", finalURL);
    
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error)
        {
            NSLog(@"There was an error: %@, %@", error, error.localizedDescription);
            return completion(nil, error);
        }
        
        if (!data)
        {
            NSLog(@"There appears to be no data.");
            return completion(nil, error);
        }
            
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (!topLevelDictionary)
        {
            NSLog(@"Error parsing JSON: %@", error);
            return completion(nil, error);
        }
        
        NSDictionary *dataDictionary = topLevelDictionary[@"data"];
        //create a mutable array for all countries in the data dictionary
        NSMutableArray *countriesArray = [NSMutableArray new];
        for (NSDictionary *countryDictionary in dataDictionary)
        {
            NSString *country = [[NSString alloc] initWithString:countryDictionary[@"country"]];
            [countriesArray addObject:country];
        }
        completion (countriesArray,error);
    }]resume];
}

+ (void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> *, NSError *))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *statesURL = [versionURL URLByAppendingPathComponent:stateComponent];
  
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    // Queries: apiKey and country
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc]initWithURL:statesURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    NSLog(@"StatesURL: %@", finalURL);
    
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error)
        {
            NSLog(@"There was an error: %@, %@", error, error.localizedDescription);
            return completion(nil, error);
        }
        
        if (!data)
        {
            NSLog(@"There appears to be no data.");
            return completion(nil, error);
        }

        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:&error];
        if (!topLevelDictionary)
        {
            NSLog(@"There was an error parsing JSON %@", error);
            return completion (nil, error);
        }
        NSDictionary *dataDictionary = topLevelDictionary[@"data"];
        NSMutableArray *statesArray = [NSMutableArray new];
        for (NSDictionary *statesDictionary in dataDictionary)
        {
            NSString *state = [[NSString alloc] initWithString:statesDictionary[@"state"]];
            [statesArray addObject:state];
        }
        completion(statesArray, error);
    }] resume];
}

+ (void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> *, NSError *))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *citiesURL = [versionURL URLByAppendingPathComponent:cityComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:countryQuery];
    [queryItems addObject:stateQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc]initWithURL:citiesURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    NSLog(@"FINAL URL FOR STATES ARRAY: %@", finalURL);
    
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an error: %@, %@", error, error.localizedDescription);
            return completion(nil, error);
        }
        
        if (!data)
        {
            NSLog(@"There appears to be no data.");
            return completion(nil, error);
        }
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options: 2 error:&error];
        NSDictionary *dataDictionary = topLevelDictionary[@"data"];
        NSMutableArray *citiesArray = [NSMutableArray new];
        for (NSDictionary *cityDictionary in dataDictionary)
        {
            NSString *city = [[NSString alloc] initWithString:cityDictionary[@"city"]];
            [citiesArray addObject:city];
        }
        completion (citiesArray, error);
    }] resume];
}

+ (void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(DVMCityAirQuality *, NSError *))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *cityDetailURL = [versionURL URLByAppendingPathComponent:cityDetailsComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *cityQuery = [[NSURLQueryItem alloc] initWithName:@"city" value:city];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:countryQuery];
    [queryItems addObject:stateQuery];
    [queryItems addObject:cityQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc]initWithURL:cityDetailURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    NSLog(@"FinalURL for CityDetails: %@", finalURL);
    
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error)
                {
                    NSLog(@"There was an error: %@, %@", error, error.localizedDescription);
                    return completion(nil, error);
                }
                
                if (!data)
                {
                    NSLog(@"There appears to be no data.");
                    return completion(nil, error);
                }
        
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options: 2 error:&error];
        NSDictionary *dataDictionary = topLevelDictionary[@"data"];
        DVMCityAirQuality *cityAirQualityObject = [[DVMCityAirQuality alloc] initWithLocationDictionary:dataDictionary];
        
        return completion (cityAirQualityObject, error);
    }] resume];
}
@end
