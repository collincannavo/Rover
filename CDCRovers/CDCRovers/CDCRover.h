//
//  CDCRover.h
//  CDCRovers
//
//  Created by Collin Cannavo on 7/4/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RoverStatus)
{
    RoverStatusActive,
    RoverStatusComplete
    
    
};



@interface CDCRover : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy)NSString *name;
@property (nonatomic)NSDate *launchDate;
@property (nonatomic)NSDate *landingDate;
@property (nonatomic)NSInteger maxSol;
@property (nonatomic)NSDate *maxDateOnEarth;
@property (nonatomic)NSInteger photos;
@property (nonatomic)NSArray<NSString *> *solDescriptions;
@property (nonatomic)RoverStatus *roverStatus;


@end
