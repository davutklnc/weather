//
//  WeatherWind.m
//
//  Created by davut kilinc on 06/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "WeatherWind.h"


NSString *const kWeatherWindSpeed = @"speed";
NSString *const kWeatherWindDeg = @"deg";


@interface WeatherWind ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeatherWind

@synthesize speed = _speed;
@synthesize deg = _deg;


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
            self.speed = [[self objectOrNilForKey:kWeatherWindSpeed fromDictionary:dict] doubleValue];
            self.deg = [[self objectOrNilForKey:kWeatherWindDeg fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.speed] forKey:kWeatherWindSpeed];
    [mutableDict setValue:[NSNumber numberWithDouble:self.deg] forKey:kWeatherWindDeg];

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

    self.speed = [aDecoder decodeDoubleForKey:kWeatherWindSpeed];
    self.deg = [aDecoder decodeDoubleForKey:kWeatherWindDeg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_speed forKey:kWeatherWindSpeed];
    [aCoder encodeDouble:_deg forKey:kWeatherWindDeg];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeatherWind *copy = [[WeatherWind alloc] init];
    
    if (copy) {

        copy.speed = self.speed;
        copy.deg = self.deg;
    }
    
    return copy;
}


@end
