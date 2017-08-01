//
//  CDCPhotosCollectionViewController.h
//  Rover
//
//  Created by Collin Cannavo on 6/28/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rover.h"
#import "SolDescription.h"

@interface CDCPhotosCollectionViewController : UICollectionViewController

@property (nonatomic) Rover *rover;
@property (nonatomic) SolDescription *sol;



@end
