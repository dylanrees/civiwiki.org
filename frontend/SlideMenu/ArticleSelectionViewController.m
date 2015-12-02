//
//  ArticleSelectionViewController.m
//  Civi_Frontend_Zeqi
//
//  Created by Labuser on 11/22/15.
//  Copyright (c) 2015 Labuser. All rights reserved.
//

#import "ArticleSelectionViewController.h"
#import "WebInterface.h"

@interface ArticleSelectionViewController ()

@end

@implementation ArticleSelectionViewController

@synthesize notificationTarget;
@synthesize articles;
@synthesize intakeData;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //query
    self.articles = [NSArray arrayWithObjects:@"TEMP\nSub 1\nSub 2\nSub 3\n\t#Some hashtags", nil];
    [self.myView registerClass:[ArticleCell class] forCellReuseIdentifier:@"potatoTable"];
    [self.myView setBackgroundColor:[UIColor colorWithRed:246.0/255.0 green:230.0/255.0 blue:254.0/255.0 alpha:1.0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadUsingCategory:(NSString *)category
{
    NSLog(@"Reloading the table with new category %@", category);
    self.intakeData=[WebInterface JSONDataFromUrl:@"http://civiwiki.ngrok.io/api/articles" withPOST:[NSString stringWithFormat:@"id=%@", category]];
    NSMutableArray* staging =[[NSMutableArray alloc] initWithCapacity:[self.intakeData count]];
    for(int i = 0; i<[self.intakeData count]; ++i)
    {
        [staging insertObject:[[self.intakeData objectAtIndex:i] objectForKey:@"topic" ] atIndex:i];
    }
    self.articles = [[NSArray alloc] initWithArray:staging];
    //work work work
    //Query the database
    //self.articles = {articles featured in this category}
    [self.myView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.articles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"potatoTable" forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.text = [self.articles objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:230.0/255.0 blue:254.0/255.0 alpha:1.0];
    [cell sizeToFit];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //ignore this warning.  The code dang works
    [self.notificationTarget performSelector:@selector(articleTouch:) withObject:[NSNumber numberWithInteger:indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130; //(25*numLines)+5;
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
