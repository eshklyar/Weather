//
//  loadJSON.h
//  Weather
//
//  Created by Edik Shklyar on 8/14/15.
//  Copyright (c) 2015 Edik Shklyar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadJSON : NSObject

@property (nonatomic, weak) NSString *urlWithZip;
@property (nonatomic, weak) NSString *urlWithCityAndState;
@property (nonatomic, weak) NSString *tempString;

-(id)initWithString:(NSString *)zip;

-(void)findCityAndState;
//-(NSString *) makeUrlWithCity:(NSString *)city AndState:(NSString*)state;
-(void)findTemp:(NSString *)urlCS;


@end
