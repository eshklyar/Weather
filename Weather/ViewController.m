//
//  ViewController.m
//  Weather
//
//  Created by Edik Shklyar on 8/14/15.
//  Copyright (c) 2015 Edik Shklyar. All rights reserved.
//

#import "ViewController.h"
#import "LoadJSON.h"
#import "UserDefaults.h"

@interface ViewController () <UITextFieldDelegate>
@property LoadJSON *myJSON;
@property (weak, nonatomic) IBOutlet UITextField *textFieldToEnterZip;
@property  BOOL hasUserAlreadySetZipCode;
@property NSString *zipCode;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textFieldToEnterZip.delegate = self;



    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    self.hasUserAlreadySetZipCode = [userDefaults objectForKey:@"DefaultsLoaded"];
    self.zipCode = [userDefaults objectForKey:@"zipCode"];
//   NSString *tempstring = [userDefaults objectForKey:@"zipCode"];
//    NSLog(@"tempString ,%@", tempstring);



    NSLog(@"zipcode and hasSet %@ %d", self.zipCode, self.hasUserAlreadySetZipCode);
    if ([self.zipCode isEqualToString:@""]) {
//        self.hasUserAlreadySetZipCode = @NO;
        [userDefaults setObject:@NO forKey:@"DefaultsLoaded"];
        self.hasUserAlreadySetZipCode = NO;
        NSLog(@"hasUserAlreadySetZipCode %d", self.hasUserAlreadySetZipCode);
        self.textFieldToEnterZip.placeholder = @"type zip code here";

    } else {
          self.hasUserAlreadySetZipCode = [userDefaults objectForKey:@"DefaultsLoaded"];
//        self.hasUserAlreadySetZipCode = @YES;

        self.textFieldToEnterZip.placeholder = self.zipCode;

    }
//    if (self.hasUserAlreadySetZipCode == YES)
//        {
//        self.zipCode = [userDefaults objectForKey:@"zipCode"];
//        self.textFieldToEnterZip.placeholder = self.zipCode;
//
//    }
//    else{
//        self.textFieldToEnterZip.placeholder = @"type zip code here";
//    }





//  NSLog(@"hasUserAlreadySetZipCode %@",self.hasUserAlreadySetZipCode);
//    NSString *zip =@"52401";
//    NSString *zip =self.textFieldToEnterZip.text;
//    [self.textFieldToEnterZip resignFirstResponder];





//    NSLog(@"defaultString %@", self.myJSON.urlWithoutZip);

//    [self.myJSON addZipToURLWithoutZip:zip];
//    NSLog(@"url with zip %@", self.myJSON.urlWithZip);
//
//    [self.myJSON createJSONwithURL];
//    NSLog(@"jsonURL %@",self.myJSON.jsonURL);

//
//
//    NSString *urlWithoutZip = @"http://api.wunderground.com/api/7e9508288732e45b/geolookup/q/";
//
//    NSString *urlWithZip = [urlWithoutZip stringByAppendingString:zip];
//    NSString *jsonURL = [NSString stringWithFormat:@"%@%@",urlWithZip ,@".json"];

//    NSLog(@"jsonURL %@",jsonURL);
}

-(void)callJson:(NSString*)zip {
    self.myJSON =[[LoadJSON alloc]initWithString:zip];
    NSLog(@"final %@", self.myJSON.jsonWithZip);

    [self.myJSON findCityAndState];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

// [self.textFieldToEnterZip resignFirstResponder];


    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.hasUserAlreadySetZipCode = [userDefaults objectForKey:@"DefaultsLoaded"];
    if (self.hasUserAlreadySetZipCode == NO)  {


//    if ((self.hasUserAlreadySetZipCode == NO) || ([self.textFieldToEnterZip.text isEqualToString:@""])) {
        self.zipCode = self.textFieldToEnterZip.text;

        [userDefaults setValue:self.zipCode forKey:@"zipCode"];
        [userDefaults setValue:@YES forKey:@"DefaultsLoaded"];

        [userDefaults synchronize];


    }

//        self.zipCode = [userDefaults objectForKey:@"zipCode"];
//    }
//    self.textFieldToEnterZip.text = [defaults objectForKey:@"infoString"];

//    NSString *zip = self.textFieldToEnterZip.text;
//    NSLog(@"urlString = %@",zip);


//    [self.textFieldToEnterZip resignFirstResponder];
//     [self callJson:zip];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.zipCode = self.textFieldToEnterZip.text;
    [userDefaults setValue:self.zipCode forKey:@"zipCode"];
    if ([self.textFieldToEnterZip.text isEqualToString:@""]) {
        self.textFieldToEnterZip.placeholder = @"type zip code here";
    }

    [self.textFieldToEnterZip resignFirstResponder];
    [self callJson:self.zipCode];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    return YES;

}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
@end
