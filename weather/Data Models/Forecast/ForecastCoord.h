//
//  ForecastCoord.h
//
//  Created by davut kilinc on 05/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ForecastCoord : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double lon;
@property (nonatomic, assign) double lat;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
