//
//  CityBaseClass.h
//
//  Created by davut kilinc on 06/12/15
//  Copyright (c) 2015 tmob. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CityBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *data;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
