//
//  LoadJsonData.m
//  Weather
//
//  Created by Edik Shklyar on 8/23/15.
//  Copyright (c) 2015 Edik Shklyar. All rights reserved.
//

#import "LoadJsonData.h"
#import "FetchJSONData.h"
#import "ParseJsonDataForCityAndStateDelegate.h"
#define API_KEY @"7e9508288732e45b"

@interface LoadJsonData () <FetchJsonDataDelegate, ParseJsonDataForCityAndStateDelegate>

@end

@implementation LoadJsonData
//<FetchJsonDataDelegate>

//, ParseJsonDataForCityAndStateDelegate>

-(id)initWithString:(NSString *) zip andEnglishMetric:(BOOL)metric{
    NSLog(@"initWithString");
    self.metric = metric;

    NSString *urlAsString = [NSString stringWithFormat:@"http://api.wunderground.com/api/%@/geolookup/q/%@/%@", API_KEY,zip,@".json"];


    [self main:urlAsString];
    return self;
}
-(void)main:(NSString *)urlAsString{


   [self callFetchJsonDataDelegate:urlAsString];
//     NSDictionary *results =

}

-(void)callFetchJsonDataDelegate:(NSString *)urlAsString{
     self.fetchJsonDataDelegate =[[FetchJsonDataDelegate alloc]init];
     self.fetchJsonDataDelegate.delegate = self;
    [self.fetchJsonDataDelegate fetchJsonInstanceMethod:urlAsString];
     NSLog(@"hello world %@", urlAsString);
}
-(void)fetchJsonData:(NSMutableDictionary *)results{
    NSLog(@"testing fetchJsonData");

    NSLog(@"results, %@", results);

    self.parseJsonDataForCityAndStateDelegate =[ParseJsonDataForCityAndStateDelegate new];
    self.parseJsonDataForCityAndStateDelegate.delegate = self;
    [self.parseJsonDataForCityAndStateDelegate parseInstanceMethod:results];

}
-(void)parseDelegateMethod:(NSString *)string{

    NSLog(@"string %@", string);
    [self findTemp:string];
}

-(void)findTemp:(NSString *)urlCS {

    NSURL *url = [NSURL URLWithString:urlCS];
    NSLog(@"url %@", url);

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSMutableDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];

        if (connectionError) {

            NSLog(@"Error: %@", connectionError.localizedDescription);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Not Found" object:self];
        }
        else {

            NSArray *hourlyForcast =[results objectForKey:@"hourly_forecast"];
            NSDictionary *FCTTIME =  hourlyForcast[0];
            NSDictionary *temperture = [FCTTIME objectForKey:@"temp"];
            NSLog(@"temperture %@", temperture);


            if (self.metric == 0) {
                self.metricTempString = [temperture objectForKey:@"english"];
            }

            else if (self.metric == 1){
                self.metricTempString = [temperture objectForKey:@"metric"];
            }

            [[NSNotificationCenter defaultCenter] postNotificationName:@"Tempreture" object:self];
            
        }
        NSLog(@"self.metricTempString %@", self.metricTempString);
        
    }];
}



@end
