//
//  ViewController.m
//  cw_user
//
//  Created by JL on 11/20/15.
//  Copyright © 2015 JL. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "LoginUser.h"
#import <QuartzCore/QuartzCore.h>

@interface ProfileViewController ()
{
    float container1_y;
    float container2_y;
    float container1_height;
    float container2_height;
    userInfoCtrl1 *usr1;
    userInfoCtrl2 *usr2;
}
@property (weak, nonatomic) IBOutlet UIScrollView *main_scrollview;
@property (weak, nonatomic) IBOutlet UIView *conatiners_backdrop;
@property (weak, nonatomic) IBOutlet UIView *container_1;
@property (weak, nonatomic) IBOutlet UIView *container_2;
@property (weak, nonatomic) IBOutlet UIButton *profileImageButton;
@property (strong, nonatomic) IBOutlet UIImageView *canvasImage;
@property (weak, nonatomic) IBOutlet UIButton *coverImage;

@property (weak, nonatomic) IBOutlet UIImageView *profieView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *label_fullname;
@property (weak, nonatomic) IBOutlet UILabel *label_username;

@property (strong, nonatomic) UIView *test1;
@property (strong, nonatomic) UIView *test2;

@end

@implementation ProfileViewController
@synthesize user;
@synthesize main_scrollview;
@synthesize conatiners_backdrop;
@synthesize container_1;
@synthesize container_2;
@synthesize topView;
@synthesize label_fullname;
@synthesize label_username;
@synthesize profileImageButton;
@synthesize canvasImage;
@synthesize coverImage;

@synthesize test1;
@synthesize test2;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self customInit];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self customInit];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void) customInit
{
    self.title = NSLocalizedString(@"Your Profile", nil);

    
    
    self.user = [[User alloc] initDummy];
  //[self getUserData];
    self.user = [LoginUser currentUser].u ;

    
    NSLog(@"%@",[NSString stringWithFormat:@"http://civiwiki.ngrok.io/media/%@", user.canvasImgString]);
    
    NSLog(@"this: %@", self.user.about_me);
    main_scrollview.autoresizingMask =  UIViewAutoresizingFlexibleHeight ;
    //self.view.frame = self.view.superview.bounds;
    //canvasImage.contentMode = UIViewContentModeCenter;
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(adjustFrameSize:)
                                                 name:@"SizeChangeNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(adjustFrameSize2:)
                                                 name:@"SizeChangeNotification2"
                                               object:nil];
    container1_height = container_1.frame.size.height;
    container2_height = container_2.frame.size.height;
    
    
}

-(void) refresh
{
    self.user = [LoginUser currentUser].u;
    [self.view setNeedsDisplay];
}

