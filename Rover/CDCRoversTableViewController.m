//
//  CDCRoversTableViewController.m
//  Rover
//
//  Created by Collin Cannavo on 6/28/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//
#import "Rover.h"
#import "CDCRoverController.h"
#import "CDCMarsRoverClient.h"
#import "CDCRoversTableViewController.h"
#import "CDCSolsTableViewController.h"

@interface CDCRoversTableViewController ()



@property (nonatomic, copy) NSArray *rovers;

@end

@implementation CDCRoversTableViewController

- (void)viewDidLoad

{
    [super viewDidLoad];
    
    NSMutableArray *rovers = [NSMutableArray array];
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    CDCMarsRoverClient *client = [[CDCMarsRoverClient alloc] init];
    [client fetchAllMarsRoversWithCompletion:^(NSArray *roverNames, NSError *error) {
        if (error) {
            NSLog(@"Error fetching list of mars rovers: %@", error);
            return;
        }
        for (NSString *name in roverNames) {
            
            [client fetchMissionManifestForRoverNamed:name completion:^(Rover *rover, NSError *error) {
                if (error) {
                    NSLog(@"Error fetching list of mars rovers: %@", error);
                    return;
                }
               { [rovers addObject:rover]; };
            }];
        }
    }];
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    self.rovers = rovers;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.rovers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoverCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.rovers[indexPath.row] name];
    
    return cell;
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"toSolsList"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Rover *rover = [CDCRoverController sharedInstance].rovers[indexPath.row];
        CDCSolsTableViewController *dvc = (CDCSolsTableViewController *)segue.destinationViewController;
        dvc.rovers = rover;
    }
}


@end


















