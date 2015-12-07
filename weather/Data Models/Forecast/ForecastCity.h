//
//  ForecastCity.h
//
//  Created by davut kilinc on 05/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ForecastCoord, ForecastSys;

@interface ForecastCity : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double cityIdentifier;
@property (nonatomic, strong) ForecastCoord *coord;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double population;
@property (nonatomic, strong) ForecastSys *sys;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
