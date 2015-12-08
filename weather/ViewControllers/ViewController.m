//
//  ViewController.m
//  weather
//
//  Created by davut kilinc on 05/12/15.
//  Copyright © 2015 davut kilinc. All rights reserved.
//

#import "ViewController.h"
#import "OpenWeatherData.h"
#import "LocationManager.h"
#import "CustomAutoCompleteCell.h"
#import "CustomAutoCompleteObject.h"
#import "DataSource.h"
#import <QuartzCore/QuartzCore.h>
#import "ForecastCell.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet MLPAutoCompleteTextField *txtSearch;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorFetchData;
@property (nonatomic,strong) NSMutableArray * forecastData;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *lblCondition;
@property (weak, nonatomic) IBOutlet UILabel *lblHumidtyText;
@property (weak, nonatomic) IBOutlet UILabel *lblWindText;

@property (weak, nonatomic) IBOutlet UILabel *lblCurrentTemp;
@property (weak, nonatomic) IBOutlet UILabel *lblHumidty;
@property (weak, nonatomic) IBOutlet UILabel *lblWind;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.txtSearch setBorderStyle:UITextBorderStyleRoundedRect];
    [self.txtSearch setShowAutoCompleteTableWhenEditingBegins:YES];
    [self.txtSearch setAutoCompleteTableBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    [self.txtSearch registerAutoCompleteCellClass:[CustomAutoCompleteCell class] forCellReuseIdentifier:@"CustomCellId"];
    
    //Register device orientation state change notification to layout interface
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
}
- (void) orientationChanged:(NSNotification *)note
{
    // reloading collectionview will layout subviews automatically
    [_collectionView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getForecastDataWithLocation];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Actions
- (IBAction)showAtCurrentlocation:(id)sender {
    //Check location services for app
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Location services" message:@"Please enable location services to be able to use this option." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [self getForecastDataWithLocation];
    }
}

#pragma mark - CollectionView DataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ForecastCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ForecastCell"
                                                                            forIndexPath:indexPath];
    [cell setCellContentWithDay:_forecastData[indexPath.row]];
    return cell;

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _forecastData.count;
}
- ( NSInteger )numberOfSectionsInCollectionView:( UICollectionView * )collectionView {
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // size for 5 days view.
    // size classes active on storyboard
    return CGSizeMake((self.view.frame.size.width - 40) / 5, 100);
}
#pragma mark - TextField Delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // when user starts typing search will start.
    [self showDataLoadingActivityIndicator:YES];

    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)showDataLoadingActivityIndicator:(BOOL)shouldHide
{    dispatch_async(dispatch_get_main_queue(),
                    ^{
                        [_activityIndicatorFetchData setHidden:!shouldHide];
                        
                    });
}

#pragma mark - Server calls
-(void)setWeatherDataAndFields:(WeatherBaseClass *)data
{
    // after setting data get back to main thread and display
    dispatch_async(dispatch_get_main_queue(), ^{
        [_lblCurrentTemp setFont:[UIFont systemFontOfSize:100]];
        [_lblCurrentTemp setText:[NSString stringWithFormat:@"%.0f",data.main.temp]];
        [_lblHumidty setText:[NSString stringWithFormat:@"%.2f",data.main.humidity]];
        [_lblWind setText:[NSString stringWithFormat:@"%.2f",data.wind.speed]];
        [_lblCondition setText:data.weather[0][@"description"]];
        [_lblHumidtyText setText:@"Humidty"];
        [_lblWindText setText:@"Wind"];
        [_txtSearch setText:[NSString stringWithFormat:@"%@,%@",data.name,data.sys.country]];
    });
}

