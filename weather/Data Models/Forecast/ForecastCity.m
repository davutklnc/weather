//
//  ForecastCity.m
//
//  Created by davut kilinc on 05/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "ForecastCity.h"
#import "ForecastCoord.h"
#import "ForecastSys.h"


NSString *const kForecastCityId = @"id";
NSString *const kForecastCityCoord = @"coord";
NSString *const kForecastCityCountry = @"country";
NSString *const kForecastCityName = @"name";
NSString *const kForecastCityPopulation = @"population";
NSString *const kForecastCitySys = @"sys";


@interface ForecastCity ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ForecastCity

@synthesize cityIdentifier = _cityIdentifier;
@synthesize coord = _coord;
@synthesize country = _country;
@synthesize name = _name;
@synthesize population = _population;
@synthesize sys = _sys;


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
            self.cityIdentifier = [[self objectOrNilForKey:kForecastCityId fromDictionary:dict] doubleValue];
            self.coord = [ForecastCoord modelObjectWithDictionary:[dict objectForKey:kForecastCityCoord]];
            self.country = [self objectOrNilForKey:kForecastCityCountry fromDictionary:dict];
            self.name = [self objectOrNilForKey:kForecastCityName fromDictionary:dict];
            self.population = [[self objectOrNilForKey:kForecastCityPopulation fromDictionary:dict] doubleValue];
            self.sys = [ForecastSys modelObjectWithDictionary:[dict objectForKey:kForecastCitySys]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityIdentifier] forKey:kForecastCityId];
    [mutableDict setValue:[self.coord dictionaryRepresentation] forKey:kForecastCityCoord];
    [mutableDict setValue:self.country forKey:kForecastCityCountry];
    [mutableDict setValue:self.name forKey:kForecastCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.population] forKey:kForecastCityPopulation];
    [mutableDict setValue:[self.sys dictionaryRepresentation] forKey:kForecastCitySys];

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

    self.cityIdentifier = [aDecoder decodeDoubleForKey:kForecastCityId];
    self.coord = [aDecoder decodeObjectForKey:kForecastCityCoord];
    self.country = [aDecoder decodeObjectForKey:kForecastCityCountry];
    self.name = [aDecoder decodeObjectForKey:kForecastCityName];
    self.population = [aDecoder decodeDoubleForKey:kForecastCityPopulation];
    self.sys = [aDecoder decodeObjectForKey:kForecastCitySys];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_cityIdentifier forKey:kForecastCityId];
    [aCoder encodeObject:_coord forKey:kForecastCityCoord];
    [aCoder encodeObject:_country forKey:kForecastCityCountry];
    [aCoder encodeObject:_name forKey:kForecastCityName];
    [aCoder encodeDouble:_population forKey:kForecastCityPopulation];
    [aCoder encodeObject:_sys forKey:kForecastCitySys];
}

- (id)copyWithZone:(NSZone *)zone
{
    ForecastCity *copy = [[ForecastCity alloc] init];
    
    if (copy) {

        copy.cityIdentifier = self.cityIdentifier;
        copy.coord = [self.coord copyWithZone:zone];
        copy.country = [self.country copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.population = self.population;
        copy.sys = [self.sys copyWithZone:zone];
    }
    
    return copy;
}


@end
