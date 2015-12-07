//
//  ForecastSys.h
//
//  Created by davut kilinc on 05/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ForecastSys : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *pod;
@property (nonatomic, assign) double population;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
