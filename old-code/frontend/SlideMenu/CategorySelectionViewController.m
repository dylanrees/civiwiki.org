//
//  CategorySelectionViewController.m
//  Civi_Frontend_Zeqi
//
//  Created by Aaron Graubert on 11/20/15.
//  Copyright (c) 2015 Labuser. All rights reserved.
//

#import "CategorySelectionViewController.h"
#import "WebInterface.h"
#import "LeftMenuViewController.h"


@interface CategorySelectionViewController()
@end

@implementation CategorySelectionViewController
@synthesize categories; //query from somewhere
@synthesize categoriesP;
@synthesize myNav;
@synthesize notificationTarget;
//BTBreadcrumbView *bread2;

-(void)viewDidLoad
{
    NSLog(@"CSVC preparing view");
    //query for categories
    NSArray* temp = [WebInterface JSONDataFromUrl:@"http://civiwiki.ngrok.io/api/categories"];
    /*NSMutableArray* staging =[[NSMutableArray alloc] initWithCapacity:[temp count]];
    for(int i = 0; i<[temp count]; ++i)
    {
        [staging insertObject:[[temp objectAtIndex:i] objectForKey:@"name" ] atIndex:i];
    }*/
    //Store the fetched data
    self.categories = [[NSArray alloc] initWithArray:temp];
    [self.myView registerClass:[CategoryCell class] forCellWithReuseIdentifier:@"potatoCollect"];
    
    self.categoriesP = [NSArray arrayWithObjects:@"Economics.jpg", @"Taxes.jpg", @"human-rights.jpg", @"Education.jpg", @"Election.jpg", @"Environment.jpg", @"Health.jpg", @"Laws.jpg", @"Military.jpg", @"Political.jpg", @"Religion.jpg",@"Technology.jpg", @"Treaties.jpg", @"Wars.jpg", @"Disaster.jpg",nil];
    [self.myView registerClass:[CategoryCell class] forCellWithReuseIdentifier:@"potatoCollect"];
    //246, 230, 254
    [self.view setBackgroundColor:[UIColor colorWithRed:246.0/255.0 green:230.0/255.0 blue:254.0/255.0 alpha:1.0]];
    [self.myView setBackgroundColor:[UIColor colorWithRed:246.0/255.0 green:230.0/255.0 blue:254.0/255.0 alpha:1.0]];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 503);
    self.portraitSlideOffsetSegment.selectedSegmentIndex = [self indexFromPixels:[SlideNavigationController sharedInstance].portraitSlideOffset];
    self.landscapeSlideOffsetSegment.selectedSegmentIndex = [self indexFromPixels:[SlideNavigationController sharedInstance].landscapeSlideOffset];
    self.panGestureSwitch.on = [SlideNavigationController sharedInstance].enableSwipeGesture;
    self.shadowSwitch.on = [SlideNavigationController sharedInstance].enableShadow;
    self.limitPanGestureSwitch.on = ([SlideNavigationController sharedInstance].panGestureSideOffset == 0) ? NO : YES;
    self.slideOutAnimationSwitch.on = ((LeftMenuViewController *)[SlideNavigationController sharedInstance].leftMenu).slideOutAnimationEnabled;
    
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.categories count]; //*15 is just so it looks like we have a bunch of categories
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Renders a cell containing the category's name
    CategoryCell *cell = [self.myView dequeueReusableCellWithReuseIdentifier:@"potatoCollect" forIndexPath:indexPath];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.categoriesP objectAtIndex:indexPath.row]] ];
    
    [cell setText:[[self.categories objectAtIndex:indexPath.row] objectForKey:@"name"]];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"User selected item named %@ at index %d", [[self.categories objectAtIndex:indexPath.row % [self.categories count]] objectForKey:@"name"], indexPath.row);
    //ignore this warning.  It can't tell if the notification target has this selector, but it does
    [self.notificationTarget performSelector:@selector(categoryTouch:) withObject:[NSNumber numberWithInteger:indexPath.row]];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100.0, 100.0);
}


//-(void)breadcrumbView:(BTBreadcrumbView *)view didTapItemAtIndex:(NSUInteger)index
//{
//    NSLog(@"Breadcrumb at %d", index);
//
//}
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

