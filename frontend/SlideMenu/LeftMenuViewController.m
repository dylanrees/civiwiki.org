//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"

@interface LeftMenuViewController()
{
    
}
@property (strong,nonatomic) ProfileViewController *pvc;

@end
@implementation LeftMenuViewController
@synthesize pvc;

#pragma mark - UIViewController Methods -

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self.slideOutAnimationEnabled = YES;
    UIStoryboard *profileStoryBoard = [UIStoryboard storyboardWithName:@"Profile"
                                                                bundle: nil];
    pvc = [profileStoryBoard instantiateViewControllerWithIdentifier: @"profile_view"];
    pvc.view.frame = self.view.frame;
	return [super initWithCoder:aDecoder];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.tableView.separatorColor = [UIColor lightGrayColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
	view.backgroundColor = [UIColor clearColor];
	return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftMenuCell"];
	
	switch (indexPath.row)
	{
		case 0:
			cell.textLabel.text = @"Home";
			break;
			
		case 1:
			cell.textLabel.text = @"Profile";
			break;
			
		case 2:
			cell.textLabel.text = @"Edit Mode";
			break;
			
		case 3:
			cell.textLabel.text = @"Sign Out";
			break;
	}
	
	cell.backgroundColor = [UIColor clearColor];
	cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
															 bundle: nil];
    UIStoryboard *feedStoryBoard = [UIStoryboard storyboardWithName:@"Feed"
                                                             bundle: nil];
    UIStoryboard *editModeStoryBoard = [UIStoryboard storyboardWithName:@"editMode"
                                                             bundle: nil];
	
	UIViewController *vc ;
	
	switch (indexPath.row)
	{
		case 0:
			vc = [feedStoryBoard instantiateViewControllerWithIdentifier: @"feed_view2"];
			break;
			
		case 1:
			vc = pvc;
            NSLog(@"%f %f %f %f", pvc.view.frame.origin.x, pvc.view.frame.origin.y, pvc.view.frame.size.width, pvc.view.frame.size.height);
			break;
			
		case 2:
			vc = [editModeStoryBoard instantiateViewControllerWithIdentifier: @"editmode_view"];
			break;
			
		case 3:
			[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
			[[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
			return;
			break;
	}
	[[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
															 withSlideOutAnimation:self.slideOutAnimationEnabled
																	 andCompletion:nil];
    
}

@end
