//
//  ViewController.h
//  weather
//
//  Created by davut kilinc on 05/12/15.
//  Copyright © 2015 davut kilinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLPAutoCompleteTextField.h"
@class DataSource;
@class MLPAutoCompleteTextField;

@interface ViewController : UIViewController<UITextFieldDelegate, MLPAutoCompleteTextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

