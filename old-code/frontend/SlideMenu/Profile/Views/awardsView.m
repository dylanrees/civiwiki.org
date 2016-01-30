//
//  awardsView.m
//  cw_user
//
//  Created by JL on 11/22/15.
//  Copyright © 2015 JL. All rights reserved.
//




#import "awardsView.h"
@interface awardsView()
{
    
}
@property (strong, nonatomic) NSArray *award_images;
@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) NSMutableArray *cell_items;
@end


@implementation awardsView
@synthesize award_images;
@synthesize images;
@synthesize cell_items;
@synthesize awards;


/*
 * init()
 * Sets up the cell contents based on given array.
 */
-(id) init{
    self = [super init];
    if (self)
    {
        award_images = [NSArray arrayWithObjects:@"chirp",@"feedburner", @"search", @"sharethis", @"mail", @"instagram", @"embed", @"thumbit", @"chirp", nil];
        images = [[NSMutableArray alloc]init];
        images = [[NSArray arrayWithObjects:
                   [UIImage imageNamed:@"chirp"],
                   [UIImage imageNamed:@"feedburner"],
                   [UIImage imageNamed:@"embed"],
                   [UIImage imageNamed:@"sharethis"],
                   [UIImage imageNamed:@"mail"],
                   [UIImage imageNamed:@"instagram"],
                  [UIImage imageNamed:@"embed"],
                  [UIImage imageNamed:@"thumbit"],
                  [UIImage imageNamed:@"forrst"],
                  //[UIImage imageNamed:@"ello"],
                   nil] mutableCopy];
    }
    return self;
}

-(id) initWithArray:(NSArray *) award_list
{
    self = [self init];
    awards = [[NSMutableArray alloc]init];
    if (self)
    {
        for (id award_string in award_list) {
            // do something with object
            [awards addObject:award_string];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0,0,0,0 );
    _collectionView= [[UICollectionView alloc] initWithFrame:CGRectMake(30, 60, self.view.frame.size.width - 60, 100 * ceil([awards count] / 3.0) + 60 ) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    //[_collectionView setBackgroundColor:[UIColor orangeColor]];
    
    //[_collectionView sizeToFit];
    _collectionView.contentSize = CGSizeMake(self.view.frame.size.width, 100 * ceil([awards count] / 3.0));
    _collectionView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    //_collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight |
    //UIViewAutoresizingFlexibleWidth;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, _collectionView.frame.size.height + 60);
    //
    [self.view addSubview:_collectionView];
    //[self.view sizeToFit];
    //NSLog(@"%f %f %f", self.view.frame.size.height, _collectionView.frame.size.height, ([images count] / 3.0));

    
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [awards count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
//    
//    UIImageView *collectionImageView = (UIImageView *)[cell viewWithTag:100];
//    cell.backgroundColor= [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:0.50];
//    collectionImageView.image = [UIImage imageNamed:[award_images objectAtIndex:indexPath.row]];
//    NSLog(@"%@", [award_images objectAtIndex:indexPath.row]);
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.contentView.frame];
//    imageView.image = collectionImageView.image ;
//    [cell.contentView addSubview:imageView];
//    return cell;
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5,0,50,50)];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.clipsToBounds = YES;
    imgView.image = [images objectAtIndex:indexPath.row];
    UILabel *customLabel = [[UILabel alloc]initWithFrame: CGRectMake(0,60,60,20)];
    customLabel.text =[awards objectAtIndex:indexPath.row];
    customLabel.textAlignment = NSTextAlignmentCenter;
    customLabel.font = [UIFont systemFontOfSize:13];
    customLabel.textColor= [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.00];
    [cell addSubview:imgView];
    [cell addSubview:customLabel];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 80);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
