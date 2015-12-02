//
//  CiviSelectionViewController.m
//  Civi_Frontend_Zeqi
//
//  Created by Aaron Graubert on 11/28/15.
//  Copyright (c) 2015 Labuser. All rights reserved.
//

#import "CiviSelectionViewController.h"
#import "WebInterface.h"
#import "CategoryCell.h"

@interface CiviSelectionViewController ()

@end

@implementation CiviSelectionViewController
@synthesize notificationTarget;
@synthesize selectionMode;
@synthesize civis;
@synthesize selections;

BOOL isRendered = NO;
NSInteger l1LoadedFor=-1;
NSInteger l2LoadedFor=-1;
NSNumber *currentLinkingCenter;

- (void)viewDidLoad {
    [super viewDidLoad];
	currentLinkingCenter = [NSNumber numberWithInt:-1];
    NSLog(@"CiviSelection VC did load");
    [[self myCollection] registerClass:[CategoryCell class] forCellWithReuseIdentifier:@"civiCell"];
    self.selectionMode = [NSNumber numberWithInt:0]; //Issue
    [[self myText] setText:@""];
    [[self myText] setBackgroundColor:[UIColor colorWithRed:251.0/255.0 green:200.0/255.0 blue:255.0/255.0 alpha:1.0]];
    [[self myCollection] setBackgroundColor: [UIColor colorWithRed:246.0/255.0 green:230.0/255.0 blue:254.0/255.0 alpha:1.0]];
    [[self myView] setBackgroundColor: [UIColor colorWithRed:246.0/255.0 green:230.0/255.0 blue:254.0/255.0 alpha:1.0]];
    //a dictionary of selection modes (issue, cause, solution).  Each mode contains an array of civis.
    //Each civi is a dictionary of data for the civi.
    
    
    self.civis = [[NSMutableDictionary alloc] initWithCapacity:3];
    isRendered = YES;
    self.lastArticle = @"__FakeArticle__";
    self.selections = [[NSMutableArray alloc] initWithCapacity:3];
	//[self.view addGestureRecognizer:[self.rightSwipe initWithTarget:self action:@selector(handleRightSwipe:)]];
	[self.rightSwipe addTarget:self action:@selector(handleRightSwipe:)];
	[self.leftSwipe addTarget:self action:@selector(handleLeftSwipe:)];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"civiCell" forIndexPath:indexPath];
	NSDictionary* civi = [[[self civis] objectForKey:self.selectionMode] objectAtIndex:indexPath.row];
	UIColor *c = [UIColor blackColor];
	if([currentLinkingCenter intValue]!=-1 && [currentLinkingCenter isEqualToNumber:[civi objectForKey:@"_relativeCenter"]])
	{
		if([[civi objectForKey:@"_relativeStance"] isEqualToNumber:[NSNumber numberWithInt:-1]]) c = [UIColor redColor];
		else if([[civi objectForKey:@"_relativeStance"] isEqualToNumber:[NSNumber numberWithInt:1]]) c = [UIColor greenColor];
	}
	[cell setText:[civi objectForKey:@"title"] withColor:c];
    //NSLog(@"Frame: (%f, %f)", cell.frame.size.width, cell.frame.size.height);
    return cell;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"Query for items in section returns %u items", [[self.civis objectForKey:self.selectionMode] count]);
    return [[self.civis objectForKey:self.selectionMode] count];
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Processes a user's selection.
    //The first time a cell is selected, it's contents are rendered (ie: the civi is displayed in full)
    //If the same cell is selected again, then we notify the view controller of the selection
    //NSMutableDictionary* record = [self.selections objectAtIndex:[self.selectionMode integerValue]];
    NSMutableDictionary* record = ([self.selectionMode integerValue]<[self.selections count])?[self.selections objectAtIndex:[self.selectionMode integerValue]]:nil; //check if record exists
    if(record==nil || [[record objectForKey:@"title"] isEqual:[NSNull null]] || [[record objectForKey:@"title"] compare:[[[[self civis] objectForKey:self.selectionMode] objectAtIndex:indexPath.row] objectForKey:@"title"]]!=NSOrderedSame)
    {
        //The record does not exist, or is of a different civi.  This is NOT primed
        //This means that this is the first time that this cell has been selected
        NSLog(@"Priming civi selection in mode %@ at civi %u", self.selectionMode, indexPath.row);
        NSDictionary* CiviTemp = [[self.civis objectForKey:self.selectionMode] objectAtIndex:indexPath.row];
        //Format recordBody however you wish, I just threw this together
        NSString* recordBody = [NSString stringWithFormat:@"Selected Civi:\n%@\nType: %@ \n\nBy %@\n%@ visits\n\n%@", [CiviTemp objectForKey:@"title"], [CiviTemp objectForKey:@"type"], [CiviTemp objectForKey:@"author"], [CiviTemp objectForKey:@"visits"],[CiviTemp objectForKey:@"body"]];
        
        if(record==nil) record=[[NSMutableDictionary alloc] init]; //Initialize the record if it didn't exist before
        //The following code transfers important information (title, body, id, type) into a permanent record
        [record setObject:[CiviTemp objectForKey:@"title"] forKey:@"title"];
        [record setObject:recordBody forKey:@"body"];
		[record setObject:[NSNumber numberWithBool:NO] forKey:@"_selectionOverride"];
        [record setObject:[CiviTemp objectForKey:@"id"] forKey:@"id"];
        [record setObject:[CiviTemp objectForKey:@"type"] forKey:@"type"];
        [self.myText setText:recordBody]; //this is also, just a simplified display mode.
        [self.selections setObject:record atIndexedSubscript:[self.selectionMode integerValue]];
    }
    else if([[record objectForKey:@"_selectionOverride"] isEqualToNumber:[NSNumber numberWithBool:NO]])
    {
        //This is the second time this civi has been selected
        NSLog(@"Selection in mode %@ at civi %u is already primed.  Pushing notification", self.selectionMode, indexPath.row);
		[record setObject:[NSNumber numberWithBool:YES] forKey:@"_selectionOverride"];
        //ignore the warning below.  The code works, but Xcode can't tell that the target supports civiTouch:
        [self.notificationTarget performSelector:@selector(civiTouch:) withObject:[NSNumber numberWithInteger:indexPath.row]];
    }
	else
	{
		NSLog(@"Skipping prefired selection");
	}
    //[self.notificationTarget performSelector:@selector(civiTouch:) withObject:[NSNumber numberWithInteger:indexPath.row]];
}

