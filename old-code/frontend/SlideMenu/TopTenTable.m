//
//  TopTenTable.m
//  CiviFeediPhone
//
//  Created by Labuser on 11/29/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import "TopTenTable.h"
#import "WebInterface.h"
#import "TopTenTableCell.h"
#import "FeedPage.h"
#import "LeftMenuViewController.h"

@interface TopTenTable () {
    NSMutableArray *civiTitles;
    NSMutableArray *civiViews;
    NSMutableArray *civiBody;
    NSMutableArray *civiAuthor;
    UINavigationBar *myBar;
}

@end

@implementation TopTenTable


//@synthesize navBar;
@synthesize barTintColor;

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
   
    
    
    UIColor *civiPurple = [TopTenTable colorFromHexString:@"#3A0256"];
    self.navigationController.navigationBar.barTintColor = civiPurple;
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 503);
    self.portraitSlideOffsetSegment.selectedSegmentIndex = [self indexFromPixels:[SlideNavigationController sharedInstance].portraitSlideOffset];
    self.landscapeSlideOffsetSegment.selectedSegmentIndex = [self indexFromPixels:[SlideNavigationController sharedInstance].landscapeSlideOffset];
    self.panGestureSwitch.on = [SlideNavigationController sharedInstance].enableSwipeGesture;
    self.shadowSwitch.on = [SlideNavigationController sharedInstance].enableShadow;
    self.limitPanGestureSwitch.on = ([SlideNavigationController sharedInstance].panGestureSideOffset == 0) ? NO : YES;
    self.slideOutAnimationSwitch.on = ((LeftMenuViewController *)[SlideNavigationController sharedInstance].leftMenu).slideOutAnimationEnabled;
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(buttonClicked:)];
    self.navigationItem.leftBarButtonItem = backButton;
    [backButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    

//    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(buttonClicked:)];
//    self.navigationItem.rightBarButtonItem = searchButton;
//    
    
}

- (void)buttonClicked:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    UINavigationController *navigationController = self.navigationController;
    NSLog(@"Views in hierarchy: %@", [navigationController viewControllers]);
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    civiTitles = [[NSMutableArray alloc]init];
    civiViews = [[NSMutableArray alloc] init];
    civiBody = [[NSMutableArray alloc] init];
    civiAuthor = [[NSMutableArray alloc] init];
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSArray *data = [WebInterface JSONDataFromUrl:@"http://civiwiki.ngrok.io/api/topten"];
        for (NSDictionary *entry in data) {
            [civiTitles addObject: [entry objectForKey:@"title"]];
            
            //converting and placing visits into array
            NSNumber *visits = [entry objectForKey:@"visits"];
            NSString *converted = [NSString stringWithFormat:@"Visits: %@", visits];
            [civiViews addObject:converted];
            
            [civiBody addObject:[entry objectForKey:@"body"]];
            
            NSString *author = @"Author: ";
            author = [author stringByAppendingString:[entry objectForKey:@"author"]];
            [civiAuthor addObject:author];
        }
        
        
        self.title = @"Top 10 Civies";
        //navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 375, 50)];
    }
    
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [civiTitles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"TopTenTableCell";
    TopTenTableCell *cell = (TopTenTableCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[TopTenTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    cell.CiviTitleLabel.text = [civiTitles objectAtIndex:indexPath.row];
    cell.CiviViewsLabel.text = [civiViews objectAtIndex:indexPath.row];
    //cell.textLabel.text = [civiBody objectAtIndex:indexPath.row];
    cell.CiviAuthorLabel.text = [civiAuthor objectAtIndex:indexPath.row];
    
    cell.CiviTitleLabel.textColor = [UIColor blackColor];
    cell.CiviViewsLabel.textColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.CiviAuthorLabel.textColor = [UIColor blackColor];
    
    //[cell.CiviTitleLabel bringSubviewToFront: self.view];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showCiviDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        FeedPage *destViewController = segue.destinationViewController;
        
        //destViewController.heading = [civiTitles objectAtIndex:indexPath.row];
        //destViewController.title = destViewController.heading;
        
        destViewController.body.text =[civiBody objectAtIndex:indexPath.row];
        destViewController.author.text = [civiAuthor objectAtIndex:indexPath.row];
        
        NSNumber *visits = [civiViews objectAtIndex:indexPath.row];
        NSString *numVisits = [NSString stringWithFormat:@"%@", visits];
        destViewController.visits.text = numVisits;
        
        destViewController.articleTitle.text = [civiTitles objectAtIndex:indexPath.row];
        
    }
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
