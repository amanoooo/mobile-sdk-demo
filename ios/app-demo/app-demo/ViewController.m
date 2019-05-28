//
//  ViewController.m
//  app-demo
//
//  Created by hikaru amano on 2019/5/25.
//  Copyright © 2019 hikaru amano. All rights reserved.
//

#import "ViewController.h"
#import <sdk_demo/sdk_demo.h>

@interface ViewController ()

@end

@implementation ViewController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

     NSLog (@"viewDidLoad");
  

}


- (IBAction)getToken:(id)sender {
    SDK *sdk = [SDK new];
    [sdk getTokenWithName:(_name.text) andPass:(_pass.text) andDelegate:(id<SDKDelegate>) self];
}

-(void)tokenOnResult:(NSString* __nullable)token name: (NSString* __nullable) name{
    if ([_name.text isEqualToString: name]) {
        NSLog(@"tokenOnResult success get token :%@", token);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success"
                                                                                 message:token
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"OK Action");
        }];

        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else {
        NSLog(@"tokenOnResult error");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"OK Action");
        }];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
@end
