//
//  CDCRoverController.h
//  Rover
//
//  Created by Collin Cannavo on 6/27/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Rover;

NS_ASSUME_NONNULL_BEGIN

@interface CDCRoverController : NSObject

+(CDCRoverController *)sharedInstance;
-(instancetype)init;

+ (void)fetchRovers:(NSString *)name completion:(void(^_Nullable) (Rover * _Nullable)) completion;

- (NSArray *)rovers;

@end

NS_ASSUME_NONNULL_END
