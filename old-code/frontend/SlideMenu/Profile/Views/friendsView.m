//
//  friendsView.m
//  cw_user
//
//  Created by JL on 11/22/15.
//  Copyright © 2015 JL. All rights reserved.
//

#import "friendsView.h"
#import <QuartzCore/QuartzCore.h>
@interface friendsView()
{
    
}
//@property (strong, nonatomic) UIButton * button;
@property (strong, nonatomic) UIImage * testImg;
@end

@implementation friendsView
//@synthesize button;
@synthesize testImg;
@synthesize friends;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id) init{
    self = [super init];
    if (self)
    {
        testImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://civiwiki.ngrok.io/media/profile/generic-profile.png"]]];
    }
    return self;
}
-(id) initWithArray:(NSMutableArray *) friend_list
{
    self = [self init];
    friends = [[NSMutableArray alloc]init];
    if (self)
    {
        for (NSString *username in friend_list) {
            // do something with object
            [friends addObject:username];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(30, 60, self.view.frame.size.width - 60, 120 * ceil([friends count] / 3.0) + 50 )collectionViewLayout:layout];
    //_collectionView.frame =CGRectMake(_collectionView.frame.origin.x + 30, _collectionView.frame.origin.y + 80, _collectionView.frame.size.width - 60, _collectionView.frame.size.height);
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier2"];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:_collectionView];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, _collectionView.frame.size.height + 50);
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view sizeToFit];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [friends count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier2" forIndexPath:indexPath];
    
    //cell.backgroundColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:210/255.0 alpha:0.50];
    cell.backgroundView.backgroundColor = [UIColor redColor];
    //cell.viewForFirstBaselineLayout.backgroundColor = [UIColor clearColor];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //[button setBackgroundColor: [UIColor blueColor]];
    //[button addTarget:self action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0,0,70,70);
    [button setImage:testImg forState:UIControlStateNormal];
    //[button setTitle:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forState:UIControlStateNormal];
    button.layer.cornerRadius = 10;
    button.clipsToBounds = YES;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.00].CGColor;
    
    UILabel *label =  [[UILabel alloc]init];
    label.frame = CGRectMake(0,70,70,20);
    label.text = [friends objectAtIndex:indexPath.row];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    
    [cell addSubview:button];
    [cell addSubview:label];
    return cell;
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 90);
}


@end
