//
//  ContactsTableViewController.m
//  Invite
//
//  Created by Yifan Wang on 16/1/7.
//  Copyright © 2016年 Yifan Wang. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "RateViewController.h"

@interface ContactsTableViewController ()

@end

@implementation ContactsTableViewController


-(void)loadData{
    
    self.indexTitles = [UILocalizedIndexedCollation.currentCollation sectionIndexTitles];
    self.userManager = [[ParseUserManager alloc]init];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.sectionIndexColor = [UIColor blackColor];
    [[self tableView] setSectionIndexBackgroundColor:[UIColor clearColor]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self loadData];
    [self showActivityView];
    
 
    [self.userManager setFriendRelationArray:@selector(hideActivityView) sender:self];
    
    NSLog(@"%@",self.userManager.contactDictionary);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.indexTitles count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSMutableArray *arr =[self.userManager.contactDictionary objectForKey:[self.indexTitles objectAtIndex:section]];
    if ( [arr count] == 0) {
        return @"";
    }else{
        return [self.indexTitles objectAtIndex:section];
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSMutableArray *arr = [self.userManager.contactDictionary objectForKey:[self.indexTitles objectAtIndex:section]];
    
    return [arr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    cell.textLabel.text = [self.userManager.contactDictionary objectForKey:[self.indexTitles objectAtIndex:indexPath.section]][indexPath.row];
    
       return cell;
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexTitles;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.selectedUser = [self.userManager.contactDictionary objectForKey:[self.indexTitles objectAtIndex:indexPath.section]][indexPath.row];
    NSLog(@"%@",self.selectedUser);
    [self performSegueWithIdentifier:@"showRate" sender:self];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}


#pragma mark -helper methods

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void) showActivityView {
    if (self.activityView==nil) {
        self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
        [self.tableView addSubview:self.activityView];
        self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        self.activityView.color = [UIColor redColor];
        self.activityView.hidesWhenStopped = YES;
        // additional setup...
        // self.activityView.color = [UIColor redColor];
    }
    // Center
    CGFloat x = UIScreen.mainScreen.applicationFrame.size.width/2;
    CGFloat y = UIScreen.mainScreen.applicationFrame.size.height/2;
    // Offset. If tableView has been scrolled
    CGFloat yOffset = self.tableView.contentOffset.y;
    self.activityView.frame = CGRectMake(x, y + yOffset, 0, 0);
    
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
}


- (void) hideActivityView {
    
    
    [self.tableView reloadData];

    [self.activityView stopAnimating];
}

- (IBAction)seeRequest:(id)sender {
    
    [self performSegueWithIdentifier:@"showRequest" sender:self];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"showRate"]) {
        RateViewController *vc = (RateViewController *)[segue destinationViewController];
        
        vc.selectedUser = self.selectedUser;
        
    }
}

@end
