//
//  ForecastBaseClass.m
//
//  Created by davut kilinc on 05/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import "ForecastBaseClass.h"
#import "ForecastCity.h"
#import "ForecastList.h"


NSString *const kForecastBaseClassMessage = @"message";
NSString *const kForecastBaseClassCod = @"cod";
NSString *const kForecastBaseClassCity = @"city";
NSString *const kForecastBaseClassCnt = @"cnt";
NSString *const kForecastBaseClassList = @"list";


@interface ForecastBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ForecastBaseClass

@synthesize message = _message;
@synthesize cod = _cod;
@synthesize city = _city;
@synthesize cnt = _cnt;
@synthesize list = _list;


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
            self.message = [[self objectOrNilForKey:kForecastBaseClassMessage fromDictionary:dict] doubleValue];
            self.cod = [self objectOrNilForKey:kForecastBaseClassCod fromDictionary:dict];
            self.city = [ForecastCity modelObjectWithDictionary:[dict objectForKey:kForecastBaseClassCity]];
            self.cnt = [[self objectOrNilForKey:kForecastBaseClassCnt fromDictionary:dict] doubleValue];
    NSObject *receivedForecastList = [dict objectForKey:kForecastBaseClassList];
    NSMutableArray *parsedForecastList = [NSMutableArray array];
    if ([receivedForecastList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedForecastList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedForecastList addObject:[ForecastList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedForecastList isKindOfClass:[NSDictionary class]]) {
       [parsedForecastList addObject:[ForecastList modelObjectWithDictionary:(NSDictionary *)receivedForecastList]];
    }

    self.list = [NSArray arrayWithArray:parsedForecastList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.message] forKey:kForecastBaseClassMessage];
    [mutableDict setValue:self.cod forKey:kForecastBaseClassCod];
    [mutableDict setValue:[self.city dictionaryRepresentation] forKey:kForecastBaseClassCity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cnt] forKey:kForecastBaseClassCnt];
    NSMutableArray *tempArrayForList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.list) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForList] forKey:kForecastBaseClassList];

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

    self.message = [aDecoder decodeDoubleForKey:kForecastBaseClassMessage];
    self.cod = [aDecoder decodeObjectForKey:kForecastBaseClassCod];
    self.city = [aDecoder decodeObjectForKey:kForecastBaseClassCity];
    self.cnt = [aDecoder decodeDoubleForKey:kForecastBaseClassCnt];
    self.list = [aDecoder decodeObjectForKey:kForecastBaseClassList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_message forKey:kForecastBaseClassMessage];
    [aCoder encodeObject:_cod forKey:kForecastBaseClassCod];
    [aCoder encodeObject:_city forKey:kForecastBaseClassCity];
    [aCoder encodeDouble:_cnt forKey:kForecastBaseClassCnt];
    [aCoder encodeObject:_list forKey:kForecastBaseClassList];
}

- (id)copyWithZone:(NSZone *)zone
{
    ForecastBaseClass *copy = [[ForecastBaseClass alloc] init];
    
    if (copy) {

        copy.message = self.message;
        copy.cod = [self.cod copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.cnt = self.cnt;
        copy.list = [self.list copyWithZone:zone];
    }
    
    return copy;
}


@end
