//
//  CDCSolsTableViewController.m
//  Rover
//
//  Created by Collin Cannavo on 6/28/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

#import "CDCSolsTableViewController.h"
#import "Rover.h"
#import "SolDescription.h"
#import "CDCPhotosCollectionViewController.h"


@interface CDCSolsTableViewController ()


@end

@implementation CDCSolsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.rovers.solDescriptions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"solDetailsCell" forIndexPath:indexPath];
    
    SolDescription *sol = self.rovers.solDescriptions[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Sol %@", @(sol.sol)];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Photos", @(sol.numberOfPhotos)];
    
    return cell;
}

-(void)setRover:(Rover *)rover
{
    if (rover != _rovers){
        _rovers = rover;
        [self.tableView reloadData];
    }
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toPhotoCollection"]) {
        CDCPhotosCollectionViewController *vc = (CDCPhotosCollectionViewController *)segue.destinationViewController;
        vc.rover = self.rovers;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        vc.sol = self.rovers.solDescriptions[indexPath.row];
        
    }
    
}


@end
