//
//  loadJSON.h
//  Weather
//
//  Created by Edik Shklyar on 8/14/15.
//  Copyright (c) 2015 Edik Shklyar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadJSON : NSObject

@property NSString *myString;
//@property (nonatomic, weak) NSString *urlWithZip;
//@property (nonatomic, weak) NSString *urlWithCityAndState;
@property NSString * metricTempString;
@property BOOL metric;

-(id)initWithString:(NSString *)zip andEnglishMetric: (BOOL)metric;

//-(void)findCityAndState;
//-(NSString *) makeUrlWithCity:(NSString *)city AndState:(NSString*)state;
- (void) methodToGetTemp:(NSString *(^)(NSString *time))speedFunction;
-(void) findTemp:(NSString *)urlCS;
-(NSString *)lala;

//-(NSString *) getTemp:(NSString *)tempr;

@end
