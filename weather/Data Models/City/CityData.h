//
//  CityData.h
//
//  Created by davut kilinc on 06/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityCoord;

@interface CityData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) CityCoord *coord;
@property (nonatomic, assign) double dataIdentifier;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
