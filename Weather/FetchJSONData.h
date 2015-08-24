//
//  FetchJSONData.h
//  Weather
//
//  Created by Edik Shklyar on 8/21/15.
//  Copyright (c) 2015 Edik Shklyar. All rights reserved.
//


#import <Foundation/Foundation.h>
@protocol FetchJSONData <NSObject>

-(void)fetchJsonData:(NSMutableDictionary *)results;

@end

@interface FetchJSONData : NSObject

@property (weak, nonatomic) id<FetchJSONData> delegate;

-(void)fetchJsonInstanceMethod:(NSString *)urlAsString;

@end