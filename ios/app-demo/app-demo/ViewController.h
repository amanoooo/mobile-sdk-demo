//
//  ViewController.h
//  app-demo
//
//  Created by hikaru amano on 2019/5/25.
//  Copyright © 2019 hikaru amano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic) IBOutlet UITextField *pass;
@property(nonatomic) IBOutlet UITextField *name;
@property(nonatomic) IBOutlet UILabel *mlabel;


- (IBAction)getToken:(id)sender;

@end

