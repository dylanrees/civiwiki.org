//
//  UsernameViewController.m
//  CiviWiki
//
//  Created by Labuser on 11/22/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import "UsernameViewController.h"
#import "LoginUser.h"
#import "WelcomeViewController.h"

@interface UsernameViewController ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation UsernameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nextButton.enabled = NO;
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
    [_username resignFirstResponder];
    self.responseData = [NSMutableData data];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:@"http://civiwiki.ngrok.io/api/user"]];
    NSString * params =  [NSString stringWithFormat:@"username=%@",self.username.text];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(!connection){
        self.responseData = nil;
        NSLog(@"Connection failed!");
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

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    connection = nil;
    self.responseData = nil;
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    BOOL isAvail = TRUE;
    NSError *myError = nil;
    NSDictionary *users = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    for(id key in users) {
        if ([[users objectForKey:key] count]!=0) {
            isAvail = FALSE;
            break;
        }
    }
    
    if(isAvail && ![self.username.text  isEqual: @""]){
//        UIAlertView * alertForIncorrect=[[UIAlertView alloc  ]initWithTitle:@"Proceed!" message:[NSString stringWithFormat:@"%@ is open!",self.username.text] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//            [alertForIncorrect show];
    
        self.lblVerify.text = @"Available!";
        LoginUser *user = [LoginUser currentUser];
        user.username = self.username.text;
        
        self.nextButton.enabled = YES;
    

//        }else if ([self.username.text  isEqual: @""]){
//            UIAlertView * alertForIncorrect=[[UIAlertView alloc  ]initWithTitle:@"Please fill in the field" message:@"Please pick a username" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//            [alertForIncorrect show];
        }else{
//            UIAlertView * alertForIncorrect=[[UIAlertView alloc  ]initWithTitle:@"Username is taken" message:@"Please pick another username" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//            [alertForIncorrect show];
            self.lblVerify.text = @"Unavailable.";
            
            
            self.nextButton.enabled = NO;
        }
    
    connection = nil;
    self.responseData = nil;
}



@end
