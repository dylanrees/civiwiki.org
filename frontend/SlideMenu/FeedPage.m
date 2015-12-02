//
//  FeedPage.m
//  CiviFeed-Shefali
//
//  Created by Labuser on 11/15/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import "FeedPage.h"
#import "WebInterface.h"

@interface FeedPage () {
}

@end

@implementation FeedPage
@synthesize body, author, visits, articleTitle, ratingsBar, ratingsItems, ratingNegTwo, ratingNegOne, ratingZero, ratingPosOne, ratingPosTwo;


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self)
        {
            
            author = [[UILabel alloc] init];
            author.frame = CGRectMake(10, 10,self.view.frame.size.width - 100, self.view.frame.size.height/4);
            author.numberOfLines = 0;
            author.lineBreakMode = NSLineBreakByWordWrapping;
            [author setFont:[UIFont systemFontOfSize:12]];
            [self.view addSubview:author];
            
            visits = [[UILabel alloc] init];
            visits.frame = CGRectMake(10, 30,self.view.frame.size.width - 100, self.view.frame.size.height/4);
            visits.numberOfLines = 0;
            visits.lineBreakMode = NSLineBreakByWordWrapping;
            [visits setFont:[UIFont systemFontOfSize:12]];
            [self.view addSubview:visits];
            
            body = [[UILabel alloc]init];
            body.frame = CGRectMake(10, 100,self.view.frame.size.width - 10, self.view.frame.size.height/4);
            self.view.backgroundColor = [UIColor whiteColor];
            body.numberOfLines = 0;
            body.lineBreakMode = NSLineBreakByWordWrapping;
            [body setFont:[UIFont systemFontOfSize:16]];
            [self.view addSubview:body];
            
            articleTitle = [[UILabel alloc] init];
            articleTitle.frame = CGRectMake(10, 60, self.view.frame.size.width, self.view.frame.size.height/4);
            articleTitle.numberOfLines = 0;
            articleTitle.lineBreakMode = NSLineBreakByWordWrapping;
            [articleTitle setFont:[UIFont systemFontOfSize:24]];
            [articleTitle setTextAlignment:NSTextAlignmentCenter];
            [self.view addSubview:articleTitle];
            
            
        }
    
    return self;
}

- (UIToolbar *)createToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
    UIBarButtonItem *rateButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UITabBarSystemItemFavorites target:self action:@selector(rateCivi)];
    NSArray *buttonItems = [NSArray arrayWithObjects:rateButton, nil];
    [toolbar setItems:buttonItems];
    return toolbar;
    
}

-(void)rateCivi {
    
}

-(void) viewDidAppear:(BOOL)animated {
    /*
    UIToolbar *rateBar2 = [self createToolbar];
    [self.view addSubview:rateBar2];
     */
    
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%@", body.text);
    
    ratingsBar = [[UIToolbar alloc] init];
    ratingsBar.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
    
    UIBarButtonItem *rateNegTwo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favourite24.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *rateNegOne = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favourite24.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *rateZero = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favourite24.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *ratePosOne = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favourite24.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *ratePosTwo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favourite24.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    
    ratingsItems = [[NSArray alloc] initWithObjects:rateNegTwo, flexibleSpace, rateNegOne, flexibleSpace, rateZero, flexibleSpace, ratePosOne, flexibleSpace, ratePosTwo, nil];
    
    [ratingsBar setItems:ratingsItems];
    [self.view addSubview:ratingsBar];
    
    
    self.navigationController.toolbarHidden = NO;    
}

- (void)buttonClicked:(UIButton *)sender {
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
