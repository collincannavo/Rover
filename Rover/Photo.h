//
//  Photo.h
//  Rover
//
//  Created by Collin Cannavo on 6/27/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly)NSInteger *identifier;
@property (nonatomic, readonly)NSInteger *sol;
@property (nonatomic, readonly, copy)NSString *cameraName;
@property (nonatomic, readonly, copy)NSDate *earthDate;
@property (nonatomic, readonly, copy)NSURL *imageURL;

@end
