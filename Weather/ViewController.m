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
//@property UserDefaults *userDefaults;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *metricSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@property BOOL isMetric;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textFieldToEnterZip.delegate = self;

    self.isMetric = false;

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults objectForKey:@"DefaultsLoaded"] isEqualToValue:@YES]) {
        self.textFieldToEnterZip.text =[userDefaults objectForKey:@"zipCode"];
    }
    else{
        self.textFieldToEnterZip.placeholder =@"enter zip code";
    }
}

-(void)callJson:(NSString*)zip {
    self.myJSON =[[LoadJSON alloc]initWithString:zip];
//    NSLog(@"final %@", self.myJSON.urlWithZip);

//    [self.myJSON findCityAndState];
//    [self.myJSON findTemp];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    NSInteger zipNumber =[self.textFieldToEnterZip.text integerValue];

       if ((zipNumber) && ([NSString stringWithFormat:@"%ld",(long)zipNumber].length == 5)){

           NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
           [userDefaults setObject:self.textFieldToEnterZip.text forKey:@"zipCode"];
           [userDefaults setObject:@YES forKey:@"DefaultsLoaded"];

           [self.textFieldToEnterZip resignFirstResponder];
           [self callJson:self.textFieldToEnterZip.text];

           [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;


    } else {
        NSLog(@"no %li", (long)zipNumber);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"incorrect zip"
                                                        message:@"you must enter 5 digit zip code"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

 return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
- (IBAction)merticSegmentToEnglish:(id)sender {

    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;

    if (selectedSegment == 0) {
        //toggle the correct view to be visible
        self.outputLabel.text = @"english";
        self.isMetric = false;
    }
    else{
        //toggle the correct view to be visible
        self.outputLabel.text = @"metric";
        self.isMetric = true;


    }

}

@end
