//
//  CityBaseClass.m
//
//  Created by davut kilinc on 06/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "CityBaseClass.h"
#import "CityData.h"


NSString *const kCityBaseClassData = @"data";


@interface CityBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CityBaseClass

@synthesize data = _data;


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
    NSObject *receivedCityData = [dict objectForKey:kCityBaseClassData];
    NSMutableArray *parsedCityData = [NSMutableArray array];
    if ([receivedCityData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCityData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCityData addObject:[CityData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCityData isKindOfClass:[NSDictionary class]]) {
       [parsedCityData addObject:[CityData modelObjectWithDictionary:(NSDictionary *)receivedCityData]];
    }

    self.data = [NSArray arrayWithArray:parsedCityData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kCityBaseClassData];

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

    self.data = [aDecoder decodeObjectForKey:kCityBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kCityBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    CityBaseClass *copy = [[CityBaseClass alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
