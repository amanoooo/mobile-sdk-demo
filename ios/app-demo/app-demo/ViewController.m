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
    [sdk getTokenWithName:(_name.text) andPass:(_pass.text)];

}
@end