- (void) getUserData
{
    
    
    
    //NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    //NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://civiwiki.ngrok.io/api/user"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString * params =  [NSString stringWithFormat:@"username=%@", [LoginUser currentUser].username];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSData *data = nil;
    data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    if (error == nil)
    {
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
        NSLog(@"Data = %@",text);

        user.first_name = [[json valueForKeyPath:@"result" ][0]objectForKey:@"first_name"];
        user.last_name = [[json valueForKeyPath:@"result" ][0] objectForKey:@"last_name"];
        user.username = [[json valueForKeyPath:@"result" ][0] objectForKey:@"username"];
        user.about_me = [[json valueForKeyPath:@"result" ][0] objectForKey:@"about_me"];
        user.stats = [[json valueForKeyPath:@"result" ][0] objectForKey:@"statistics"];
        user.profileImgString = [[json valueForKeyPath:@"result" ][0] objectForKey:@"profile"];
        user.canvasImgString = [[json valueForKeyPath:@"result" ][0] objectForKey:@"cover"];
        
        
        
        label_fullname.text = [NSString stringWithFormat:@"%@ %@", user.first_name, user.last_name];
        label_username.text = [NSString stringWithFormat:@"@%@", user.username];
        usr1.user = self.user;
        usr2.user = self.user;
    }
//    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
//                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                                           NSLog(@"Response:%@ %@\n", response, error);
//                                                           NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//                                                           if(error == nil)
//                                                           {
//                                                               dispatch_async(dispatch_get_main_queue(), ^{
//                                                               
//                                                                   NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//                                                                   NSLog(@"Data = %@",text);
//
//                                                                   user.first_name = [[json valueForKeyPath:@"result" ][0]objectForKey:@"first_name"];
//                                                                   user.last_name = [[json valueForKeyPath:@"result" ][0] objectForKey:@"last_name"];
//                                                                   user.username = [[json valueForKeyPath:@"result" ][0] objectForKey:@"username"];
//                                                                   user.about_me = [[json valueForKeyPath:@"result" ][0] objectForKey:@"about_me"];
//                                                                   
//                                                                   label_fullname.text = [NSString stringWithFormat:@"%@ %@", user.first_name, user.last_name];
//                                                                   label_username.text = [NSString stringWithFormat:@"@%@", user.username];
//                                                                   usr1.user = self.user;
//                                                                   usr2.user = self.user;
//                                                               
//                                                               });
//                                                               
//                                                           }
//                                                           
//                                                       }];
//    [dataTask resume];
//    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen] bounds];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(adjustFrameSize:)
//                                                 name:@"SizeChangeNotification"
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(adjustFrameSize2:)
//                                                 name:@"SizeChangeNotification2"
//                                               object:nil];
    // Do any additional setup after loading the view, typically from a nib.
    main_scrollview.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    conatiners_backdrop.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.00];
    main_scrollview.autoresizesSubviews = YES;
    main_scrollview.autoresizingMask =  UIViewAutoresizingFlexibleHeight;
    label_fullname.text = [NSString stringWithFormat:@"%@ %@", user.first_name, user.last_name];
    label_username.text = [NSString stringWithFormat:@"@%@", user.username];
    
    profileImageButton.layer.cornerRadius = 10;
    profileImageButton.layer.masksToBounds = YES;
    profileImageButton.layer.borderWidth = 1;
    profileImageButton.backgroundColor = [UIColor whiteColor];
    profileImageButton.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.00].CGColor;
    [profileImageButton setImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://civiwiki.ngrok.io/media/%@", user.profileImgString]]]] forState: UIControlStateNormal];
    [profileImageButton setTitle:@"" forState:UIControlStateNormal];
    
    coverImage.contentMode = UIViewContentModeScaleAspectFit;
    coverImage.imageView.contentMode = UIViewContentModeScaleAspectFill;
    //coverImage.layer.masksToBounds = YES;
    [coverImage setImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://civiwiki.ngrok.io/media/%@", user.canvasImgString]]]] forState:UIControlStateNormal];
     [coverImage setTitle:@"" forState:UIControlStateNormal];
     [coverImage setNeedsDisplay];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"prepare for segue");
    if ([[segue identifier] isEqualToString:@"ctrl1"]) {
        userInfoCtrl1 *embed = segue.destinationViewController;
        usr1 = embed;
        
        embed.user = self.user;
        embed.about_me = self.user.about_me;
        
    }
    else if ([[segue identifier] isEqualToString:@"ctrl2"]) {
        userInfoCtrl2 *embed = segue.destinationViewController;
        usr2 = embed;
        embed.user = self.user;
    }
}
-(void)adjustFrameSize: (NSNotification *)note
{
    container_1.frame =  CGRectMake(container_1.frame.origin.x,
                                    10,
                                    container_1.frame.size.width,
                                    usr1.view.frame.size.height);
    
    container_2.frame = CGRectMake(container_2.frame.origin.x,
                                   container_1.frame.origin.y + usr1.view.frame.size.height + 10,
                                   container_2.frame.size.width,
                                   usr2.view.frame.size.height);
    main_scrollview.contentSize = CGSizeMake(self.view.frame.size.width, topView.frame.size.height+ usr1.view.frame.size.height + usr2.view.frame.size.height  + 150);
    conatiners_backdrop.frame = CGRectMake(container_1.frame.origin.x,
                                           topView.frame.size.height,
                                           self.view.frame.size.width,
                                           usr1.view.frame.size.height+ usr2.view.frame.size.height + 30);

}
-(void)adjustFrameSize2: (NSNotification *)note
{

    container_2.frame = CGRectMake(container_2.frame.origin.x,
                                   container_1.frame.origin.y + usr1.view.frame.size.height + 10,
                                   container_2.frame.size.width,
                                   usr2.view.frame.size.height);
    main_scrollview.contentSize = CGSizeMake(self.view.frame.size.width,topView.frame.size.height+ usr1.view.frame.size.height + usr2.view.frame.size.height  + 150);
    conatiners_backdrop.frame = CGRectMake(container_1.frame.origin.x,
                                           topView.frame.size.height,
                                           self.view.frame.size.width,
                                           container_1.frame.size.height+ container_2.frame.size.height + 30);
}
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return YES;
}
- (void) deallocObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"SizeChangeNotification"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"SizeChangeNotification2"
                                                  object:nil];
}

@end
