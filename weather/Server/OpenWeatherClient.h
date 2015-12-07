//
//  ConnectionManager.h
//  weather
//
//  Created by davut kilinc on 05/12/15.
//  Copyright © 2015 davut kilinc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface OpenWeatherClient : AFHTTPSessionManager

+ (instancetype)sharedClient;


@end
