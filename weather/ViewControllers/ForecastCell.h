//
//  ForecastCell.h
//  weather
//
//  Created by davut kilinc on 07/12/15.
//  Copyright © 2015 davut kilinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDay;
@property (weak, nonatomic) IBOutlet UILabel *lblTemp;
@property (weak, nonatomic) IBOutlet UIImageView *imgWeather;
-(void)setCellContentWithDay:(NSDictionary *)data;

@end


