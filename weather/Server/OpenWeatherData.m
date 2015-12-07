//
//  OepnWeatherData.m
//  weather
//
//  Created by davut kilinc on 05/12/15.
//  Copyright © 2015 davut kilinc. All rights reserved.
//

#import "OpenWeatherData.h"
#import "OpenWeatherClient.h"
#import "DCParserConfiguration.h"
#import "DCKeyValueObjectMapping.h"
#import "DCArrayMapping.h"

#define OPENWEATHERID @"f60cb5def30d159b9ff6924e1bbd2037"

@implementation OpenWeatherData



+ (NSURLSessionDataTask *)getForecastDataWithLatitude:(double)lat
                                                andLongtitude:(double)longt
                                                   data:(void (^)(ForecastBaseClass *data, NSError *error))block {
    
    NSString * url = [NSString stringWithFormat:@"forecast?lat=%f&lon=%f&APPID=%@&units=metric",lat,longt,OPENWEATHERID];

    return [[OpenWeatherClient sharedClient] GET:url parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        DCParserConfiguration *config = [DCParserConfiguration configuration];
        DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[ForecastBaseClass class]
                                                                 andConfiguration:config];
        DCArrayMapping *arrayMapper = [DCArrayMapping mapperForClassElements:[ForecastList class]
                                                                forAttribute:@"list" onClass:[ForecastBaseClass class]];
        [config addArrayMapper:arrayMapper];
        
        ForecastBaseClass *casts = [parser parseDictionary:JSON];
        
        if (block) {
            block(casts, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

+ (NSURLSessionDataTask *)getcurrentWeatherDataWithLatitude:(double)lat
                                        andLongtitude:(double)longt
                                                 data:(void (^)(WeatherBaseClass *data, NSError *error))block {
    
    NSString * url = [NSString stringWithFormat:@"weather?lat=%f&lon=%f&APPID=%@&units=metric",lat,longt,OPENWEATHERID];
    
    return [[OpenWeatherClient sharedClient] GET:url parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        DCParserConfiguration *config = [DCParserConfiguration configuration];
        DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[WeatherBaseClass class]
                                                                 andConfiguration:config];
        
        WeatherBaseClass *casts = [parser parseDictionary:JSON];
        
        if (block) {
            block(casts, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

+ (NSURLSessionDataTask *)getForecastDataWithCity:(NSString *)city
                                                 data:(void (^)(ForecastBaseClass *data, NSError *error))block {
    
    NSString * url = [NSString stringWithFormat:@"forecast?id=%@&APPID=%@&units=metric",city,OPENWEATHERID];
    
    return [[OpenWeatherClient sharedClient] GET:url parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        DCParserConfiguration *config = [DCParserConfiguration configuration];
        DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[ForecastBaseClass class]
                                                                 andConfiguration:config];
        DCArrayMapping *arrayMapper = [DCArrayMapping mapperForClassElements:[ForecastList class]
                                                                forAttribute:@"list" onClass:[ForecastBaseClass class]];
        [config addArrayMapper:arrayMapper];
        
        ForecastBaseClass *casts = [parser parseDictionary:JSON];
        
        if (block) {
            block(casts, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

+ (NSURLSessionDataTask *)getcurrentWeatherDataWithCity:(NSString *)city
                                                       data:(void (^)(WeatherBaseClass *data, NSError *error))block {
    
    NSString * url = [NSString stringWithFormat:@"weather?id=%@&APPID=%@&units=metric",city,OPENWEATHERID];
    
    return [[OpenWeatherClient sharedClient] GET:url parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        DCParserConfiguration *config = [DCParserConfiguration configuration];
        DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:[WeatherBaseClass class]
                                                                 andConfiguration:config];
        
        WeatherBaseClass *casts = [parser parseDictionary:JSON];
        
        if (block) {
            block(casts, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}



+ (void)getAllCities:(void (^)(NSDictionary *cities, NSError *error))block
{
    // getting all city data from another block
    NSError *error;
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"citylist" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    if (jsonData == nil) {
        block(nil,error);
        // handle error ...
    }
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    if (jsonArray == nil) {
        // handle error ...
        block(nil,error);
    }
    NSMutableDictionary *allCitiesAndIds = [NSMutableDictionary new];

    for (NSDictionary *dict in jsonArray) {
        [allCitiesAndIds setValue:dict[@"_id"] forKey:dict[@"name"]];
    }

    block(allCitiesAndIds,nil);
}


@end
