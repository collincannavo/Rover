//
//  Rover.h
//  Rover
//
//  Created by Collin Cannavo on 6/27/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RoverStatus)
{
    RoverStatusActive,
    RoverStatusComplete,
    
};


@interface Rover : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong, readonly)NSString *name;
@property (nonatomic, strong, readonly)NSDate *launchDate;
@property (nonatomic, strong, readonly)NSDate *landingDate;
@property (nonatomic, readonly)NSInteger *maxSol;
@property (nonatomic, strong, readonly)NSDate *maxDate;
@property (nonatomic, readonly) RoverStatus *roverStatus;
@property (nonatomic, readonly)NSInteger *numberOfPhotos;
@property (nonatomic, strong, readonly)NSArray *solDescriptions;


@end
