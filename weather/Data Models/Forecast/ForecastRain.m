//
//  ForecastRain.m
//
//  Created by davut kilinc on 05/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "ForecastRain.h"


NSString *const kForecastRain3h = @"3h";


@interface ForecastRain ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ForecastRain

@synthesize h3h = _3h;


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
            self.h3h = [[self objectOrNilForKey:kForecastRain3h fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.h3h] forKey:kForecastRain3h];

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

    self.h3h = [aDecoder decodeDoubleForKey:kForecastRain3h];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_3h forKey:kForecastRain3h];
}

- (id)copyWithZone:(NSZone *)zone
{
    ForecastRain *copy = [[ForecastRain alloc] init];
    
    if (copy) {

        copy.h3h = self.h3h;
    }
    
    return copy;
}


@end
