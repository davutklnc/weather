//
//  ForecastWind.m
//
//  Created by davut kilinc on 05/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "ForecastWind.h"


NSString *const kForecastWindSpeed = @"speed";
NSString *const kForecastWindDeg = @"deg";


@interface ForecastWind ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ForecastWind

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
            self.speed = [[self objectOrNilForKey:kForecastWindSpeed fromDictionary:dict] doubleValue];
            self.deg = [[self objectOrNilForKey:kForecastWindDeg fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.speed] forKey:kForecastWindSpeed];
    [mutableDict setValue:[NSNumber numberWithDouble:self.deg] forKey:kForecastWindDeg];

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

    self.speed = [aDecoder decodeDoubleForKey:kForecastWindSpeed];
    self.deg = [aDecoder decodeDoubleForKey:kForecastWindDeg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_speed forKey:kForecastWindSpeed];
    [aCoder encodeDouble:_deg forKey:kForecastWindDeg];
}

- (id)copyWithZone:(NSZone *)zone
{
    ForecastWind *copy = [[ForecastWind alloc] init];
    
    if (copy) {

        copy.speed = self.speed;
        copy.deg = self.deg;
    }
    
    return copy;
}


@end
