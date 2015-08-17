//
//  loadJSON.m
//  Weather
//
//  Created by Edik Shklyar on 8/14/15.
//  Copyright (c) 2015 Edik Shklyar. All rights reserved.
//

#import "LoadJSON.h"

@implementation LoadJSON

//-(id)initWithString{
//
//    self.urlWithoutZip = @"http://api.wunderground.com/api/7e9508288732e45b/geolookup/q/";
//    return self;
//}
-(id)initWithString: (NSString *) zip{

//    self.urlWithoutZip = @"http://api.wunderground.com/api/7e9508288732e45b/geolookup/q/";
    NSString *defaultString = @"http://api.wunderground.com/api/7e9508288732e45b/geolookup/q/";
    NSString *defaultStringWithZip = [defaultString stringByAppendingString:zip];
    self.jsonWithZip = [NSString stringWithFormat:@"%@%@",defaultStringWithZip ,@".json"];


//    self.urlWithZip = [self.urlWithoutZip stringByAppendingString:zip];
//    NSLog(@"urlWithZip in LoadJson %@", self.urlWithZip);
//    self.jsonURL = [NSString stringWithFormat:@"%@%@",self.urlWithZip ,@".json"];
    return self;
}
//-(void)addZipToURLWithoutZip: (NSString *) zip{
//
//    self.urlWithZip = [self.urlWithoutZip stringByAppendingString:zip];
//    NSLog(@"addZipToURLWithoutZip");
//}
//-(void)createJSONwithURL{
//    self.jsonURL = [NSString stringWithFormat:@"%@%@",self.urlWithZip ,@".json"];
//    NSLog(@"jsonURL");
//}

-(void)findCityAndState{
    NSMutableArray *jsonArray = [NSMutableArray new];

    NSURL *url = [NSURL URLWithString:self.jsonWithZip];
    NSLog(@"url %@", url);

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSMutableDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];

        if (connectionError) {
            NSLog(@"Error: %@", connectionError.localizedDescription);
        }
        else
        {
            NSString *urlWithCityAndState =[[results objectForKey:@"location"] objectForKey:@"requesturl"];
            NSArray *urlWithCityAndStateArray = [urlWithCityAndState componentsSeparatedByString:@"/"];

            NSString *state = urlWithCityAndStateArray[1];
            NSString *tempCity = urlWithCityAndStateArray[2];
            NSString *city = [tempCity substringWithRange: NSMakeRange(0, [tempCity rangeOfString: @"."].location)];

            NSLog(@"lalala %@", [[results objectForKey:@"location"] objectForKey:@"requesturl"]);

            NSLog(@"city and state %@, %@", city, state);
            [self makeUrlWithCity:city AndState:state];
        }
    }];
//            NSLog(@"results %@", results);
//            for (NSDictionary *dict in results) {
//                [jsonArray addObject:dict];
//
//            }
//
////            NSLog(@"array %@", jsonArray[1]);
//            if (jsonArray.count ==0) {
//                NSLog(@"json array is empty");
//            } else {
//                for (NSDictionary *subDict in jsonArray) {
//                    NSLog(@"%@",[NSString stringWithFormat:@"%@",subDict] );
//
//
//                    if ([[NSString stringWithFormat:@"%@",subDict] isEqualToString:@"location"]) {
//                        NSDictionary *location = subDict;
//                        NSLog(@"got location");
//
//                        for (id key in location) {
//                             NSLog(@"There are %@ %@'s in stock", location[key], key);
//                        }
//
//                    }
//
//
//
//
//
////                    if ([subDict objectForKey:@"location" ] == nil) {
////                        NSLog(@"location not found");
////                    }
//                else {
////                        NSDictionary *loc = [subDict objectForKey:@"location"];
////                        NSLog(@"location %@", loc);
//                    }
//                }
//            }
//
//        }
////            for (id key in [results allKeys])
////            {
////                id value = [results objectForKey:key];
////                if ([value isKindOfClass:[NSDictionary class]])
////                {
////                    NSDictionary* response = (NSDictionary*)value;
////                    NSLog(@"NSDictionary* response %@", response);
////                    for (id subKey in [response allKeys])
////                    {
////
////                        if ([response objectForKey:@"location"] == nil) {
////                            NSLog(@"location not found");
////                        } else {
////                            NSDictionary *location = [response objectForKey:@"location"];
////                            NSString *requesturlString = [location objectForKey:@"requesturl"];
////                            NSLog(@"requesturlString %@", requesturlString);
////
////                        }
////                    }
////                }
////            }
////        }
//
////        for (NSDictionary *dict in results)
////            {
////                if ([[dict objectForKey:@"location"] == nil])
////                {
////                    NSLog(@"location not found");
////                }
////                else
////                {
////                    NSDictionary *location = [dict objectForKey:@"location"];
////                    NSString *requesturlString = [location objectForKey:@"requesturl"];
////                    NSLog(@"request %@", requesturlString);
////                    self.tempString = requesturlString;
////                }
////
////            }
////        }

//    NSLog(@"tempString &@", self.tempString);
}

-(NSString *) makeUrlWithCity:(NSString *)city AndState:(NSString*)state{

    NSString *partialURL = @"http://api.wunderground.com/api/7e9508288732e45b/hourly/q/";
    NSString *urlwithCityAndState =[partialURL stringByAppendingFormat:@"%@%@%@%@",state,@"/",city,@".json"];
    NSLog(@"urlwithCityAndState %@",urlwithCityAndState);

    return urlwithCityAndState;
}

@end
