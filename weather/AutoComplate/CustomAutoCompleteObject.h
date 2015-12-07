//
//  AppDelegate.h
//  weather
//
//  Created by davut kilinc on 05/12/15.
//  Copyright © 2015 davut kilinc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLPAutoCompletionObject.h"

@interface CustomAutoCompleteObject : NSObject <MLPAutoCompletionObject>

- (id)initWithCity:(NSString *)name andId:(NSString *)cityID;
@property (strong) NSString *cityId;

@end
