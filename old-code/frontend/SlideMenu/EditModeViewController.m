//
//  ViewController.m
//  Civi_Frontend_Zeqi
//
//  Created by Labuser on 11/15/15.
//  Copyright (c) 2015 Labuser. All rights reserved.
//

#import "EditModeViewController.h"
#import "SlideNavigationController.h"

@interface EditModeViewController ()

@end

BTBreadcrumbView *bread;
int currentStackSize = 0;
NSInteger last = -1;
NSInteger lastArticle= -1;
NSInteger issueIndex = -1;
NSInteger causeIndex = -1;
NSInteger solutionIndex = -1;
int currentTopView = 0;
@implementation EditModeViewController
@synthesize categoryVC;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"hi");
    bread = [[BTBreadcrumbView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 60, 0, 0)];
    bread.delegate = self;
    [bread sizeToFit];
    [self.view addSubview:bread];
    [bread setItems:[NSArray arrayWithObjects:[self generateCrumb:@"Choose Category"], nil] animated:YES];
    self.categoryVC = [[UIStoryboard storyboardWithName:@"editMode" bundle:nil] instantiateViewControllerWithIdentifier:@"csvc"];
    self.categoryVC.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + bread.frame.size.height + 60, self.view.frame.size.width, self.view.frame.size.height - bread.frame.size.height);
    [self.categoryVC setNotificationTarget:self];
    [self.view addSubview:self.categoryVC.view];
    self.articleVC = [[UIStoryboard storyboardWithName:@"editMode" bundle:nil] instantiateViewControllerWithIdentifier:@"asvc"];
    self.articleVC.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + bread.frame.size.height + 60, self.view.frame.size.width, self.view.frame.size.height - bread.frame.size.height);
    //any other setup.  DO NOT ADD AS SUBVIEW
    [self.articleVC setNotificationTarget:self];
    self.civiVC = [[UIStoryboard storyboardWithName:@"editMode" bundle:nil] instantiateViewControllerWithIdentifier:@"vsvc"];
    self.civiVC.view.frame =CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + bread.frame.size.height + 60, self.view.frame.size.width, self.view.frame.size.height - bread.frame.size.height);
    [self.civiVC setNotificationTarget:self];
    [self.view setBackgroundColor:[UIColor colorWithRed:58.0/255.0 green:2.0/255.0 blue:86.0/255.0 alpha:1.0]];
    
    
//    UIButton* customButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [customButton setImage:[UIImage imageNamed:@"menu-button.png"] forState:UIControlStateNormal];
//    [customButton sizeToFit];
//    UIBarButtonItem* customBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    UIBarButtonItem* customBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-button.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openLeftMenu:)];
    self.navigationItem.leftBarButtonItem = customBarButtonItem;
    
//    UIBarButtonItem *btnSidebar = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(openLeftMenu:)];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)openLeftMenu:(id) sender {
    [[SlideNavigationController sharedInstance] toggleLeftMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BTBreadcrumbItem *)generateCrumb:(NSString*)title
{
    BTBreadcrumbItem *item = [[BTBreadcrumbItem alloc] init];
    item.title = title;
    return item;
}

-(void)switchToView:(NSInteger)view //0:Category view, 1:Article view, 2:CiviView
{
    if(currentTopView == view) return;
    NSLog(@"Executing switch from view %d to view %d", currentTopView, view);
    switch(currentTopView)
    {
        case 0:
            [self.categoryVC.view removeFromSuperview];
            break;
        case 1:
            [self.articleVC.view removeFromSuperview];
            break;
        case 2:
            [self.civiVC.view removeFromSuperview];
            break;
        default:
            NSLog(@"Unrecognized current top view (%d)", currentTopView);
            return;
    }
    switch(view)
    {
        case 1:
            [self.view addSubview:self.articleVC.view];
            break;
        case 2:
            [self.view addSubview:self.civiVC.view];
            break;
        default:
            NSLog(@"Unrecognized new view (%d).  Switching to CSVC", view);
            view = 0;
        case 0:
            [self.view addSubview:self.categoryVC.view];
            break;
    }
    currentTopView = view;
}

