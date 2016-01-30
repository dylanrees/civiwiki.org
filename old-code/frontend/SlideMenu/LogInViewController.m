//
//  LogInViewController.m
//  CiviWiki
//
//  Created by Labuser on 11/22/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import "LogInViewController.h"
#import "LoginUser.h"
#import "User.h"

@interface LogInViewController ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation LogInViewController
+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                           green:((rgbValue & 0xFF00) >> 8)/255.0
                            blue:(rgbValue & 0xFF)/255.0
                           alpha:1.0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIColor *civiPurple = [LogInViewController colorFromHexString:@"#3A0256"];
    self.navigationController.navigationBar.barTintColor = civiPurple;
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    // Do any additional setup after loading the view.

    self.btnLogin.enabled = false;
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
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    
    if(self.username.text.length > 0 &&
       self.password.text.length > 0){
        self.btnLogin.enabled = true;
    }else{
        self.btnLogin.enabled = false;
    }
}

-(void)login:(id)sender{
    //check if username and password are correct
    
    self.responseData = [NSMutableData data];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://civiwiki.ngrok.io/api/user"]];
    NSString * params =  [NSString stringWithFormat:@"username=%@",self.username.text];
    [request setHTTPMethod:@"POST"];
    NSLog(@"%@", params);
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(!connection){
        self.responseData = nil;
        NSLog(@"Connection failed!");

        //failed connection
    }else{
//        NSLog(@"Connection yes!");
    }
}

-(void)signup:(id)sender{
    //check fields and see if there's duplicate, else create user
    self.username.text = @"";
    self.password.text = @"";
    
    NSString * storyboardName = @"Login";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"NavController"];
    [self presentViewController:vc animated:YES completion:nil];
    }

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse object.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    connection = nil;
    self.responseData = nil;
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[self.responseData length]);
    
    BOOL correct = FALSE;
    NSError *myError = nil;
    NSDictionary *users = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];

//    NSLog(@"%lu",(unsigned long)users.count);
    
    
    
    
    NSString *storedUsername = [NSString stringWithFormat:@"%@",[[users objectForKey:@"result"][0] objectForKey:@"username"]];
    NSString *storedPassword = [NSString stringWithFormat:@"%@",[[users objectForKey:@"result"][0] objectForKey:@"password"]];
    NSLog(@"username: %@", storedUsername);
    NSLog(@"password: %@", storedPassword);

    BOOL usernameIsEqual = [self.username.text isEqualToString:storedUsername];
    BOOL passwordIsEqual = [self.password.text isEqualToString:storedPassword];
    
    User* u = [[User alloc] initDummy];
    u.first_name = [NSString stringWithFormat:@"%@",[[users objectForKey:@"result"][0] objectForKey:@"first_name"]];
    u.last_name = [NSString stringWithFormat:@"%@",[[users objectForKey:@"result"][0] objectForKey:@"last_name"]];
    u.username = [NSString stringWithFormat:@"%@",[[users objectForKey:@"result"][0] objectForKey:@"username"]];
    u.about_me = [NSString stringWithFormat:@"%@",[[users objectForKey:@"result"][0] objectForKey:@"about_me"]];
    u.stats = [NSString stringWithFormat:@"%@",[[users objectForKey:@"result"][0] objectForKey:@"statistics"]];
    u.profileImgString = [NSString stringWithFormat:@"%@",[[users objectForKey:@"result"][0] objectForKey:@"profile"]];
    u.canvasImgString = [NSString stringWithFormat:@"%@",[[users objectForKey:@"result"][0] objectForKey:@"cover"]];
    [LoginUser currentUser].u = u;
    
    
    
    if (usernameIsEqual && passwordIsEqual) {
        correct = TRUE;
    }

    if(correct){
            UIAlertView *alertForCorrect = [[UIAlertView alloc]initWithTitle:@"You have logged in." message:@"Welcome back!" delegate:self cancelButtonTitle:@"Dismiss"  otherButtonTitles:nil];
            [alertForCorrect show];
        NSString * storyboardName = @"Feed";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"feed_view2"];
        [self.navigationController pushViewController:vc animated:YES];
        self.username.text = @"";
        self.password.text = @"";
        }else{
            UIAlertView * alertForIncorrect=[[UIAlertView alloc  ]initWithTitle:@"Incorrect username or password!" message:@"Please double check your entries." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alertForIncorrect show];
        }
    
//    // Release the connection and the data object
//    // by setting the properties (declared elsewhere)
//    // to nil.  Note that a real-world app usually
//    // requires the delegate to manage more than one
//    // connection at a time, so these lines would
//    // typically be replaced by code to iterate through
//    // whatever data structures you are using.
    connection = nil;
    self.responseData = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
