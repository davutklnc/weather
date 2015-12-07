//
//  AppDelegate.h
//  weather
//
//  Created by davut kilinc on 05/12/15.
//  Copyright © 2015 davut kilinc. All rights reserved.
//
#import "DataSource.h"
#import "CustomAutoCompleteObject.h"
#import "OpenWeatherData.h"


@interface DataSource ()

@property (strong, nonatomic) NSArray *cityObjects;

@end


@implementation DataSource


#pragma mark - MLPAutoCompleteTextField DataSource


//example of asynchronous fetch:
- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        handler([self allCountryObjects]);
    });
}

// parsin data with the properties we need
- (NSArray *)allCountryObjects
{
    if(!self.cityObjects){
        [self fetchAllCities:^( NSDictionary *citiesData) {
            NSMutableArray *mutableCountries = [NSMutableArray new];
            for(NSString *cityNanme in [citiesData allKeys]){
                CustomAutoCompleteObject *country = [[CustomAutoCompleteObject alloc] initWithCity:cityNanme andId:citiesData[cityNanme]];
                [mutableCountries addObject:country];
            }
            [self setCityObjects:[NSArray arrayWithArray:mutableCountries]];
        }];
    }
    
    return self.cityObjects;
}
// getting all city names from local json

-(void)fetchAllCities:(void (^)(NSDictionary *citiesData))block
{
    [OpenWeatherData getAllCities:^(NSDictionary *cities, NSError *error) {
        if (!error) {
            block(cities);
        }
    }];
}






@end
