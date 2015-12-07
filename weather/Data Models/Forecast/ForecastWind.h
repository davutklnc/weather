//
//  ForecastWind.h
//
//  Created by davut kilinc on 05/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ForecastWind : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double speed;
@property (nonatomic, assign) double deg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
