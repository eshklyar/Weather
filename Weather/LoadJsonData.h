//
//  LoadJsonData.h
//  Weather
//
//  Created by Edik Shklyar on 8/23/15.
//  Copyright (c) 2015 Edik Shklyar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchJsonDataDelegate.h"
#import "ParseJsonDataForCityAndStateDelegate.h"

@interface LoadJsonData : NSObject
@property NSString * metricTempString;
@property BOOL metric;
@property FetchJsonDataDelegate *fetchJsonDataDelegate;
@property ParseJsonDataForCityAndStateDelegate * parseJsonDataForCityAndStateDelegate;

-(id)initWithString:(NSString *)zip andEnglishMetric: (BOOL)metric;

-(void) findTemp:(NSString *)urlCS;

@end