-(void)setForecastDataAndFields:(ForecastBaseClass *)data
{
    _forecastData = [NSMutableArray new];
    for (int i = 0; i < data.list.count; i++) {
        if (i%8 == 0) {
            ForecastList * aData = data.list[i];
            NSArray *dateArr = [aData.dtTxt componentsSeparatedByString:@" "];
            NSArray *dyArr = [dateArr[0] componentsSeparatedByString:@"-"];
            NSString * dateStr;
            if (dyArr.count == 3) {
                dateStr = [NSString stringWithFormat:@"%@/%@",dyArr.lastObject,dyArr[1]];
            }
            // Using self classes for cell data would take space with many cells.
            // Here it wont need but just to show my normal structre i used dictionary objects instead of using custom object with 3 pointers
            NSDictionary *dic = @{@"temp":[NSString stringWithFormat:@"%.0f",aData.main.temp],
                                  @"imgID":aData.weather[0][@"icon"]
                                  ,@"date":dateStr};
            
            [_forecastData addObject:dic];
        }
        // reload data will work on main thread no need to dispatch
        [_collectionView reloadData];
    }
}

-(void)getWeatherDataForCity:(CustomAutoCompleteObject *)obj
{
    __unused NSURLSessionTask *auth = [OpenWeatherData getcurrentWeatherDataWithCity:obj.cityId data:^(WeatherBaseClass *data, NSError *error) {
        if (!error) {
            [self setWeatherDataAndFields:data];
        }
    }];
}

-(void)getForecastDataForCity:(CustomAutoCompleteObject *)obj
{
    __unused NSURLSessionTask *auth = [OpenWeatherData getForecastDataWithCity:obj.cityId data:^(ForecastBaseClass *data, NSError *error) {
        if (!error) {
            [self setForecastDataAndFields:data];
        }
    }];
}
-(void)getForecastDataWithLocation
{
    [[LocationManager sharedInstance] askForCurrentLocation:^(CLLocation *location, NSError *error) {
        if (!error) {
            CLLocationCoordinate2D currentCoordinates = location.coordinate;
            
            [self getWeatherDataWithLocation:currentCoordinates];

            __unused NSURLSessionTask *auth = [OpenWeatherData getForecastDataWithLatitude:currentCoordinates.latitude andLongtitude:currentCoordinates.longitude data:^(ForecastBaseClass *data, NSError *error) {
                if (!error) {
                    [self setForecastDataAndFields:data];
                }
            }];
        }
        else{
            // We dont have permissions or another error happened
            [_lblCurrentTemp setFont:[UIFont systemFontOfSize:18]];
            [_lblCurrentTemp setText:@"Please select a city or press \"from my location\" to see weather data"];
        }
    }];
}
-(void)getWeatherDataWithLocation:(CLLocationCoordinate2D)coordinates
{
            CLLocationCoordinate2D currentCoordinates = coordinates;
            __unused NSURLSessionTask *auth = [OpenWeatherData getcurrentWeatherDataWithLatitude:currentCoordinates.latitude andLongtitude:currentCoordinates.longitude data:^(WeatherBaseClass *data, NSError *error) {
                if (!error) {
                    [self setWeatherDataAndFields:data];
                }
            }];
}

#pragma mark - MLPAutoCompleteTextField Delegate

// Autocomplate field delegates
- (BOOL)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
          shouldConfigureCell:(UITableViewCell *)cell
       withAutoCompleteString:(NSString *)autocompleteString
         withAttributedString:(NSAttributedString *)boldedString
        forAutoCompleteObject:(id<MLPAutoCompletionObject>)autocompleteObject
            forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // autocomplate table reloaded. task finished
    [self showDataLoadingActivityIndicator:NO];
    return YES;
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
  didSelectAutoCompleteString:(NSString *)selectedString
       withAutoCompleteObject:(id<MLPAutoCompletionObject>)selectedObject
            forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(selectedObject){
        // instead of searching for an id with city name we will use custom objects to take id
        // calling weather data with cityname is not suggested with the API
        [self getWeatherDataForCity:(CustomAutoCompleteObject *)selectedObject];
        [self getForecastDataForCity:(CustomAutoCompleteObject *)selectedObject];

    }
}


@end
