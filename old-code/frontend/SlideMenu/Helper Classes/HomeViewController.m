//
//  HomeViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "HomeViewController.h"
#import "LeftMenuViewController.h"

@implementation HomeViewController
- (IBAction)getUser:(id)sender {
    NSLog(@"Pressed");
    // Dictionary that holds post parameters. You can set your post parameters that your server accepts or programmed to accept.
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    [_params setObject:[NSString stringWithFormat:@"jl3"] forKey:@"username"];
    [_params setObject:[NSString stringWithFormat:@"JooHee"] forKey:@"first_name"];
    [_params setObject:[NSString stringWithFormat:@"Lee"] forKey:@"last_name"];
    [_params setObject:[NSString stringWithFormat:@"jl3@jl.jl"] forKey:@"email"];
    [_params setObject:[NSString stringWithFormat:@"I am jl3. This is my profile page. I will make my about section longer to test whether the frames and the view bounds were set properly."] forKey:@"about_me"];
    
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
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
	self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 503);
	self.portraitSlideOffsetSegment.selectedSegmentIndex = [self indexFromPixels:[SlideNavigationController sharedInstance].portraitSlideOffset];
	self.landscapeSlideOffsetSegment.selectedSegmentIndex = [self indexFromPixels:[SlideNavigationController sharedInstance].landscapeSlideOffset];
	self.panGestureSwitch.on = [SlideNavigationController sharedInstance].enableSwipeGesture;
	self.shadowSwitch.on = [SlideNavigationController sharedInstance].enableShadow;
	self.limitPanGestureSwitch.on = ([SlideNavigationController sharedInstance].panGestureSideOffset == 0) ? NO : YES;
	self.slideOutAnimationSwitch.on = ((LeftMenuViewController *)[SlideNavigationController sharedInstance].leftMenu).slideOutAnimationEnabled;
    
    
    
//    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
//    
//
//    
//    NSURL * url = [NSURL URLWithString:@"http://civiwiki.ngrok.io/api/adduser"];
//    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
//    NSString * params =  [NSString stringWithFormat:@"first_name=%@&last_name=%@&email=%@&username=%@&about_me=%@&password=%@",@"first1", @"last1", @"email1@test.com", @"username1", @"hello", @"1234"];
//    [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSError *error = nil;
//    NSURLResponse *response = nil;
//    NSData *data = nil;
//    data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
//    if (error == nil)
//    {
//        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//        NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//        NSLog(@"Data = %@",text);
    
//        
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
  //  }
    
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return YES;
}

#pragma mark - IBActions -

- (IBAction)bounceMenu:(id)sender
{
	static Menu menu = MenuLeft;
	
	[[SlideNavigationController sharedInstance] bounceMenu:menu withCompletion:nil];
	
	menu = (menu == MenuLeft) ? MenuRight : MenuLeft;
}

- (IBAction)slideOutAnimationSwitchChanged:(UISwitch *)sender
{
	((LeftMenuViewController *)[SlideNavigationController sharedInstance].leftMenu).slideOutAnimationEnabled = sender.isOn;
}

- (IBAction)limitPanGestureSwitchChanged:(UISwitch *)sender
{
	[SlideNavigationController sharedInstance].panGestureSideOffset = (sender.isOn) ? 50 : 0;
}

- (IBAction)changeAnimationSelected:(id)sender
{
	[[SlideNavigationController sharedInstance] openMenu:MenuRight withCompletion:nil];
}

- (IBAction)shadowSwitchSelected:(UISwitch *)sender
{
	[SlideNavigationController sharedInstance].enableShadow = sender.isOn;
}

- (IBAction)enablePanGestureSelected:(UISwitch *)sender
{
	[SlideNavigationController sharedInstance].enableSwipeGesture = sender.isOn;
}

//- (IBAction)portraitSlideOffsetChanged:(UISegmentedControl *)sender
//{
//	[SlideNavigationController sharedInstance].portraitSlideOffset = [self pixelsFromIndex:sender.selectedSegmentIndex];
//}

- (IBAction)landscapeSlideOffsetChanged:(UISegmentedControl *)sender
{
	[SlideNavigationController sharedInstance].landscapeSlideOffset = [self pixelsFromIndex:sender.selectedSegmentIndex];
}

#pragma mark - Helpers -

- (NSInteger)indexFromPixels:(NSInteger)pixels
{
	if (pixels == 60)
		return 0;
	else if (pixels == 120)
		return 1;
	else
		return 2;
}

- (NSInteger)pixelsFromIndex:(NSInteger)index
{
	switch (index)
	{
		case 0:
			return 60;
			
		case 1:
			return 120;
			
		case 2:
			return 200;
			
		default:
			return 0;
	}
}

@end
