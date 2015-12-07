//
//  ForecastMain.h
//
//  Created by davut kilinc on 05/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ForecastMain : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double humidity;
@property (nonatomic, assign) double tempMin;
@property (nonatomic, assign) double tempKf;
@property (nonatomic, assign) double tempMax;
@property (nonatomic, assign) double temp;
@property (nonatomic, assign) double pressure;
@property (nonatomic, assign) double seaLevel;
@property (nonatomic, assign) double grndLevel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
