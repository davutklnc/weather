//
//  ForecastCell.m
//  weather
//
//  Created by davut kilinc on 07/12/15.
//  Copyright © 2015 davut kilinc. All rights reserved.
//

#import "ForecastCell.h"

@implementation ForecastCell

-(void)setCellContentWithDay:(NSDictionary *)data
{
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSString * imgurlStr = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png",data[@"imgID"]];
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imgurlStr]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            _imgWeather.image = [UIImage imageWithData: data];
        });
    });
    [_lblDay setText:data[@"date"]];
    [_lblTemp setText:data[@"temp"]];
}
@end
