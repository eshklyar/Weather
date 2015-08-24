//
//  FetchJSONData.m
//  Weather
//
//  Created by Edik Shklyar on 8/21/15.
//  Copyright (c) 2015 Edik Shklyar. All rights reserved.
//

#import "FetchJSONData.h"

@implementation FetchJSONData


-(void)fetchJsonInstanceMethod:(NSString *)urlAsString {

    NSURL *url = [NSURL URLWithString:urlAsString];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSMutableDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];

        if (connectionError) {
            NSLog(@"Error: %@", connectionError.localizedDescription);
        }
        else
        {
            [self.delegate fetchJsonData:results];

        }
    }];
}

@end