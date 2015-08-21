//
//  loadJSON.m
//  Weather
//
//  Created by Edik Shklyar on 8/14/15.
//  Copyright (c) 2015 Edik Shklyar. All rights reserved.
//
#import "LoadJSON.h"

@implementation LoadJSON


-(id)initWithString: (NSString *) zip andEnglishMetric: (BOOL)metric{

    self.metric = metric;

    NSString *defaultURL = @"http://api.wunderground.com/api/7e9508288732e45b/geolookup/q/";
    NSString *defaultURLWithZip = [defaultURL stringByAppendingString:zip];
    NSString *urlWithZip = [NSString stringWithFormat:@"%@%@",defaultURLWithZip ,@".json"];

    NSURL *url = [NSURL URLWithString:urlWithZip];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSMutableDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];

        if (connectionError) {
            NSLog(@"Error: %@", connectionError.localizedDescription);
        }
        else
        {
            NSString *urlWithCityAndState =[[results objectForKey:@"location"] objectForKey:@"requesturl"];
            NSLog(@" first urlWithCityAndState %@", urlWithCityAndState);
            NSArray *urlWithCityAndStateArray = [urlWithCityAndState componentsSeparatedByString:@"/"];

            NSString *state = urlWithCityAndStateArray[1];
            NSString *tempCity = urlWithCityAndStateArray[2];
            NSString *city = [tempCity substringWithRange: NSMakeRange(0, [tempCity rangeOfString: @"."].location)];

            NSLog (@"testing state and city %@%@", state, city);

            NSString *partialURL = @"http://api.wunderground.com/api/7e9508288732e45b/hourly/q/";
            //            self.urlWithCityAndState =[partialURL stringByAppendingFormat:@"%@%@",state,tempCity];

            NSString *urlwithCityAndState =[partialURL stringByAppendingFormat:@"%@%@%@%@",state,@"/",city,@".json"];

            NSLog(@"!!!!!!!!!urlwithCityAndState %@", urlwithCityAndState);

//            NSLog(@"!!!!!!!!!urlwithCityAndState %@", self.urlWithCityAndState);
            [self findTemp:urlwithCityAndState];



            //            NSLog(@"lalala %@", [[results objectForKey:@"location"] objectForKey:@"requesturl"]);

            //            NSLog(@"city and state %@, %@", city, state);
            //            [self makeUrlWithCity:city AndState:state];
            
            //            self.urlWithCityAndSt = [self makeUrlWithCity:city AndState:state];
            //            NSLog (@"***************urlWithCityAndSt %@", self.urlWithCityAndSt);
        }
    }];






//    self.urlWithZip = [NSString stringWithFormat:@"%@%@",defaultURLWithZip ,@".json"];

    return self;
}

//-(void)findCityAndState{
//
////    NSMutableArray *jsonArray = [NSMutableArray new];
//
//    NSURL *url = [NSURL URLWithString:self.urlWithZip];
////    NSLog(@"url %@", url);
//
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//
//        NSMutableDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
//
//        if (connectionError) {
//            NSLog(@"Error: %@", connectionError.localizedDescription);
//        }
//        else
//        {
//            NSString *urlWithCityAndState =[[results objectForKey:@"location"] objectForKey:@"requesturl"];
//            NSArray *urlWithCityAndStateArray = [urlWithCityAndState componentsSeparatedByString:@"/"];
//
//            NSString *state = urlWithCityAndStateArray[1];
//            NSString *tempCity = urlWithCityAndStateArray[2];
//            NSString *city = [tempCity substringWithRange: NSMakeRange(0, [tempCity rangeOfString: @"."].location)];
//
//            NSLog (@"testing state and city %@%@", state, city);
//
//            NSString *partialURL = @"http://api.wunderground.com/api/7e9508288732e45b/hourly/q/";
////            self.urlWithCityAndState =[partialURL stringByAppendingFormat:@"%@%@",state,tempCity];
//
//            NSString *urlwithCityAndState =[partialURL stringByAppendingFormat:@"%@%@%@%@",state,@"/",city,@".json"];
//
//
//
//            NSLog(@"!!!!!!!!!urlwithCityAndState %@", self.urlWithCityAndState);
////            [self findTemp];
//
//
////            NSLog(@"lalala %@", [[results objectForKey:@"location"] objectForKey:@"requesturl"]);
//
////            NSLog(@"city and state %@, %@", city, state);
////            [self makeUrlWithCity:city AndState:state];
//
////            self.urlWithCityAndSt = [self makeUrlWithCity:city AndState:state];
////            NSLog (@"***************urlWithCityAndSt %@", self.urlWithCityAndSt);
//        }
//    }];
//}
//
////-(NSString *) makeUrlWithCity:(NSString *)city AndState:(NSString*)state{
////
////    NSString *partialURL = @"http://api.wunderground.com/api/7e9508288732e45b/hourly/q/";
////    NSString *urlwithCityAndState =[partialURL stringByAppendingFormat:@"%@%@%@%@",state,@"/",city,@".json"];
////    NSLog(@"urlwithCityAndState %@",urlwithCityAndState);
////
////    return urlwithCityAndState;
////}

