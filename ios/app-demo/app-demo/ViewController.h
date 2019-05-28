//
//  ViewController.h
//  app-demo
//
//  Created by hikaru amano on 2019/5/25.
//  Copyright © 2019 hikaru amano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sdk_demo/sdk_demo.h>

@interface ViewController : UIViewController<SDKDelegate>

@property(nonatomic) IBOutlet UITextField *pass;
@property(nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UILabel *tokenLabel;




- (IBAction)getToken:(id)sender;

@end

