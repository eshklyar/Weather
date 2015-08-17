//
//  UserDefaults.h
//  Weather
//
//  Created by Edik Shklyar on 8/17/15.
//  Copyright (c) 2015 Edik Shklyar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject
@property NSUserDefaults *userDefaults;
@property NSString *zipCode;
@property  BOOL hasUserAlreadySetZipCode;


-(id)initDefults;
-(void)setDefaults:(NSString *)zip;
-(void)resetDefaults;
-(BOOL)checkIfUserDefaultsWereSet;



@end