-(void)reloadWithArticle:(NSString *)article atLevel:(NSInteger)depth
{
    [self reloadWithArticle:article atLevel:depth andCenter:@"__default__"]; //?
}

-(void)reloadWithArticle:(NSString *)article atLevel:(NSInteger)depth andCenter:(NSString *)center
{
    //Called by the main view controller to reload this view for the current state
    //query database for things
	//NSLog(@"CiviSelector processing reload request (%@, %u, %@).  Selection mode is %@.  Civi Depth Loaded is %u.  Selection depth loaded is %u", article, depth, center, self.selectionMode, [self.civis count], [self.selections count]);
	BOOL skipReload	= [self determineReload:article atLevel:depth andCenter:center];
    if([center compare:@"-1"] == NSOrderedSame && [self.selectionMode integerValue] == depth && depth != 0)
    {
        //This happens if the user hits the breadcrumb for the currently displayed mode, and no selections have been made
        NSLog(@"User attempting to reload into the same mode while no civis are loaded.  Skipping reload");
        return;
    }
	//NSLog(@"Naive reload detection suggests skip: %@", (skipReload?@"YES":@"NO"));
	//NSLog(@"Intelligent reload detection suggests skip: %@", (suggestSkip?@"YES":@"NO"));
	if(!skipReload)
	{
		NSLog(@"Experimentally clearing upstream selections");
		while([self.selections count] > depth) [self.selections removeLastObject];
		if(([self.civis count]==0) || ([self.lastArticle compare:article] != NSOrderedSame))
		{
			NSLog(@"Performing a root reload.");
			self.civis = [[NSMutableDictionary alloc] initWithCapacity:3];
			self.selections = [[NSMutableArray alloc] initWithCapacity:3];
		}
	}
	//if(!skipReload || !onSameDepth) clearLinkingCenter
    NSString* key = nil;
    switch(depth)
    {
        case 0:
            key=@" Issue";
            break;
        case 1:
            key=@" Cause";
            break;
        case 2:
            key=@" Solution";
            break;
    }
    NSInteger oldMode = [self.selectionMode integerValue];
    self.selectionMode = [NSNumber numberWithInteger:depth];
    if(!skipReload)
    {
        //We're not skipping the reload, so fetch data
        if(self.selectionMode ==[NSNumber numberWithInt:0]) //fetch the top 10 Issue civis
        {
            //Since we're requesting issue-type civi's, we need to fetch them from the database
			NSLog(@"Initiating database request for topten");
            NSMutableArray* data = [WebInterface JSONDataFromUrl:@"http://civiwiki.ngrok.io/api/topten" withPOST:[NSString stringWithFormat:@"id=%@", article]];
			for(NSMutableDictionary *civi in data)
			{
				[civi setObject:[NSNumber numberWithInt:0] forKey:@"_relativeStance"];
				[civi setObject:[NSNumber numberWithInt:-1] forKey:@"_relativeCenter"];
			}
            //NSLog(@"Fetched %u items from request", [data count]);
            /*NSPredicate* issueFilter = [NSPredicate predicateWithFormat:@"SELF.type MATCHES %@", @"I"];
             [self.civis setObject:[data filteredArrayUsingPredicate:issueFilter] forKey:[NSNumber numberWithInt:0]];*/
            [self.civis setObject:data forKey:[NSNumber numberWithInt:0]];  //load these civis into the issue slot
        }
        else
        {
            //We're not requesting issue-types, so we have to request linked civis from the selection.
			NSLog(@"Loading new civis for a cause or solution depth");
         
            if(self.selections!=nil){
            NSMutableDictionary* record = [self.selections objectAtIndex:oldMode];
			if(record==nil)
			{
				NSLog(@"No selection record was found for the requested civi");
			}
            //Will replace with actual fetches for the linked civis
            NSLog(@"Request to load linked %@-type civis at center named '%@' with id %@", key, [record objectForKey:@"title"], [record objectForKey:@"id"]);
			NSMutableArray* data = [WebInterface JSONDataFromUrl:@"http://civiwiki.ngrok.io/api/getcivi" withPOST:[NSString stringWithFormat:@"id=%@", [record objectForKey:@"id"]]];
			NSArray* typeKeys = @[@"I", @"C", @"S"];
			for(int i = oldMode; i<3; ++i)
			{
				if(i>0 || [self.civis objectForKey:[NSNumber numberWithInt:i]]==nil) [self.civis setObject:[[NSMutableArray alloc] init] forKey:[NSNumber numberWithInt:i]];
				NSPredicate* typeFilter = [NSPredicate predicateWithFormat:@"SELF.type matches %@", [typeKeys objectAtIndex:i]];
				NSArray* civisAtDepth = [data filteredArrayUsingPredicate:typeFilter];
				NSMutableSet* uniqueCivis = [[NSMutableSet alloc] init];
				
				for(NSDictionary *civi in [self.civis objectForKey:[NSNumber numberWithInt:i]])
				{
					[uniqueCivis addObject:[civi objectForKey:@"id"]];
				}
				for(NSMutableDictionary *civi in civisAtDepth)
				{
					if([uniqueCivis containsObject:[civi objectForKey:@"id"]])
					{
						//shift relative
						NSLog(@"Duplicate Civi ID");
						
					}
					else
					{
						//insert relative
						[uniqueCivis addObject:[civi objectForKey:@"id"]];
						[civi setObject:[NSNumber numberWithInt:0] forKey:@"_relativeStance"];
						[civi setObject:[NSNumber numberWithInt:-1] forKey:@"_relativeCenter"];
						[[self.civis objectForKey:[NSNumber numberWithInt:i]] addObject:civi];
						
					}
				}
			}
            }}
        
    }
    NSLog(@"Loaded %u Civis for mode %@", [[self.civis objectForKey:self.selectionMode] count], self.selectionMode);
    NSMutableDictionary* record = ([self.selectionMode integerValue]<[self.selections count])?[self.selections objectAtIndex:[self.selectionMode integerValue]]:nil;
    //the following is just to display a civi if it's been selected, or show a selection prompt if it hasnt
    if(record==nil)
    {
        [self.myText setText:[NSString stringWithFormat:@"Select a%@", key]];
    }
    else [self.myText setText:[record objectForKey:@"body"]];
    if(isRendered)[self.myCollection reloadData];
    self.lastArticle = article;
}

