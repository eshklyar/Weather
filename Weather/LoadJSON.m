//
//  loadJSON.m
//  Weather
//
//  Created by Edik Shklyar on 8/14/15.
//  Copyright (c) 2015 Edik Shklyar. All rights reserved.
//
#import "LoadJSON.h"

@implementation LoadJSON


-(id)initWithString:(NSString *) zip andEnglishMetric:(BOOL)metric{

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

            [self findTemp:urlwithCityAndState];

        }
    }];

    return self;
}


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
            NSDictionary *FCTTIME =  hourlyForcast[0];
            NSDictionary *temperture = [FCTTIME objectForKey:@"temp"];
            NSLog(@"temperture %@", temperture);


            if (self.metric == 0) {
                NSString *tempretureMetric = [temperture objectForKey:@"english"];
                self.metricTempString = tempretureMetric;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Tempreture" object:self];
                NSLog(@"tempretureMetric, %@",tempretureMetric);

            }

            else if (self.metric == 1){
                NSString *tempretureMetric = [temperture objectForKey:@"metric"];
                self.metricTempString = tempretureMetric;

                [[NSNotificationCenter defaultCenter] postNotificationName:@"Tempreture" object:self];

                NSLog(@"tempretureMetric, %@",tempretureMetric);
            }
            else{
                NSLog(@"something is wrong");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Not Found" object:self];
            }
        }
            NSLog(@"hello world");
            NSLog(@"hello world %@", self.metricTempString);

    }];
}

@end
