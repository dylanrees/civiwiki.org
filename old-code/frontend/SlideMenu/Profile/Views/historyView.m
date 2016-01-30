//
//  historyView.m
//  cw_user
//
//  Created by JL on 11/22/15.
//  Copyright © 2015 JL. All rights reserved.
//

#import "historyView.h"
@interface historyView ()
{
    
}
@property NSMutableArray *array;
@property UITableView *table;
@end

@implementation historyView
@synthesize array;
@synthesize table;
@synthesize history;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id) init
{
    self = [super init];
    
    return self;
}
-(id) initWithArray:(NSMutableArray *) history_list
{
    self = [self init];
    history = [[NSMutableArray alloc]init];
    if (self)
    {
        for (NSString *username in history_list) {
            // do something with object
            [history addObject:username];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    table = [[UITableView alloc] init];
    
    // Default static object as a placeholder
    array = [[NSMutableArray alloc]
             initWithObjects:@"A very interesting civi", @"Civi with lots of media", @"A random civi", @"Most popular civi", @"Civi about immigration",@"Controversial Civi", @"Personal civi with an agenda", @"Extra civi lying around", @"Everyone-agrees-with-this civi", @"Last civi",nil];
    [table addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
    table.backgroundColor = [UIColor clearColor];
    //self.tableView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:table];
    //[self.tableView sizeToFit];
    //[table sizeToFit];
    //self.tableView.frame = CGRectMake(0, 50, self.view.frame.size.width, 1000);
    //self.view.frame = table.contentSize;
    self.view.backgroundColor = [UIColor clearColor];
    UIView *footer = [[UIView alloc] initWithFrame: CGRectZero];//CGRectMake(0, 0, self.view.frame.size.width, 10)];//CGRectZero];
   
    [self.tableView setTableFooterView:footer];
    //self.view.frame =CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, table.contentSize.height - 200);
    //self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44.0f, 0);
    //table.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, table.frame.size.width, table.contentSize.height + 20);
    //self.tableView.tableFooterView.frame = self.view.frame;
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CGRect frame = table.frame;
    frame.size = table.contentSize;
    table.frame = frame;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count =(int) [history count];
    CGRect frame = table.frame;
    frame.origin.y = 50;
    frame.size.height = (count * 44);
    frame.size.width = self.view.frame.size.width;
   //NSLog(@"h_frame: %f %f %f %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    
    [table setFrame:frame];
    [self.tableView setFrame:frame];
    [self.view setFrame:frame];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *cellText= [NSString stringWithFormat:@"%@", [history objectAtIndex:indexPath.row]];
    cell.textLabel.text = cellText;
    return cell;
}

@end
