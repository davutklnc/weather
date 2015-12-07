//
//  WeatherSys.h
//
//  Created by davut kilinc on 06/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WeatherSys : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double message;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, assign) double sunset;
@property (nonatomic, assign) double sunrise;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
