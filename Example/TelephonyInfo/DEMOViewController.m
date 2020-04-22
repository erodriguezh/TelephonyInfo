//
//  DEMOViewController.m
//  TelephonyInfo
//
//  Created by erodriguezh on 04/06/2020.
//  Copyright (c) 2020 erodriguezh. All rights reserved.
//

#import "DEMOViewController.h"
#import <TelephonyInfo/TelephonyInfo.h>

@interface DEMOViewController ()

@end

@implementation DEMOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    TelephonyInfo *telephonyInfo = [[TelephonyInfo alloc] init];
    NSString *simData = [telephonyInfo getData];
    
    NSData *jsonData = [simData dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;

    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

    if (error) {
        _outputView.text=[NSString stringWithFormat:@"Error parsing JSON: %@",error];
        NSLog(@"Error parsing JSON: %@", error);
    } else {
        NSArray *jsonArray = (NSArray *)jsonObject;
        NSMutableString *myString = [[NSMutableString alloc] init];

        [jsonArray enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
            [object enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                [myString appendFormat:@"%@ : %@\n", key, obj];
            }];
        }];
        
        _outputView.text = myString;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
