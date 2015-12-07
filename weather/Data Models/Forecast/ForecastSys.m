//
//  ForecastSys.m
//
//  Created by davut kilinc on 05/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "ForecastSys.h"


NSString *const kForecastSysPod = @"pod";
NSString *const kForecastSysPopulation = @"population";


@interface ForecastSys ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ForecastSys

@synthesize pod = _pod;
@synthesize population = _population;


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
            self.pod = [self objectOrNilForKey:kForecastSysPod fromDictionary:dict];
            self.population = [[self objectOrNilForKey:kForecastSysPopulation fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.pod forKey:kForecastSysPod];
    [mutableDict setValue:[NSNumber numberWithDouble:self.population] forKey:kForecastSysPopulation];

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

    self.pod = [aDecoder decodeObjectForKey:kForecastSysPod];
    self.population = [aDecoder decodeDoubleForKey:kForecastSysPopulation];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_pod forKey:kForecastSysPod];
    [aCoder encodeDouble:_population forKey:kForecastSysPopulation];
}

- (id)copyWithZone:(NSZone *)zone
{
    ForecastSys *copy = [[ForecastSys alloc] init];
    
    if (copy) {

        copy.pod = [self.pod copyWithZone:zone];
        copy.population = self.population;
    }
    
    return copy;
}


@end
