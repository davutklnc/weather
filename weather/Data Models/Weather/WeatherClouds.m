//
//  WeatherClouds.m
//
//  Created by davut kilinc on 06/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "WeatherClouds.h"


NSString *const kWeatherCloudsAll = @"all";


@interface WeatherClouds ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeatherClouds

@synthesize all = _all;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.all = [[self objectOrNilForKey:kWeatherCloudsAll fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.all] forKey:kWeatherCloudsAll];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.all = [aDecoder decodeDoubleForKey:kWeatherCloudsAll];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_all forKey:kWeatherCloudsAll];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeatherClouds *copy = [[WeatherClouds alloc] init];
    
    if (copy) {

        copy.all = self.all;
    }
    
    return copy;
}


@end
