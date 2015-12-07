//
//  ForecastBaseClass.h
//
//  Created by davut kilinc on 05/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ForecastCity;

@interface ForecastBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double message;
@property (nonatomic, strong) NSString *cod;
@property (nonatomic, strong) ForecastCity *city;
@property (nonatomic, assign) double cnt;
@property (nonatomic, strong) NSArray *list;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
