//
//  WelcomeViewController.m
//  CiviWiki
//
//  Created by Labuser on 11/22/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginUser.h"
@interface WelcomeViewController ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LoginUser *user = [LoginUser currentUser];
    NSLog(@"first name: %@", user.firstName);
    NSLog(@"last name: %@", user.lastName);
    NSLog(@"number: %lu", (unsigned long)user.number);
    NSLog(@"password: %@", user.password);
    NSLog(@"username: %@", user.username);
    
    // Do any additional setup after loading the view.

    
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    [_params setObject:[NSString stringWithFormat:@"%@", user.username] forKey:@"username"];
    [_params setObject:[NSString stringWithFormat:@"%@", user.lastName] forKey:@"first_name"];
    [_params setObject:[NSString stringWithFormat:@"%@", user.firstName] forKey:@"last_name"];
    [_params setObject:[NSString stringWithFormat:@"%@", user.email] forKey:@"email"];
    [_params setObject:[NSString stringWithFormat:@"%@", user.password] forKey:@"password"];
    [_params setObject:[NSString stringWithFormat:@"Hi! CiviWiki is fun!"] forKey:@"about_me"];
    
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    
    // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
    NSString* ProfileFileParamConstant = [NSString stringWithFormat:@"profile"];
    NSString* CoverFileParamConstant = [NSString stringWithFormat:@"cover"];
    
    // the server url to which the image (or the media) is uploaded. Use your server url here
    NSURL* requestURL = [NSURL URLWithString:@"http://civiwiki.ngrok.io/api/adduser"];
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in _params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    NSData *profileImageData = UIImageJPEGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://civiwiki.ngrok.io/media/profile/generic-profile.png"]]], 1.0);
    if (profileImageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"generic-profile.png\"\r\n", ProfileFileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Type: image/jpg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:profileImageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // add image data
    
    NSData *coverImageData = UIImageJPEGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://agbeat.com/wp-content/uploads/2012/11/facebook-cover-photo-9.jpg"]]], 1.0);
    if (coverImageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"c.jpg\"\r\n", CoverFileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Type: image/jpg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:coverImageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:requestURL];
    
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSData *data = nil;
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error == nil)
    {
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
        NSLog(@"Data = %@",text);
        
        //        user.first_name = [[json valueForKeyPath:@"result" ][0]objectForKey:@"first_name"];
        //        user.last_name = [[json valueForKeyPath:@"result" ][0] objectForKey:@"last_name"];
        //        user.username = [[json valueForKeyPath:@"result" ][0] objectForKey:@"username"];
        //        user.about_me = [[json valueForKeyPath:@"result" ][0] objectForKey:@"about_me"];
        //        user.stats = [[json valueForKeyPath:@"result" ][0] objectForKey:@"statistics"];
        //        user.profileImgString = [[json valueForKeyPath:@"result" ][0] objectForKey:@"profile"];
        //        user.canvasImgString = [[json valueForKeyPath:@"result" ][0] objectForKey:@"cover"];
        //
        //
        //
        //        label_fullname.text = [NSString stringWithFormat:@"%@ %@", user.first_name, user.last_name];
        //        label_username.text = [NSString stringWithFormat:@"@%@", user.username];
        //        usr1.user = self.user;
        //        usr2.user = self.user;
    } else
    {
        NSLog(@"Error: %@", error);
    }

//    self.responseData = [NSMutableData data];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
//                             [NSURL URLWithString:@"http://civiwiki.ngrok.io/api/adduser"]];
//    NSString * params =  [NSString stringWithFormat:@"first_name=%@&last_name=%@&email=%@&username=%@&about_me=%@&password=%@&profile=",user.firstName, user.lastName, user.email, user.username, @"", user.password];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    
//    if(!connection){
//        self.responseData = nil;
//        NSLog(@"Connection failed!");
//    }else{
//        NSLog(@"default connection works");
//    }
//    
//    NSError *error = nil;
//    NSURLResponse *response = nil;
//    NSData *data = nil;
//    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    if (error == nil)
//    {
//        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//        NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//        NSLog(@"Data = %@",text);
//    }
    
    
    
// // In body data for the 'application/x-www-form-urlencoded' content type,
//// form fields are separated by an ampersand. Note the absence of a
//// leading ampersand.
// 
//NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://civiwiki.ngrok.io/api/adduser"]];
// 
//// Set the request's content type to application/x-www-form-urlencoded
//[postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
// 
//// Designate the request a POST request and specify its body data
//[postRequest setHTTPMethod:@"POST"];
//[postRequest setHTTPBody:[NSData dataWithBytes:[params UTF8String] length:strlen([params UTF8String])]];
// 
//// Initialize the NSURLConnection and proceed as described in
//// Retrieving the Contents of a URL
//
//NSLog(@"urlencoded");

   //if successfully added check that
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

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

    NSLog(@"Connection did finish loading");
//    BOOL isAvail = TRUE;
    NSError *myError = nil;
    NSDictionary *users = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    for(id key in users) {
        id value = [users objectForKey:key];
//        prints out all keys and values
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        NSLog(@"key: %@", keyAsString);
        NSLog(@"objects: %@", valueAsString);
    }
//
//    if(isAvail && ![self.username.text  isEqual: @""]){
//        UIAlertView * alertForIncorrect=[[UIAlertView alloc  ]initWithTitle:@"Proceed!" message:[NSString stringWithFormat:@"%@ is open!",self.username.text] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//            [alertForIncorrect show];
//    
//        User *user = [User currentUser];
//        user.username = self.username.text;
//        
//        self.nextButton.enabled = YES;
//    
//
//        }else if ([self.username.text  isEqual: @""]){
//            UIAlertView * alertForIncorrect=[[UIAlertView alloc  ]initWithTitle:@"Please fill in the field" message:@"Please pick a username" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//            [alertForIncorrect show];
//        }else{
//            UIAlertView * alertForIncorrect=[[UIAlertView alloc  ]initWithTitle:@"Username is taken" message:@"Please pick another username" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//            [alertForIncorrect show];
//        }
    
    connection = nil;
    self.responseData = nil;
}

    
    
    
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
