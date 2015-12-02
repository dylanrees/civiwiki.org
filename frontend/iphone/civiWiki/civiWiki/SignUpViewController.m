//
//  SignUpViewController.m
//  CiviWiki
//
//  Created by Labuser on 11/15/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import "SignUpViewController.h"

@implementation SignUpViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    
    [_fullNameText resignFirstResponder];
    [_usernameText resignFirstResponder];
    [_emailText resignFirstResponder];
    [_passwordText resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
