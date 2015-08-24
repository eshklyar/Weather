////
////  loadJSON.m
////  Weather
////
////  Created by Edik Shklyar on 8/14/15.
////  Copyright (c) 2015 Edik Shklyar. All rights reserved.
////
//#import "LoadJSON.h"
//#import "FetchJSONData.h"
//#import "ParseJsonDataForCityAndStateDelegate.h"
////#import "FetchJsonDataDelegate"
//
//
//#define API_KEY @"7e9508288732e45b"
//@property FetchJSONData *fetchJsonDataDelegate;
//@property ParseJsonDataForCityAndStateDelegate *parseJsonDataForCityandStateDelegate;
//
//
//
//@implementation LoadJSON <FetchJsonDataDelegate, ParseJsonDataForCityAndStateDelegate>
//
//
//-(id)initWithString:(NSString *) zip andEnglishMetric:(BOOL)metric{
//
//    self.metric = metric;
//    self.fetchJsonDataDelegate.delegate = self;
//
//    NSString *urlAsString = [NSString stringWithFormat:@"http://api.wunderground.com/api/%@/geolookup/q/%@/%@", API_KEY,zip,@".json"];
//
//    [self.fetchJsonDataDelegate fetchJsonInstanceMethod:urlAsString];
//
//    return self;
//}
//
//-(void)fetchJsonData:(NSMutableDictionary *)results{
//
//    self.parseJsonDataForCityandStateDelegate.delegate = self;
//    [self.parseJsonDataForCityandStateDelegate parseInstanceMethod];
//
////    [self findTemp:urlwithCityAndState];
//
//}
//-(void)findTemp:(NSString *)urlCS {
//
//    NSURL *url = [NSURL URLWithString:urlCS];
//        NSLog(@"url %@", url);
//
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//
//        NSMutableDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
//
//        if (connectionError) {
//
//            NSLog(@"Error: %@", connectionError.localizedDescription);
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"Not Found" object:self];
//        }
//        else {
//
//            NSArray *hourlyForcast =[results objectForKey:@"hourly_forecast"];
//            NSDictionary *FCTTIME =  hourlyForcast[0];
//            NSDictionary *temperture = [FCTTIME objectForKey:@"temp"];
//            NSLog(@"temperture %@", temperture);
//
//
//            if (self.metric == 0) {
//                self.metricTempString = [temperture objectForKey:@"english"];
//            }
//
//            else if (self.metric == 1){
//                self.metricTempString = [temperture objectForKey:@"metric"];
//            }
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"Tempreture" object:self];
//
//        }
//            NSLog(@"self.metricTempString %@", self.metricTempString);
//
//    }];
//}
//
//@end
