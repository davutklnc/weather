//
//  AppDelegate.h
//  weather
//
//  Created by davut kilinc on 05/12/15.
//  Copyright © 2015 davut kilinc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLPAutoCompleteTextFieldDataSource.h"

@interface DataSource : NSObject <MLPAutoCompleteTextFieldDataSource>


//Set this to true to return an array of autocomplete objects to the autocomplete textfield instead of strings.
//The objects returned respond to the MLPAutoCompletionObject protocol.
@property (assign) BOOL testWithAutoCompleteObjectsInsteadOfStrings;


//Set this to true to prevent auto complete terms from returning instantly.
@property (assign) BOOL simulateLatency;

@end
