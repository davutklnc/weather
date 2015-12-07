//
//  CityData.m
//
//  Created by davut kilinc on 06/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "CityData.h"
#import "CityCoord.h"


NSString *const kCityDataCoord = @"coord";
NSString *const kCityDataId = @"_id";
NSString *const kCityDataCountry = @"country";
NSString *const kCityDataName = @"name";


@interface CityData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CityData

@synthesize coord = _coord;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize country = _country;
@synthesize name = _name;


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
            self.coord = [CityCoord modelObjectWithDictionary:[dict objectForKey:kCityDataCoord]];
            self.dataIdentifier = [[self objectOrNilForKey:kCityDataId fromDictionary:dict] doubleValue];
            self.country = [self objectOrNilForKey:kCityDataCountry fromDictionary:dict];
            self.name = [self objectOrNilForKey:kCityDataName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.coord dictionaryRepresentation] forKey:kCityDataCoord];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataIdentifier] forKey:kCityDataId];
    [mutableDict setValue:self.country forKey:kCityDataCountry];
    [mutableDict setValue:self.name forKey:kCityDataName];

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

    self.coord = [aDecoder decodeObjectForKey:kCityDataCoord];
    self.dataIdentifier = [aDecoder decodeDoubleForKey:kCityDataId];
    self.country = [aDecoder decodeObjectForKey:kCityDataCountry];
    self.name = [aDecoder decodeObjectForKey:kCityDataName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_coord forKey:kCityDataCoord];
    [aCoder encodeDouble:_dataIdentifier forKey:kCityDataId];
    [aCoder encodeObject:_country forKey:kCityDataCountry];
    [aCoder encodeObject:_name forKey:kCityDataName];
}

- (id)copyWithZone:(NSZone *)zone
{
    CityData *copy = [[CityData alloc] init];
    
    if (copy) {

        copy.coord = [self.coord copyWithZone:zone];
        copy.dataIdentifier = self.dataIdentifier;
        copy.country = [self.country copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
