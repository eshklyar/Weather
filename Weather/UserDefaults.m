//
//  UserDefaults.m
//  Weather
//
//  Created by Edik Shklyar on 8/17/15.
//  Copyright (c) 2015 Edik Shklyar. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

-(id)initDefults{

//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.zipCode = [self.userDefaults objectForKey:@"zipCode"];
    self.hasUserAlreadySetZipCode = [self.userDefaults objectForKey:@"DefaultsLoaded"];
    return self;
}
-(void)setDefaults:(NSString *)zip{
//    self.zipCode = zip;
    [self.userDefaults setValue:zip forKey:@"zipCode"];
    [self.userDefaults setValue:@YES forKey:@"DefaultsLoaded"];

    [self.userDefaults synchronize];

}
-(void)resetDefaults{
    [self.userDefaults setValue:@"" forKey:@"zipCode"];
    [self.userDefaults setValue:@NO forKey:@"DefaultsLoaded"];

    [self.userDefaults synchronize];

}
-(BOOL)checkIfUserDefaultsWereSet{
    self.zipCode = [self.userDefaults valueForKey:@"zipCode"];
    if ([self.zipCode isEqualToString:@""]) {
        self.hasUserAlreadySetZipCode =NO;
    } else {
        self.hasUserAlreadySetZipCode =YES;
    }
    return self.hasUserAlreadySetZipCode;
}

@end
