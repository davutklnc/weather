//
//  WeatherWeather.h
//
//  Created by davut kilinc on 06/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WeatherWeather : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double weatherIdentifier;
@property (nonatomic, strong) NSString *main;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *weatherDescription;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
