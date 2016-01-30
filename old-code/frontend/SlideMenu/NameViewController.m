//
//  NameViewController.m
//  CiviWiki
//
//  Created by Labuser on 11/22/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import "NameViewController.h"
#import "LoginUser.h"

@interface NameViewController ()

@end

@implementation NameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.btnNext.enabled = false;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [self.firstName resignFirstResponder];
    [self.lastName resignFirstResponder];
    if(self.firstName.text.length > 0 && self.lastName.text.length > 0){
        self.btnNext.enabled = true;
    }else{
        self.btnNext.enabled = false;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)next:(id)sender {
    NSLog(@"first name: %@", self.firstName.text);
    NSLog(@"last name: %@", self.lastName.text);
    
    LoginUser *user = [LoginUser currentUser];
    user.firstName = self.firstName.text;
    user.lastName = self.lastName.text;
    
}
@end