-(void)breadcrumbView:(BTBreadcrumbView *)view didTapItemAtIndex:(NSUInteger)index //process a touch along the breadcrumb
{
    NSLog(@"Breadcrumb at %d", index);
    if(index <= currentStackSize && currentStackSize < 10)
    {
        //if we touched a button that isn't the rightmost button, and we aren't in a right-shifted mode
        switch(index)
        {
            case 0:
                //return to cat
                NSLog(@"Returning to category selection screen");
                [self switchToView:0];
                break;
            case 1:
                //return to article
                NSLog(@"Returning to article selection screen");
                [self switchToView:1];
                break;
            case 2:
                //return to civi
                if(currentStackSize >=4) //if we're in a left-shifted mode
                {
                    NSLog(@"Breadcrumb shift right");
                    NSMutableArray* labels = [[NSMutableArray alloc] initWithObjects:[self generateCrumb:@"...>"], nil];
                    for(int i = 1; i+2<currentStackSize; ++i) //add breadcrumbs as necessary
                    {
                        NSString* temp;
                        switch(i)
                        {
                            case 1://issue
                                temp = @"Issue";
                                break;
                            case 2://cause
                                temp = @"Cause";
                                break;
                            case 3: //solution?
                                temp = @"Solution";
                                break;
                        }
                        [labels addObject:[self generateCrumb:[NSString stringWithFormat:@"%@ >", temp]]];
                    }
                    NSString* label;
                    switch(currentStackSize) //add the final breadcrumb
                    {
                        case 4:
                            label = @"Choose Cause";
                            break;
                        case 5:
                            label = @"Choose Solution";
                            break;
                        case 6:
                            label = @"";
                            break;
                    }
                    [labels addObject:[self generateCrumb:label]];
                    [bread setItems:labels];
                    currentStackSize += 6;
                }
                else
                {
                    NSLog(@"Switch to issue selection mode");
                    [self switchToView:2];
                }
                break;
            default:
                //oh shit, son
                NSLog(@"Unknown breadcrumb press");
        }
    }
    else if(currentStackSize >= 10)
    {
        if(index == 0) //expand the left crumb
        {
            NSLog(@"Breadcrumb shift left");
            currentStackSize -= 6;
            NSString* label = [[[self.categoryVC categories] objectAtIndex:last] objectForKey:@"name"];
            if([label length] > 12) //deal with an oversized breadcrumb
            {
                label = [NSString stringWithFormat:@"%@%@", [label substringToIndex:9], @"..." ];
            }
            label = [NSString stringWithFormat:@"%@%@", label, @" >"];
            NSString* articleLabel = [[self.articleVC articles] objectAtIndex:lastArticle];
            if([articleLabel length] > 12)
            {
                articleLabel = [NSString stringWithFormat:@"%@%@", [articleLabel substringToIndex:9], @"..." ];
            }
            articleLabel = [NSString stringWithFormat:@"%@%@", articleLabel, @" >"];
            //add the new breadcrumbs, followed by the elipsis to return to the civi right-shifted mode
            [bread setItems:[NSArray arrayWithObjects:[self generateCrumb:label], [self generateCrumb:articleLabel], [self generateCrumb:@"..."], nil] animated:NO/*(currentStackSize==1)*/];
        }
        else if(index < currentStackSize-7)
        {
            //Process a regular touch in the right-shifted mode
            [self.civiVC reloadWithArticle:[NSString stringWithFormat:@"%@",[[[self.articleVC intakeData] objectAtIndex:lastArticle] objectForKey:@"id"]] atLevel:index-1 andCenter:[NSString stringWithFormat:@"%@", [[NSArray arrayWithObjects:[NSNumber numberWithInteger:issueIndex], [NSNumber numberWithInteger:causeIndex], [NSNumber numberWithInteger:solutionIndex], nil] objectAtIndex:index-1]]];
            NSLog(@"After Scroll-back, civiSelection mode is now %@", [self.civiVC selectionMode]);
			[self switchToView:2];
        }
    }
}
-(void)categoryTouch:(NSNumber*)index //process a category selection, and prepare the article view
{
    NSLog(@"View controller notified of category selection at %@", index);
    
    if([index integerValue] != last){
        NSString* label = [[[self.categoryVC categories] objectAtIndex:[index integerValue]] objectForKey:@"name"];
        if([label length] > 15) //or something
        {
            label = [NSString stringWithFormat:@"%@%@", [label substringToIndex:13], @"..." ];
        }
        label = [NSString stringWithFormat:@"%@%@", label, @" >"];
        [bread setItems:[NSArray arrayWithObjects:[self generateCrumb:label], [self generateCrumb:@"Choose article"], nil] animated:YES/*(currentStackSize==0)*/];
        last = [index integerValue];
    }
    currentStackSize = 1;
    //now move to article mode
    //Reload the articleVC using the id of the selected category
    [self.articleVC reloadUsingCategory:[NSString stringWithFormat:@"%@", [[[self.categoryVC categories] objectAtIndex:[index integerValue]] objectForKey:@"id"]]];
    [self switchToView:1];
}
-(void)articleTouch:(NSNumber *)index
{
    NSLog(@"View controller notified of article selection at %@", index);
    NSString* label = [[[self.categoryVC categories] objectAtIndex:last] objectForKey:@"name"];
    if([label length] > 8) //or something
    {
        label = [NSString stringWithFormat:@"%@%@", [label substringToIndex:5], @"..." ];
    }
    label = [NSString stringWithFormat:@"%@%@", label, @" >"];
    NSString* articleLabel = [[self.articleVC articles] objectAtIndex:[index integerValue]];
    if([articleLabel length] > 15) //or something
    {
        articleLabel = [NSString stringWithFormat:@"%@%@", [articleLabel substringToIndex:13], @"..." ];
    }
    articleLabel = [NSString stringWithFormat:@"%@%@", articleLabel, @" >"];
    
    [bread setItems:[NSArray arrayWithObjects:[self generateCrumb:label], [self generateCrumb:articleLabel], [self generateCrumb:@"Choose Issue"], nil] animated:YES/*(currentStackSize==1)*/];
    currentStackSize = 2;
    lastArticle = [index integerValue];
    NSString* articleID = [NSString stringWithFormat:@"%@",[[[self.articleVC intakeData] objectAtIndex:[index integerValue]] objectForKey:@"id"]];
    [self.civiVC reloadWithArticle:articleID atLevel:0];
    [self switchToView:2];
    [self.civiVC reloadWithArticle:articleID atLevel:0];
    //something something issue prep
    //[self switchToView:2];
}
-(void)civiTouch:(NSNumber *)index
{
    NSLog(@"Civi Touch recognized at %@, in mode %@", index, [self.civiVC selectionMode]);
    NSString* choice;
    //NSString* label;
    NSMutableArray* labels = [[NSMutableArray alloc] initWithObjects:[self generateCrumb:@"...>"], nil];
    switch([[self.civiVC selectionMode] intValue])
    {
        case 0:
            issueIndex = [index integerValue];
            choice = @"Choose Cause";
            currentStackSize = 10;
            [labels addObject:[self generateCrumb:@"Issue >"]];
            break;
        case 1:
            causeIndex = [index integerValue];
            choice = @"Choose Solution";
            currentStackSize = 11;
            [labels addObject:[self generateCrumb:@"Issue >"]];
            [labels addObject:[self generateCrumb:@"Cause >"]];
            break;
        case 2:
            solutionIndex = [index integerValue];
            choice = @"";
            currentStackSize = 12;
            [labels addObject:[self generateCrumb:@"Issue >"]];
            [labels addObject:[self generateCrumb:@"Cause >"]];
            [labels addObject:[self generateCrumb:@"Solution"]];
            break;
    }
    NSInteger level = [[self.civiVC selectionMode] integerValue]+1;
    if(level >=3) level = 2;
    [self.civiVC reloadWithArticle:[NSString stringWithFormat:@"%@",[[[self.articleVC intakeData] objectAtIndex:lastArticle] objectForKey:@"id"]] atLevel:level andCenter:[NSString stringWithFormat:@"%@", index]];
    //Now we set the stack height to an auxilliary setting
    //currentStackSize = 10; //10=choosing cause 11= choosing solution 12+ = I don't know
    [labels addObject:[self generateCrumb:choice]];
    //[bread setItems:[NSArray arrayWithObjects:[self generateCrumb:@"...>"], [self generateCrumb:[NSString stringWithFormat:@"%@ >", label]], [self generateCrumb:@"Choose Cause"], nil]];
    [bread setItems:labels animated:YES];
    NSLog(@"Civi selection mode is now %@", [self.civiVC selectionMode]);
}
 -(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"View controller (as delegate) notified of selection at %d", indexPath.row);
}
@end
