//
//  loadJSON.h
//  Weather
//
//  Created by Edik Shklyar on 8/14/15.
//  Copyright (c) 2015 Edik Shklyar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadJSON : NSObject
//@property (nonatomic, weak)NSString *urlWithoutZip;
//@property (nonatomic, weak)NSString *urlWithZip;
@property (nonatomic, weak) NSString *jsonWithZip;
@property NSString *tempString;


//-(id)initWithString;
-(id)initWithString:(NSString *)zip;

//-(void)addZipToURLWithoutZip: (NSString *) zip;
//-(void)createJSONwithURL;

-(void)findCityAndState;

-(NSString *) makeUrlWithCity:(NSString *)city AndState:(NSString*)state;

@end