-(void)findTemp:(NSString *)urlCS {


    NSMutableArray *jsonArray = [NSMutableArray new];

    NSURL *url = [NSURL URLWithString:urlCS];
        NSLog(@"url %@", url);

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSMutableDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];

        if (connectionError) {
            NSLog(@"Error: %@", connectionError.localizedDescription);
        }
        else
        {
            NSArray *hourlyForcast =[results objectForKey:@"hourly_forecast"];
//            NSDictionary *hourDict =[results objectForKey:@"hourly_forecast"];
//            NSLog(@"hourDict %@", hourDict);

//            for (id key in [hourDict allKeys]) {
//                id value = [results objectForKey:key];
//                if ([value isKindOfClass:[NSDictionary class]]) {
//                    NSDictionary* newDict = (NSDictionary*)value;
//                    NSLog(@"newDict %@", hourlyForcast[0]);
            NSDictionary *FCTTIME =  hourlyForcast[0];
            NSDictionary *temperture = [FCTTIME objectForKey:@"temp"];
            NSLog(@"newDict %@", temperture);

//            NSString *gettingTemp = [NSString new];


            if (self.metric == true) {
                NSString *tempretureMetric = [temperture objectForKey:@"english"];
                self.metricTempString = tempretureMetric;

//                 self.metricTempString = tempretureMetric;
                NSLog(@"tempretureMetric, %@",tempretureMetric);
//                NSLog(@"tempretureMetric 2, %@",self.metricTempString);
//                 [self lala:tempretureMetric ];
//                    return tempretureMetric;
            }

            else if (self.metric == false){
                NSString *tempretureMetric = [temperture objectForKey:@"metric"];
//                 self.metricTempString = tempretureMetric;
                self.metricTempString = tempretureMetric;

                [[NSNotificationCenter defaultCenter] postNotificationName:@"Tempreture" object:self];

                NSLog(@"tempretureMetric, %@",tempretureMetric);
//                NSLog(@"tempretureMetric 2, %@",self.metricTempString);
//                  [self lala:tempretureMetric ];
//                return tempretureMetric;
            }
            else{
                NSLog(@"something is wrong");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Not Found" object:self];

//                return nil;
            }


//                NSLog(@"key: %@, value: %@", @"temp", [key objectForKey:@"temp"]);
        }

//            for (NSDictionary *dict in hourlyForcast)
//            {
//
//                           NSLog(@"this is a dict222 %@", hourlyForcast[0]);
//
////                NSLog(@"this is a dict %@", dict);
//
//            }


//            NSLog(@"hourlyForcast %@", hourlyForcast);

            NSLog(@"hello world");
            NSLog(@"hello world %@", self.metricTempString);
//        return self.metricTempString;

//        }
    }];
//    return self.metricTempString;

}

//-(NSString *) getTemp:(NSString *)tempr{
//    self.metricTempString = tempr;
//
//return self.metricTempString;
//}

//}
-(NSString *)lala{
    NSString*tempString = self.metricTempString;
    return tempString;
}
- (void)methodToGetTemp:(NSString * (^)(NSString * time))speedFunction
                    {
    self.metricTempString =@"45";
}

@end
