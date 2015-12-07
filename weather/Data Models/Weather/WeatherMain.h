//
//  WeatherMain.h
//
//  Created by davut kilinc on 06/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WeatherMain : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double humidity;
@property (nonatomic, assign) double tempMin;
@property (nonatomic, assign) double tempMax;
@property (nonatomic, assign) double temp;
@property (nonatomic, assign) double pressure;
@property (nonatomic, assign) double grndLevel;
@property (nonatomic, assign) double seaLevel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