-(BOOL)determineReload:(NSString *)article atLevel:(NSInteger)depth andCenter:(NSString *)center
{
	NSLog(@"CiviSelector processing reload request (%@, %u, %@).  Selection mode is %@.  Civi Depth Loaded is %u.  Selection depth loaded is %u", article, depth, center, self.selectionMode, [self.civis count], [self.selections count]);
	//If no data is loaded, then clear selections (if any), and load the top ten.  Depth should be 1
	BOOL rootReload = ([self.civis count]==0) || ([self.lastArticle compare:article] != NSOrderedSame);
	NSLog(@"Should reload at root: %@", (rootReload?@"YES":@"NO"));
	BOOL dataLoadedAtDepth = ([self.civis count]>depth);
	BOOL selectionLoadedAtDepth = ([self.selections count]>depth);
	BOOL dataValidAtDepth = (dataLoadedAtDepth);
	if(dataValidAtDepth) dataValidAtDepth = (dataValidAtDepth)&&(!rootReload);
	//if(dataValidAtDepth) dataValidAtDepth = (dataValidAtDepth)&&([self.selections count]>depth);
	if(dataValidAtDepth && depth>=1 && [self.selections count]>=depth)
	{
		NSNumber* compA = [[[self.civis objectForKey:[NSNumber numberWithInteger:depth]] firstObject] objectForKey:@"REF"];
		if(compA == nil || [compA isEqual:[NSNull null]])
		{
			NSLog(@"Error in data.  No reference found  on non-issue type");
			
		}
		else
		{
			dataValidAtDepth = (dataValidAtDepth)&&([compA compare:[[self.selections objectAtIndex:depth-1] objectForKey:@"id"]]==NSOrderedSame);
		}
	}
	NSLog(@"Data loaded at depth: %@", (dataLoadedAtDepth?@"YES":@"NO"));
	NSLog(@"Data valid at depth: %@", (dataValidAtDepth?@"YES":@"NO"));
	NSLog(@"Selection exists at depth: %@", (selectionLoadedAtDepth?@"YES":@"NO"));
	BOOL sameLevel = ([self.selectionMode integerValue]==depth);
	NSLog(@"Selector already at requested depth: %@", (sameLevel?@"YES":@"NO"));
	if(rootReload) NSLog(@"The requested article differs from the last load.  Reload at top ten, then reset to selMode 0");
	else if(dataValidAtDepth && selectionLoadedAtDepth)
	{
		if(sameLevel) NSLog(@"Data is loaded and valid.  Selection is also loaded for this level.  Skip reload, but reset text area");
		else NSLog(@"Data is loaded and valid. Selection is also loaded for this level.  set selMode to requested depth, and reset text area");
		return YES;
	}
	else if(dataValidAtDepth)
	{
		NSLog(@"Data is loaded and valid, but there is no selection.  Replace text area with generic for this depth, and set selMode to requested.");
		return YES;
	}
	else if(dataLoadedAtDepth) NSLog(@"Reload data with getcivi on the issue-level selection.  If there is no issue level selection, perform a root reload");
	else if(depth>=1 && [self.civis count]>=1 && [self.selections count]>=depth)
	{
		NSNumber *ref = [[[self.civis objectForKey:[NSNumber numberWithInteger:depth]] firstObject] objectForKey:@"REF"];
		if(ref==nil || [ref isEqual:[NSNull null]]) NSLog(@"Error in data.  No ref found on non-issue type");
		else if(([[[[self.civis objectForKey:[NSNumber numberWithInteger:depth]] firstObject] objectForKey:@"REF"] compare:[[self.selections objectAtIndex:depth-1] objectForKey:@"id"]]==NSOrderedSame))
		{
			NSLog(@"No data is loaded at this depth, but the lower depths are valid.  Request data using getcivi to populate this level");
		}
	}
	else NSLog(@"Situation Unknown");
	return NO;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int len = [[[[[self civis] objectForKey:self.selectionMode] objectAtIndex:indexPath.row] objectForKey:@"title"] length];
    return CGSizeMake(10.0+(8.0*len)+(len>10?10.0:0.0), 50.0);
}

/*- (IBAction)swipeGesture:(id)sender {
	NSLog(@"Handle Gesture");
	
}

-(void)handleSwipe:(UIScreenEdgePanGestureRecognizer*)sgr
{
	NSLog(@"Handle Swipe");
}*/

-(void)handleRightSwipe:(UISwipeGestureRecognizer*)sgr
{
	NSLog(@"Right Swipe"); //Load &-
}

-(void)handleLeftSwipe:(UISwipeGestureRecognizer*)sgr
{
	NSLog(@"Left Swipe"); //Load &+
	//1:Check selection exists at current layer
	//2:Check selection id exists in current layer civis
	//3:Check if selected civi in data contains &+
	//4:If &+ not defined, request civi
	//5:If &+ is null, alert?
	//6:Otherwise, check if &+ exists in current layer
	//7:if it does, move it.  Otherwise, insert on right
	//8:Once inserted, generate a selection record and switch text
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
