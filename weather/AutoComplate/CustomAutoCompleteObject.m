//
//  AppDelegate.h
//  weather
//
//  Created by davut kilinc on 05/12/15.
//  Copyright © 2015 davut kilinc. All rights reserved.
//

#import "CustomAutoCompleteObject.h"

@interface CustomAutoCompleteObject ()
@property (strong) NSString *cityName;

@end

@implementation CustomAutoCompleteObject


- (id)initWithCity:(NSString *)name andId:(NSString *)cityID
{
    self = [super init];
    if (self) {
        [self setCityName:name];
        [self setCityId:cityID];
    }
    return self;
}

#pragma mark - MLPAutoCompletionObject Protocol

- (NSString *)autocompleteString
{
    return self.cityName;
}

@end
